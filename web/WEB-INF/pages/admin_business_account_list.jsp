<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Zerotech Server Business Account Admin - 사업자 사용자 관리</title>
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
    <h2>Business User List</h2>
    <!-- Search Bar -->
    <div class="panel panel-info">
        <div class="panel-heading">Search</div>
        <div class="panel-body">
            <form action="/admin/business/search" method="post" class="form-inline" role="form">
                <div class="input-prepend input-append form-group">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="activeFilter" value="active"> 일시중지 사용자
                        </label>
                    </div>
                    <select name="searchFilter" class="form-control">
                        <option value="username">사용자 이름</option>
                        <option value="number">휴대폰 번호</option>
                        <option value="businessNumber">사업자 번호</option>
                        <option value="uuid">고유번호</option>
                        <option value="date">가입일</option>
                    </select>
                    <input class="form-control" name="searchInput" type="text">
                </div>
                <button class="btn btn-primary" type="submit">
                    검색
                </button>
                <a href="/admin/business" class="btn btn-default">초기화</a>
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
                <th width="20%" class="text-center">사업자 번호</th>
                <th width="20%" class="text-center">고유번호</th>
                <th class="text-center shrink"></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${businessAccountList}" var="businessAccount">
                <c:choose>
                    <c:when test="${businessAccount.active == false}">
                        <tr class="danger">
                    </c:when>
                    <c:otherwise>
                        <tr>
                    </c:otherwise>
                </c:choose>
                <td>${businessAccount.account}</td>
                <td class="text-center">${businessAccount.lastname}${businessAccount.firstname}</td>
                <td class="text-center">${businessAccount.number}</td>
                <td class="text-center">${businessAccount.businessNumber}</td>
                <td class="text-center">${businessAccount.uuid}</td>
                <td class="text-center shrink">
                    <form action="/admin/business/modify" method="post">
                        <button class="btn btn-primary" name="uuid" value="${businessAccount.uuid}">수정</button>
                    </form>
                    <form action="/admin/business/delete" method="post">
                        <button class="btn btn-danger" name="uuid" value="${businessAccount.uuid}">삭제</button>
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