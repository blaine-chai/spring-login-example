package com.blainechai.constant;

/**
 * Created by blainechai on 2016. 9. 8..
 */
public final class UserType {
//    public final static String ADMIN = "ADMIN";
    public final static String ADMIN = "admin";
    public final static String USER = "user";
//    public final static String USER_B = "b";
//    public final static String USER_C = "c";

    public static boolean isUser(String type) {
//        if (type.equals(ADMIN)) return true;
        if (type.equals(ADMIN)) return true;
        if (type.equals(USER)) return true;
//        if (type.equals(USER_B)) return true;
//        if (type.equals(USER_C)) return true;
        return false;
    }

    public static boolean isAdminUser(String type){
        return type.equals(ADMIN);
    }
}
