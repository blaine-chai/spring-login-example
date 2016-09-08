package com.blainechai.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by blainechai on 2016. 9. 7..
 */
public class EncryptUtil {
    public static final String FIRST_KEY = "book1234";
    public static final String SECOND_KEY = "4321koob";
    private String input;

    public EncryptUtil(String input) {
        this.input = FIRST_KEY + input + SECOND_KEY;
    }

    public String generate() {
        String output;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(input.getBytes());
            byte byteData[] = md.digest();
            StringBuffer sb = new StringBuffer();
            for (byte byteTmp : byteData) {
                sb.append(Integer.toString((byteTmp & 0xff) + 0x100, 16).substring(1));
                int tmp1 = (byteTmp & 0xff);
                int tmp2 = ((byteTmp & 0xff) + 0x100);

                System.out.println(byteTmp + " : " + tmp1 + " : " + tmp2
                        + " : " + Integer.toString((byteTmp & 0xff) + 0x100, 16)
                        + " : " + (Integer.toString((byteTmp & 0xff) + 0x100, 16).substring(1)));
            }
            output = sb.toString();

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            output = null;
        }
        return output;
    }

    //SHA-256
    public static String getSHA256(String str) {
        String output = "";
        try {
            MessageDigest sh = MessageDigest.getInstance("SHA-256");
            sh.update(str.getBytes());
            byte byteData[] = sh.digest();
            System.out.println("byte data is:");
            StringBuffer sb = new StringBuffer();

            for (byte byteTmp : byteData) {
                sb.append(Integer.toString((byteTmp & 0xff) + 0x100, 16).substring(1));
                int tmp1 = (byteTmp & 0xff);
                int tmp2 = ((byteTmp & 0xff) + 0x100);

                System.out.println(byteTmp + " : " + tmp1 + " : " + tmp2
                        + " : " + Integer.toString((byteTmp & 0xff) + 0x100, 16)
                        + " : " + (Integer.toString((byteTmp & 0xff) + 0x100, 16).substring(1)));
            }
            output = sb.toString();

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            output = null;
        }
        return output;
    }
}
