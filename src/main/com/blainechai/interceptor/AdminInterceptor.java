package com.blainechai.interceptor;

import com.blainechai.constant.UserType;
import com.blainechai.domain.Session;
import com.blainechai.repository.SessionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class AdminInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    SessionRepository sessionRepository;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        try {
            List<Session> list = sessionRepository.findByJSessionId(request.getSession().getId());
            if (list.size() > 0 && UserType.isAdminUser(list.get(0).getType())) {
                return true;
            }
//            System.out.println(request.getParameter("loginFail"));
//            System.out.println(request.getAttribute("loginFail"));
            response.sendRedirect("/admin");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}