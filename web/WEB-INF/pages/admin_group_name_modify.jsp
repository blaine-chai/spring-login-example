<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Server Admin - 그룹 이름 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <form action="/admin/group-name/update" method="post" class="form" role="form">
        <label>그룹 이름</label>
        <input class="form-control" value="${groupInfo.groupName}" placeholder="그룹 이름"
               name="groupName" type="text"/><br>
        <br/>
        <br/>
        <a href="/admin/group-name" class="btn btn-lg btn-danger btn-block">취소</a>
        <button class="btn btn-lg btn-primary btn-block" name="orgGroupName" value="${groupInfo.groupName}" type="submit">
            저장
        </button>
    </form>
</div>
</body>
</html>