<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title>Server Admin</title>
    <link href="/css/login.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/js/jquery.min.js"></script>
</head>
<body>
<div class="login">
    <div class="login-screen">
        <div class="app-title">
            <c:choose>
                <c:when test="${adminAccountSize <= 0 }">
                    <h1>Admin Account Registration</h1>
                    <form method="post" action="/admin/join">
                        <div class="login-form">
                            <div class="control-group">
                                <input type="text" class="login-field" value="" placeholder="userId"
                                       name="userId">
                                <label class="login-field-icon fui-user"></label>
                            </div>

                            <div class="control-group">
                                <input type="text" class="login-field" value="" placeholder="username"
                                       name="username">
                                <label class="login-field-icon fui-user"></label>
                            </div>

                            <div class="control-group">
                                <input type="password" class="login-field" value="" placeholder="password"
                                       name="password">
                                <label class="login-field-icon fui-lock"></label>
                            </div>

                            <input type="submit" class="btn btn-primary btn-large btn-block" value="join">
                        </div>
                    </form>
                </c:when>
                <c:otherwise>
                    <h1>Login</h1>

                    <form method="post" action="/admin/login">
                        <div class="login-form">
                            <div class="control-group">
                                <input type="text" class="login-field" value="" placeholder="userId"
                                       name="userId">
                                <label class="login-field-icon fui-user"></label>
                            </div>

                            <div class="control-group">
                                <input type="password" class="login-field" value="" placeholder="password"
                                       name="password">
                                <label class="login-field-icon fui-lock"></label>
                            </div>

                            <input type="submit" class="btn btn-primary btn-large btn-block" value="login">
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
        ${loginFail}
    </div>
    <c:if test="${loginFail.equals(\"true\")}">
        <script>
            $(document).ready(function () {
                alert('아이디와 비밀번호를 다시 확인해 주세요.');
            });
        </script>
    </c:if>
</div>
<script type="text/javascript" charset="UTF-8" src="/js/auto-logout.js"></script>
</body>
</html>