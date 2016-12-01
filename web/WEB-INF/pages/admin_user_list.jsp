<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Server Admin - 사용자 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <link href="/css/styles.css" rel="stylesheet">
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
            /*margin: 5px;*/
            display: inline-block
        }
    </style>
</head>
<body>
<div id="top-nav" class="navbar navbar-inverse navbar-static-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Dashboard</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/"><i class="glyphicon glyphicon-home"></i> home</a></li>
                <li class="dropdown">
                    <a href="#"><i class="glyphicon glyphicon-user"></i> ${userId}</a>
                </li>
                <li><a href="/admin/logout"><i class="glyphicon glyphicon-lock"></i> Logout</a></li>
            </ul>
        </div>
    </div>
    <!-- /container -->
</div>
<!-- /Header -->

<!-- Main -->
<div class="container-fluid" style="height: calc(100% - 100px);">
    <div class="row" style="height: 100%">
        <div class="col-sm-3">

            <ul class="nav nav-stacked">
                <li class="nav-header"><a href="#" data-toggle="collapse" data-target="#user-menu">Settings <i
                        class="glyphicon glyphicon-chevron-down"></i></a>
                    <ul class="nav nav-stacked collapse in" id="user-menu">
                        <%--<li><a href="#" content="/admin/admin-account" onclick="setIframe(this);return false;"><i--%>
                        <li><a href="/admin/admin-account" content="/admin/admin-account"><i
                                class="glyphicon glyphicon-user"></i> Admin
                            List</a></li>
                        <%--<li><a href="#" content="/admin/user" onclick="setIframe(this);return false;"><i--%>
                        <li><a href="/admin/user" content="/admin/user"><i
                                class="glyphicon glyphicon-user"></i> User List</a>
                        </li>
                        <li><a href="/admin/group-name" content="/admin/group-name"><i
                                class="glyphicon glyphicon-user"></i> Group List</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="col-sm-9" style="height:100%;">
            <div class="">
                <h2>User List</h2>
                <!-- Search Bar -->
                <div class="panel panel-info">
                    <div class="panel-heading">Search</div>
                    <div class="panel-body">
                        <form action="/admin/user/search" method="post" class="form-inline" role="form">
                            <div class="input-prepend input-append form-group">
                                <select name="searchFilter" class="form-control">
                                    <option value="userId">사용자 계정</option>
                                    <option value="username">사용자 이름</option>
                                    <%--<option value="password">비밀번호</option>--%>
                                    <%--<option value="date">생성일</option>--%>
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
                    <form action="/admin/user/register" method="post" style="width: 100%; position:relative;">
                        <button class="btn btn-primary" style="position: absolute; right: 50px;">생성</button>
                    </form>
                    <table class="table table-condensed table-hover" id="cssTable">
                        <thead>
                        <tr>
                            <th width="20%" class="text-center">사용자 계정</th>
                            <th width="20%" class="text-center">사용자 이름</th>
                            <th width="20%" class="text-center">비밀번호</th>
                            <th width="20%" class="text-center">생성일</th>
                            <th width="20%" class="text-center">그룹</th>
                            <th class="text-center shrink"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${adminList}" var="admin">
                            <tr>
                                <td>${admin.userId}</td>
                                <td class="text-center">${admin.username}</td>
                                    <%--<td class="text-center">${admin.hash}</td>--%>
                                <td class="text-center">********</td>
                                <td class="text-center">${admin.createDate}</td>
                                <td class="text-center"><c:forEach items="${admin.userGroups}" var="userGroup">
                                    <span style="padding-right: 5px;">${userGroup.groupName.groupName}</span>
                                </c:forEach></td>
                                <td class="text-center shrink">
                                    <form action="/admin/user/modify" method="post">
                                        <button class="btn btn-primary" name="userId" value="${admin.userId}">수정
                                        </button>
                                    </form>
                                    <form action="/admin/user/delete" method="post" onsubmit="return check();">
                                        <button class="btn btn-danger" name="userId" value="${admin.userId}">삭제</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function check() {
        if ($('#cssTable tbody tr').size() <= 1) {
            alert("관리자 계정은 모두 삭제할 수 없습니다");
            return false;
        }
        else {
            return true;
        }
    }

</script>
</body>
</html>