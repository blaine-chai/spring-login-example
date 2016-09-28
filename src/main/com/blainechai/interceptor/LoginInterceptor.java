package com.blainechai.interceptor;

import com.blainechai.constant.Type;
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
            if (list.size() > 0 && (list.get(0).getType().equals(Type.USER)||list.get(0).getType().equals(Type.ADMIN))) {
                return true;
            }
            response.sendRedirect("/");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
