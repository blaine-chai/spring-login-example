<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Server Admin - admin 사용자 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/js/jquery-1.11.3.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <form action="/admin/user/update" method="post" class="form" role="form">
        <label>사용자 이름</label>
        <input class="form-control" value="${userInfo.account}" placeholder="사용자 이름"
               type="email" readOnly="true"/><br>
        <label>닉네임</label>
        <input class="form-control" value="${userInfo.lastname}${userInfo.firstname}" type="text" readOnly="true"/><br>
        <label>비밀번호</label>
        <input class="form-control" value="**********" type="password" readOnly="true"/><br>
        <label>휴대폰 번호</label>
        <input class="form-control" name="number" value="${userInfo.number}" type="text"/><br>
        <label>디바이스</label>
        <input class="form-control" name="model" value="${userInfo.model}" type="text" readOnly="true"/><br>
        <label>UUID</label>
        <input class="form-control" name="uuid" value="${userInfo.uuid}" type="text" readOnly="true"/><br>
        <label>가입일</label>
        <input class="form-control" name="uuid" value="${userInfo.createDate}" type="text" readOnly="true"/><br>
        <label>
            <c:choose>
                <c:when test="${userInfo.active == false}">
                    <input type="checkbox" name="active" value="active" checked="checked">
                </c:when>
                <c:otherwise>
                    <input type="checkbox" name="active" value="active">
                </c:otherwise>
            </c:choose>
            계정 일시정지
        </label>
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