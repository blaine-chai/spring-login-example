package com.blainechai.controller.api;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;
import java.util.ArrayList;


public class SocketComm extends Thread 
{
	private Socket socket = null;
	
	private String userID = "1";
	private String ip = "127.0.0.1";
	private int port = 3000;
	private DataOutputStream dos = null;
	private DataInputStream dis = null;

	private boolean good = false;
	private boolean isConnect = false;
	private int ddl = 0;
	private int page = 0;
	
	private int keyCount = -1;	
	private int viewCount = -1;	
	private ArrayList<String> keySet = new ArrayList<String>();	
	private String[][] r = null;
	
	public SocketComm(int ddl) {		
		initialClientRun(ddl);
	}	
	
	public SocketComm(int ddl, int page) {		
		this.page = page;
		initialClientRun(ddl);
	}	
	
	public void initialClientRun(int ddl) {		
		this.ddl = ddl;
		try {
			this.socket = new Socket(ip, port);
			this.userID = userID;
			this.ddl = ddl;
		
			dos = new DataOutputStream(socket.getOutputStream());
			dis = new DataInputStream(socket.getInputStream());
			isConnect = true;
		} 
		catch (IOException e) { System.out.println("서버 연결 실패"); }
	}
	
	public int getKeyCount() { return keyCount; }	
	public int getViewCount() { return viewCount; }
	public String[][] getR() { return r; }
	public ArrayList<String> getKetSet() { return keySet; }
	
	public boolean beGetGood() { return good; }
	
	public void reqQUERY()
	{
		try 
		{
			int k = 3;
			dos.writeInt(k);
	
			for (int i=0; i < k; i++) dos.writeUTF("query" + i);
			good = true;
		} 
		catch (IOException e) { System.out.println(e); }
	}

	public void reqVIEW() throws IOException
	{		
		dos.writeInt(page); 		

		// count 수신
		int cnt = dis.readInt();
		
		if (cnt >= 0) {	// 검색내용 수신
			r = new String[cnt][12];
			for (int i=0; i < r.length; i++) {
				for (int j=0; j < r[i].length; j++) r[i][j] = dis.readUTF();
			}		
			//initalizeNode(r, searchWord.getText());
			good = true;
		}
		else			// 검색결과가 준비되지 않았음.
			System.out.println("\treqVIEW is Not Ready");
	}

	public void reqKEYS() throws IOException
	{		
		keyCount = dis.readInt();

		if (keyCount >= 0) {	// 검색내용 수신
			keySet.clear();
			for (int i=0; i < keyCount; i++)	{
				keySet.add(dis.readUTF());
			}
			good = true;
		}
		else			// 검색결과가 준비되지 않았음.
			System.out.println("\treqKEYS is Not Ready");
	}

	public void reqCOUNT() throws IOException
	{
		if(dis.readBoolean()) {
			good = true;
			System.out.println("\treqCOUNT : Good Change!");
		}
		viewCount = dis.readInt();

		System.out.println("\t>>> " + good);
	}
		
	public void run() 
	{
		try 
		{
			long time = System.currentTimeMillis();
			
			dos.writeUTF(userID); 			// userID 전송
							
			if (ddl == 0) {					// QUERY
				dos.writeBoolean(true);
				dos.writeUTF("QUERY");					
				reqQUERY();
			}
			else  if (ddl == 1) {			// QUERY2
				dos.writeBoolean(true);
				dos.writeUTF("QUERY2");
				reqQUERY();
			}
			else  if (ddl == 2) {			// VIEW
				dos.writeBoolean(false);
				dos.writeUTF("VIEW");
				reqVIEW();
			}
			else  if (ddl == 3) {			// KEYS
				dos.writeBoolean(false);
				dos.writeUTF("KEYS");
				reqKEYS();
			}
			else  if (ddl == 4) {			// COUNT
				dos.writeBoolean(false);
				dos.writeUTF("COUNT");
				reqCOUNT();
			}
			else  if (ddl == 5) {			// STOP
				dos.writeBoolean(false);
				dos.writeUTF("STOP");
			}
			
			System.out.println("\t"+ ddl + " :: " + good + " :: " + (System.currentTimeMillis()-time));		
		} 
		catch (IOException e) {
			System.out.println("\t\t\t\t\tEEEEEEEEEEEEEEEE");
			e.printStackTrace(); 
		} 
		finally 
		{
			try {
				dos.close();
				socket.close();
			} catch (IOException e) {e.printStackTrace();}
		}
	}
}
