package com.blainechai.constant;

/**
 * Created by blainechai on 2016. 9. 8..
 */
public final class UserType {
    public final static String ADMIN = "ADMIN";
    public final static String SUPER_USER = "super";
    public final static String USER_A = "a";
    public final static String USER_B = "b";
    public final static String USER_C = "c";

    public static boolean isUser(String type) {
        if (type.equals(ADMIN)) return true;
        if (type.equals(SUPER_USER)) return true;
        if (type.equals(USER_A)) return true;
        if (type.equals(USER_B)) return true;
        if (type.equals(USER_C)) return true;
        return false;
    }
}
