package com.blainechai.controller.api;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.blainechai.constant.Constant;
import com.blainechai.model.AuthorBookContent;
import com.blainechai.model.BookInfo;
import com.blainechai.model.RelAuthorInfo;

public class SocketComm
{
	private Socket socket = null;

	private String userID = "1";
	//private String ip = "127.0.0.1";
	private String ip = "10.10.10.1";

	private int port = 3000;
	private DataOutputStream dos = null;
	private DataInputStream dis = null;

	private int good = -1;
	private int sel = 0;
	private int page = 0;
	private String msg = "";

	//private int progress = 0;
	private int proPercent = -1;
	private int keyCount = -1;
	private int viewCount = -1;
	private ArrayList<String> keySet = new ArrayList<String>();
	private String[][] r = null;
	private ArrayList<String> from = new ArrayList<String>();
	private String[] statTime = null;
	private int[] stat = null;

	long time = System.currentTimeMillis();

	public SocketComm(String ip, int port, int sel) {

		this.ip = ip;
		this.port = port;

		initialClientRun(sel);
	}

	//public SocketComm(int sel, int page) {
	//	this.page = page;
	//	initialClientRun(sel);
	//}

	public SocketComm(String userID, String ip, int port, int sel, int page) {
		this.userID = userID;
		this.ip = ip;
		this.port = port;
		this.page = page;

		initialClientRun(sel);
	}

	public SocketComm(String userID, String ip, int port, int sel, int page, String msg) {
		this.userID = userID;
		this.ip = ip;
		this.port = port;
		this.page = page;
		this.msg = msg;

		initialClientRun(sel);
	}

	public void initialClientRun(int sel) {
		this.sel = sel;

		try {
			this.socket = new Socket(ip, port);

			dos = new DataOutputStream(socket.getOutputStream());
			dis = new DataInputStream(socket.getInputStream());
		}
		catch (IOException e) { System.out.println("SocketComm.java : 서버 연결 실패"); }
	}

	public int getKeyCount() { return keyCount; }
	public int getProPercent() { return proPercent; }
	public int getCount() { return viewCount;	}

	public List<BookInfo> getR()
	{
		List<BookInfo> bookInfoList = new ArrayList<BookInfo>();

		bookInfoList.clear();
		for (int i = 0; i < r.length; i++) {
			bookInfoList.add(new BookInfo(r[i]));
		}
		return bookInfoList;
	}

	public List<RelAuthorInfo> getQ(String id)
	{
		List<RelAuthorInfo> resultList = new ArrayList<RelAuthorInfo>();
		System.out.println("\t :333: " + (System.currentTimeMillis()-time));

		resultList.clear();
		for (int i = 0; i < r.length; i++) {
			int num = Integer.parseInt(r[i][1]) + Integer.parseInt(r[i][2]);
			if(num == 0) continue;
			r[i][1] = num + "";
			r[i][2] = id + "_" + i;
			resultList.add(new RelAuthorInfo(r[i]));
			System.out.println(r[i][0] + " :33: " + r[i][2]);
		}

		System.out.println("\t :444: " + resultList.size() + " : " + (System.currentTimeMillis()-time));
		return resultList;
	}

	public List<AuthorBookContent> getS()
	{
		List<AuthorBookContent> resultList = new ArrayList<AuthorBookContent>(); //메인 서버에서의 검색 결과
		System.out.println("\t :555: " + (System.currentTimeMillis()-time));

		resultList.clear();
		for (int i = 0; i < r.length; i++) {
			resultList.add(new AuthorBookContent(r[i]));
		}

		System.out.println("\t :666: " + (System.currentTimeMillis()-time));
		return resultList;
	}

	public int[] getStatitcs()
	{
		return stat;
	}

	public String[] getStatitcsTime()
	{
		return statTime;
	}

	public String getKetSet() {
		String html = "";
		for (int i=0; i < keyCount; i++)	{
			html += "<tr><td><input type='checkbox'></td><td>" + keySet.get(i) + "</td></tr>";
		}

		System.out.println("getKetSet ::: " + html);
		return html;
	}

	public String getPriority() 				// priority
	{
		String html = "<select>";
		for(int j=1; j < 10; j++) {
			if(page != j) html += "<option>" + j + "</option>";
			else html += "<option selected>" + j + "</option>";
		}
		html += "</select>";

		System.out.println("getPriority ::: " + html);
		return html;
	}

	public String[] getFrom()
	{

		for(int i=from.size()-1; i >= 0; i--) {
			if(from.get(i).equals("")) from.remove(i);
		}
		System.out.println(":AAAAAAAAAA: " + from.size());

		String[] from1 = new String[from.size()];
		for(int i=0; i < from.size(); i++) from1[i] = from.get(i);
		//System.out.println(key + " :AAAAAAAAAA: " + from.get(0));

		return from1;
	}

	public int beGetGood() { return good; }

	public String formattedDate	(long unixTime)
	{
		String toFormatString = "yyyyMMddHHmmss";

		Date date = new Date(unixTime);
		SimpleDateFormat toFormat = new SimpleDateFormat(toFormatString);

		return toFormat.format(date);
	}

	public void reqQUERY()
	{
		try
		{
			System.out.println("\tmsg : " + msg);
			int k = 5;
			dos.writeInt(k);

			String[] sss = msg.split(">");
			System.out.println(sss.length + " : ");

			if(sss[3].equals("ALL")) {
				sss[2] = getPeriod("-");
				sss[3] = "MSG";
			}
			else 		sss[2] = getPeriod(sss[2]);

			for (int i=0; i < k; i++) {
				System.out.println("\tmsg333 : " + sss[i]);
				dos.writeUTF(sss[i]);
			}
			good = 0;
		}
		catch (IOException e) { System.out.println(e); }
	}

	public void reqVIEW() throws IOException
	{
		dos.writeInt(page);
		// count 수신
		int cnt = dis.readInt();

		if (cnt >= 0) {	// 검색내용 수신
			r = new String[cnt][13];
			for (int i=0; i < r.length; i++) {
				for (int j=0; j < r[i].length; j++) r[i][j] = dis.readUTF();
			}
		}
		good = cnt;
	}

	public void reqKEYS() throws IOException
	{
		keyCount = dis.readInt();

		if (keyCount >= 0) {	// 검색내용 수신
			keySet.clear();
			for (int i=0; i < keyCount; i++)	{
				keySet.add(dis.readUTF());
			}
		}
		good = keyCount;
		//else			// 검색결과가 준비되지 않았음.
		//	System.out.println("\treqKEYS is Not Ready");
	}

	public void reqCOUNT() throws IOException
	{
		if(dis.readBoolean()) {
			viewCount = dis.readInt();
			proPercent = 100;
			System.out.println("true : " + viewCount);
		}
		else {
			viewCount = dis.readInt();
			proPercent = dis.readInt();
			if (viewCount==-2) proPercent = 100;
			System.out.println(viewCount + " : false : " + proPercent);
		}
		good = viewCount;
	}

	public void reqCheckR() throws IOException
	{
		System.out.println("msg = " + msg);
		//String[] s = msg.split(">");

		//dos.writeUTF(msg);
		//dos.writeUTF("t");
		good = 0;
	}

	public void reqExport() throws IOException
	{
		System.out.println("msg = " + msg);
		String[] s = msg.split(">");

		if(s[4].equals("ALL")) {
			s[3] = getPeriod("-");
			s[4] = "MSG";
		}
		else 		s[3] = getPeriod(s[3]);

		msg = s[0] + ">" + s[1] + ">" + s[2] + ">" + s[3] + ">" + s[4];
		System.out.println("msg = " + msg);

		dos.writeUTF(msg);
		//dos.writeUTF(s[1]);
		good = 0;
	}

	public void reqRead() throws IOException
	{
		System.out.println("msg = " + msg);
		dos.writeUTF(msg);
		good = 0;
	}

	public void reqPri() throws IOException
	{
		System.out.println("msg = " + msg);
		String[] s = msg.split(">");
		dos.writeUTF(s[0]);
		dos.writeInt(Integer.parseInt(s[1]));
		dos.writeInt(Integer.parseInt(s[2]));
		good = 0;
	}

	public void reqProfile() throws IOException
	{
		System.out.println("reqProfile :: msg = " + msg);
		String[] s = msg.split(">");
		dos.writeUTF("indexB^" + s[0].split("\\(")[0]);

		if(s[2].equals("ALL")) {
			s[1] = getPeriod("-");
			s[2] = "MSG";
		}
		else
			s[1] = getPeriod(s[1]);
		//s[1] = getPeriod("-");

		dos.writeUTF(s[1]);
		dos.writeUTF(s[2]);
		dos.writeUTF(s[3]);

		System.out.println("reqProfile :: msg = " + msg + " :: " + s[1]);

		//dos.writeBoolean(true);
		good = 0;
	}

	public void reqGetProfile() throws IOException
	{
		int cnt = dis.readInt();

		if (cnt >= 0) {	// 검색내용 수신
			r = new String[cnt][3];
			for (int i=0; i < r.length; i++) {
				for (int j=0; j < r[i].length; j++) r[i][j] = dis.readUTF();
			}
			//initalizeNode(r, searchWord.getText());
		}
		good = cnt;
		//else			// 검색결과가 준비되지 않았음.
		System.out.println("SocketComm.java : reqGetProfile : " + cnt);
	}

	public void reqFrom() throws IOException
	{
		System.out.println("msg = " + msg);
		String[] s = msg.split(">");
		dos.writeUTF(s[0]);
		dos.writeUTF(s[1]);
		//dos.writeBoolean(true);
		good = 0;
	}

	public void reqGetFrom() throws IOException
	{
		int cnt = dis.readInt();

		if (cnt >= 0) {	// 검색내용 수신
			for (int i=0; i < cnt; i++) {
				from.add(dis.readUTF());
			}
		}
		good = cnt;
		System.out.println("SocketComm.java : reqGetFrom : " + cnt);
	}

	public void reqStat1()
	{
		try
		{
			System.out.println("\treqStat1 : msg : " + msg);
			int k = 2;
			//dos.writeInt(2);

			String[] sss = msg.split(">");

			for (int i=0; i < k; i++) {
				System.out.println("\treqStat1 : msg : " + sss[i]);
				dos.writeUTF(sss[1-i]);
			}

			//while(good < 0) {
				good = dis.readInt();
			//
			//	}
			System.out.println("\treqStat1 : good : " + good);

			statTime = new String[good];
			stat = new int[good];
			for (int i=0; i < stat.length; i++) {
				statTime[i] = dis.readUTF();
				stat[i] = dis.readInt();
			}

		}
		catch (IOException e) { System.out.println(e); }
	}

	public void reqStat2()
	{
		try
		{
			System.out.println("\tStat2 : msg : " + msg);
			int k = 5;
			//msg = "indexA^한국>문자포함>20150101000000-20150531235959>MSG_daily";
			dos.writeInt(k);

			String[] sss = msg.split(">");
			if(sss[3].equals("ALL")) {
				sss[2] = getPeriod("-");
				sss[3] = "MSG";
			}
			else 		sss[2] = getPeriod(sss[2]);

			for (int i=0; i < k; i++) {
				System.out.println("\tStat2 : msg333 : " + sss[i]);
				dos.writeUTF(sss[i]);
			}
			good = 0;
		}
		catch (IOException e) { System.out.println(e); }
	}


	public void reqStat2Read() throws IOException
	{
		int cnt = dis.readInt();
		System.out.println("SocketComm.java : reqStat2Read : " + cnt);

		if (cnt >= 0) {	// 검색내용 수신
			statTime = new String[cnt];
			stat = new int[cnt];
			for (int i=0; i < stat.length; i++) {
				statTime[i] = dis.readUTF();
				stat[i] = dis.readInt();

				//System.out.println("statTime = " + statTime[i] + "  stat = " + stat[i]);
			}
		}
		good = cnt;

		System.out.println("SocketComm.java : reqStat2Read : " + cnt);
	}

	public void reqNotice() throws IOException
	{
		System.out.println("reqNoticemsg = " + msg);
		String[] s = msg.split(">");

		//System.out.println("s[0] = " + s[0]);
		//System.out.println("s[1] = " + s[1]);

		dos.writeUTF(s[0]);
		dos.writeUTF(s[1]);
		dos.writeUTF(s[2]);

		//dos.writeUTF(s[1]);
		good = 0;
	}

	public void reqGetNotice() throws IOException
	{
		System.out.println("reqGetNotice : msg = " + msg);
		String[] s = msg.split(">");

		//System.out.println("s[0] = " + s[0]);
		//System.out.println("s[1] = " + s[1]);

		dos.writeUTF(s[0]);
		dos.writeUTF(s[1]);
		dos.writeUTF(s[2]);

		good = dis.readInt();

		System.out.println("\treqGetNotice : good : " + good);
	}


	public void runStart()
	{
		try
		{
			long time = System.currentTimeMillis();
			System.out.println(ip + " :socketComm: " + port);

			dos.writeUTF(userID); 			// userID 전송

			if (sel == 0) {					// QUERY
				dos.writeBoolean(true);
				dos.writeUTF("QUERY");
				reqQUERY();
			}
			else  if (sel == 1) {			// QUERY2
				dos.writeBoolean(true);
				dos.writeUTF("QUERY");
				reqQUERY();
			}
			else  if ((sel == 2)||(sel == 12)) { // VIEW
				dos.writeBoolean(false);
				dos.writeUTF("VIEW");
				System.out.println("\tVIEW");
				reqVIEW();
			}
			else  if (sel == 3) {			// KEYS
				dos.writeBoolean(false);
				dos.writeUTF("KEYS");
				reqKEYS();
			}
			else  if ((sel == 4)||(sel == 14)) { // VIEW
				dos.writeBoolean(false);
				dos.writeUTF("COUNT");
				reqCOUNT();
			}
			else  if (sel == 5) {			// STOP
				dos.writeBoolean(false);
				dos.writeUTF("STOP");
			}
			else  if (sel == 6) {			// PRI
				dos.writeBoolean(false);
				dos.writeUTF("PRI");
				reqPri();
			}
			else  if (sel == 7) {			// CHECKR
				dos.writeBoolean(false);
				dos.writeUTF("CHECKR");
				reqCheckR();
			}
			else  if (sel == 8) {			// EXPORT
				dos.writeBoolean(false);
				dos.writeUTF("EXPORT");
				reqExport();
			}
			else  if (sel == 9) {			// PROFILE
				dos.writeBoolean(true);
				dos.writeUTF("PROFILE");
				reqProfile();
			}
			else  if (sel == 10) {			// GETPROFILE
				dos.writeBoolean(false);
				dos.writeUTF("GETPROFILE");
				reqGetProfile();
			}
			else  if (sel == 13) {			// READ
				dos.writeBoolean(false);
				dos.writeUTF("READ");
				reqRead();
			}
			else  if (sel == 16) {			// FROM
				dos.writeBoolean(false);
				dos.writeUTF("FROM");
				reqFrom();
			}
			else  if (sel == 15) {			// GETFROM
				dos.writeBoolean(false);
				dos.writeUTF("GETFROM");
				reqGetFrom();
			}
			else  if (sel == 21) {			// STAT2
				dos.writeBoolean(false);
				dos.writeUTF("STAT2");
				reqStat2();
			}
			else  if (sel == 22) {			// GETSTAT2
				dos.writeBoolean(false);
				dos.writeUTF("GETSTAT2");
				reqStat2Read();
			}
			else  if (sel == 23) {			// STAT1
				dos.writeBoolean(false);
				dos.writeUTF("STAT1");
				reqStat1();
			}
			else  if (sel == 18) {			// GETNOTICE
				dos.writeBoolean(false);
				dos.writeUTF("GETNOTICE");
				reqGetNotice();
			}
			else  if (sel == 19) {			// NOTICE
				dos.writeBoolean(false);
				dos.writeUTF("NOTICE");
				reqNotice();
			}

			if (good >= 0)
				System.out.println("\tSocketComm.java : Ready : userID=" + userID + " : sel=" + sel
						+ " : page="+ page + " : " + (System.currentTimeMillis()-time) + " ms");
			else
				System.out.println("\tSocketComm.java : Not Ready : ID=" + userID + " : sel=" + sel
						+ " : page="+ page + " : " + (System.currentTimeMillis()-time) + " ms");

		}
		catch (IOException e) {
			System.out.println(ip + " :socketComm: " + port);
			System.out.println("\t\t\t\t\tEEEEEEEEEEEEEEEE");
			e.printStackTrace();
		}
		finally {
			try {
				System.out.println(ip + " :socketComm222: " + port);
				dos.close();
				socket.close();
			} catch (IOException e) {e.printStackTrace();}
		}
	}

	public String getPeriod(String t) throws IOException
	{
		String[] ss = t.split("-");

		long unixtime = System.currentTimeMillis();
		String fromDate = "";
		String toDate = "";

		//System.out.println("ZZZZZZZ :" + t + " : " + ss.length);

		if(ss.length == 0) {
			fromDate = "19900101000000";;
			toDate = formattedDate(unixtime+365*24*3600*10000L);
		}
		else if(ss.length == 1){
			if(ss[0].length() == 16) fromDate = formattedDate(ss[0]);
			else if(ss[0].length() == 19) fromDate = formattedDate2(ss[0]);
			else if(ss[0].length() == 10) fromDate = formattedDate2(ss[0]) + "000000";
			else 		fromDate = "19900101000000";;

			toDate = formattedDate(unixtime+365*24*3600*10000L);
		}
		else {
			if(ss[0].length() == 16) fromDate = formattedDate(ss[0]);
			else if(ss[0].length() == 19) fromDate = formattedDate2(ss[0]);
			else if(ss[0].length() == 10) fromDate = formattedDate3(ss[0]) + "000000";
			else 		fromDate = "19900101000000";

			//System.out.println("ZZZZZZZ :" + ss[1] + " : " + ss[1].length());
			if(ss[1].length() == 16) toDate = formattedDate(ss[1]);
			else if(ss[1].length() == 19) toDate = formattedDate2(ss[1]);
			else if(ss[1].length() == 10) toDate = formattedDate2(ss[1]) + "235959";
			else toDate = formattedDate(unixtime+365*24*3600*10000L);
		}

		return fromDate + "-" + toDate;
	}
	public String formattedDate	(String date)
	{
		String[] s = date.split(" ");
		date = s[0] + " " + s[1];
		String fromFormatString = "yyyy/MM/dd HH:mm";
		String toFormatString = "yyyyMMddHHmmss";
		SimpleDateFormat fromFormat =
				new SimpleDateFormat(fromFormatString);
		SimpleDateFormat toFormat =
				new SimpleDateFormat(toFormatString);
		Date fromDate = null;

		try { fromDate = fromFormat.parse(date); } catch(ParseException e) {fromDate = new Date();}

		return toFormat.format(fromDate);
	}

	public String formattedDate2(String date)
	{
		String[] s = date.split(" ");
		date = s[0] + " " + s[1];
		String fromFormatString = "yyyy/MM/dd HH:mm:ss";
		String toFormatString = "yyyyMMddHHmmss";
		SimpleDateFormat fromFormat =
				new SimpleDateFormat(fromFormatString);
		SimpleDateFormat toFormat =
				new SimpleDateFormat(toFormatString);
		Date fromDate = null;

		try { fromDate = fromFormat.parse(date); } catch(ParseException e) {fromDate = new Date();}

		return toFormat.format(fromDate);
	}


	public String formattedDate3(String date)
	{
		String[] s = date.split(" ");
		date = s[0] + " " + s[1];
		String fromFormatString = "yyyy/MM/dd";
		String toFormatString = "yyyyMMdd";
		SimpleDateFormat fromFormat =
				new SimpleDateFormat(fromFormatString);
		SimpleDateFormat toFormat =
				new SimpleDateFormat(toFormatString);
		Date fromDate = null;

		try { fromDate = fromFormat.parse(date); } catch(ParseException e) {fromDate = new Date();}

		return toFormat.format(fromDate);
	}


}
