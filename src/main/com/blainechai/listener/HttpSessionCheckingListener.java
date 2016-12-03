package com.blainechai.listener;

import com.blainechai.domain.Session;
import com.blainechai.repository.SessionRepository;
import com.blainechai.util.LoggerUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.FrameworkServlet;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.List;

import static com.blainechai.util.LoggerUtil.*;

/**
 * Created by blainechai on 2016. 9. 7..
 */

public class HttpSessionCheckingListener implements HttpSessionListener {

    //    @Autowired
    private SessionRepository sessionRepository;


    @Override
    public void sessionCreated(HttpSessionEvent event) {
//        if (logger.isDebugEnabled()) {
//        log("Session ID".concat(event.getSession().getId()).concat(" created at ").concat(new java.util.Date().toString()));
//        }
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {

        HttpSession session = event.getSession();
        WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
        sessionRepository = context.getBean("sessionRepository", SessionRepository.class);
        if (sessionRepository.findByJSessionId(event.getSession().getId()).size() > 0) {
            String userId = sessionRepository.findByJSessionId(event.getSession().getId()).get(0).getUserId();
            log("ID: " + userId + " - 로그아웃");
            sessionRepository.deleteByJSessionId(event.getSession().getId());
        }
    }
}
