<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Server Admin - admin 사용자 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <form action="/admin/admin-account/update" method="post" class="form" role="form">
        <label>사용자 아이디</label>
        <input class="form-control" value="${adminInfo.userId}" placeholder="사용자 이름"
               name="userId" type="email" readOnly/><br>
        <label>이름</label>
        <input class="form-control" name="username" value="${adminInfo.username}" type="text"/><br>
        <label>비밀번호</label>
        <%--<input class="form-control" value="**********" type="password" readOnly="true"/><br>--%>
        <input class="form-control" value="********" type="password" name="password"/><br>
        <label>가입일</label>
        <input class="form-control" name="number" value="${adminInfo.createDate}" type="text" readOnly/><br>
        <br/>
        <br/>
        <a href="/admin/user" class="btn btn-lg btn-danger btn-block">취소</a>
        <button class="btn btn-lg btn-primary btn-block" type="submit">
            저장
        </button>
    </form>
</div>
</body>
</html>