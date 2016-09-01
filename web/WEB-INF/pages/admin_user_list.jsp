<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Server Admin - 사용자 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/js/jquery-1.11.3.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <style type="text/css">
        #cssTable td {
            vertical-align: middle;
        }

        table td.shrink {
            white-space: nowrap
        }
    </style>
    <style>
        form {
            margin: 5px;
            display: inline-block
        }
    </style>
</head>
<body>
<div class="container">
    <h2>User List</h2>
    <!-- Search Bar -->
    <div class="panel panel-info">
        <div class="panel-heading">Search</div>
        <div class="panel-body">
            <form action="/admin/user/search" method="post" class="form-inline" role="form">
                <div class="input-prepend input-append form-group">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="activeFilter" value="active"> 일시중지 사용자
                        </label>
                    </div>
                    <select name="searchFilter" class="form-control">
                        <option value="account">계정 이메일 주소</option>
                        <option value="number">휴대폰 번호</option>
                        <option value="uuid">고유번호</option>
                        <option value="date">가입일</option>
                    </select>
                    <input class="form-control" name="searchInput" type="text">
                </div>
                <button class="btn btn-primary" type="submit">
                    검색
                </button>
                <a href="/admin/user" class="btn btn-default">초기화</a>
            </form>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table  table-condensed table-hover" id="cssTable">
            <thead>
            <tr>
                <th width="20%" class="text-center">사용자 이름</th>
                <th width="20%" class="text-center">닉네임</th>
                <th width="20%" class="text-center">휴대폰 번호</th>
                <th width="40%" class="text-center">고유번호</th>
                <th class="text-center shrink"></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${userList}" var="user">
                <c:choose>
                    <c:when test="${user.active == false}">
                        <tr class="danger">
                    </c:when>
                    <c:otherwise>
                        <tr>
                    </c:otherwise>
                </c:choose>
                <td>${user.account}</td>
                <td class="text-center">${user.lastname}${user.firstname}</td>
                <td class="text-center">${user.number}</td>
                <td class="text-center">${user.uuid}</td>
                <td class="text-center shrink">
                    <form action="/admin/user/modify" method="post">
                        <button class="btn btn-primary" name="uuid" value="${user.uuid}">수정</button>
                    </form>
                    <form action="/admin/user/delete" method="post">
                        <button class="btn btn-danger" name="uuid" value="${user.uuid}">삭제</button>
                    </form>
                </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>