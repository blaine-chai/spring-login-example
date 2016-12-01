<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title>Server Admin</title>
    <link href="../css/login.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/js/jquery.min.js"></script>
</head>
<body>
<div class="login">
    <div class="login-screen">
        <div class="app-title">
            <h1>User Login</h1>
            <form method="post" action="/login">
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

                    <div class="control-group">
                        <input type="submit" class="btn btn-primary btn-large btn-block" value="login" style="cursor: pointer;">
                    </div>
                    <%--<div class="control-group">--%>
                        <%--<a href="/register" type="button" class="btn btn-primary btn-large btn-block">register</a>--%>
                    <%--</div>--%>
                </div>
                ${loginFail}
            </form>
        </div>
    </div>
</div>
<c:if test="${loginFail.equals(\"true\")}">
    <script>
        $(document).ready(function () {
            alert('아이디와 비밀번호를 다시 확인해 주세요.');
        });
    </script>
</c:if>
</body>
</html>