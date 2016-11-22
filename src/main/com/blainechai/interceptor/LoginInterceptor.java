package com.blainechai.interceptor;

import com.blainechai.constant.UserType;
import com.blainechai.domain.Session;
import com.blainechai.repository.SessionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by blainechai on 2016. 9. 18..
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    SessionRepository sessionRepository;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        try {
            List<Session> list = sessionRepository.findByJSessionId(request.getSession().getId());
            if (list.size() > 0 && (UserType.isUser(list.get(0).getType()))) {
                return true;
            }
            String requestedWithHeader = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(requestedWithHeader)) {
                response.sendError(403, "Forbidden");
            } else {
                response.sendRedirect("/");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
