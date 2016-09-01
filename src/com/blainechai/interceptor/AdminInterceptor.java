package com.blainechai.interceptor;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminInterceptor extends HandlerInterceptorAdapter {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        try {
            if (request.getSession().getAttribute("username") == null) {
                response.sendRedirect("/admin");
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }
}