package com.blainechai.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by blainechai on 2016. 12. 3..
 */
public class LoggerUtil {
    private static Logger logger = LoggerFactory.getLogger(LoggerUtil.class);

    public static void log(String msg) {
        logger.info(msg);
    }

    public static void log(String id, String msg) {
//        log("ID: " + userId + " - 로그아웃");
        logger.info("ID: " + id + " - " + msg);
    }
}
