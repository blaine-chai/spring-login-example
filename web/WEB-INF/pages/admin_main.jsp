<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html style="height: 100%;">
<%--<head>--%>
<%--<meta charset="utf-8">--%>
<%--<title></title>--%>
<%--</head>--%>
<%--<body>--%>
<%--${userId}님 안녕하세요? :-)<br>--%>
<%--<a href="/admin/logout">로그아웃</a>--%>
<%--<br><br>--%>

<%--<a href="/admin/admin-account">관리자 계정 관리</a>--%>
<%--<a href="/admin/user">사용자 관리</a>--%>

<%--</body>--%>
<%--</html>--%>

<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>Server Admin</title>
    <%--<meta name="generator" content="Bootply"/>--%>
    <%--<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">--%>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <%--<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>--%>
    <%--<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>--%>
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <link href="/css/styles.css" rel="stylesheet">
</head>
<body style="height: 100%;">
<!-- header -->
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
            <%--<iframe id="content-iframe" src="/admin/admin-account" style="width: 100%;height: 100%;border: 0;"></iframe>--%>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $(".alert").addClass("in").fadeOut(4500);

        /* swap open/close side menu icons */
        $('[data-toggle=collapse]').click(function () {
            // toggle icon
            $(this).find("i").toggleClass("glyphicon-chevron-right glyphicon-chevron-down");
        });

//        $('#user-menu a').click(function (e) {
//            $('#content-iframe').attr('src', $(this).attr('content'));
//        });

    });
    function setIframe(element) {
        $('#content-iframe').attr('src', $(element).attr('content'));
    }


</script>
</body>
</html>