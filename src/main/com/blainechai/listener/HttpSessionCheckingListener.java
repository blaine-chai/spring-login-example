package com.blainechai.listener;

import com.blainechai.domain.Session;
import com.blainechai.repository.SessionRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Created by blainechai on 2016. 9. 7..
 */

public class HttpSessionCheckingListener implements HttpSessionListener {

    @Autowired
    SessionRepository sessionRepository;

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public void sessionCreated(HttpSessionEvent event) {
//        if (logger.isDebugEnabled()) {
            logger.info("Session ID".concat(event.getSession().getId()).concat(" created at ").concat(new java.util.Date().toString()));
//        }
    }

    public void sessionDestroyed(HttpSessionEvent event) {
//        if (logger.isDebugEnabled()) {
            logger.info("Session ID".concat(event.getSession().getId()).concat(" destroyed at ").concat(new java.util.Date().toString()));
//        }
        sessionRepository.deleteByJSessionId(event.getSession().getId());
        logger.info("deleted");
    }
}
