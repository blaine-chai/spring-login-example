<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Server Admin - 그룹 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/js/jquery.min.js"></script>
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
    <h2>Group List</h2>
    <div class="table-responsive">
        <form action="/admin/group-name/register" method="post" style="width: 100%; position:relative;">
            <button class="btn btn-primary" style="position: absolute; right: 50px;">생성</button>
        </form>
        <table class="table table-condensed table-hover" id="cssTable">
            <thead>
            <tr>
                <th width="60%" class="text-center">그룹 이름</th>
                <th class="text-center shrink"></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${groupList}" var="group">
                <tr>
                    <td>${group.groupName}</td>
                    <td class="text-center shrink">
                        <form action="/admin/group-name/modify" method="post">
                            <button class="btn btn-primary" name="groupName" value="${group.groupName}">수정</button>
                        </form>
                        <form action="/admin/group-name/delete" method="post">
                            <button class="btn btn-danger" name="groupName" value="${group.groupName}">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>