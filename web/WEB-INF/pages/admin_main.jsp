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
                    <a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#"><i
                            class="glyphicon glyphicon-user"></i> ${userId} <span class="caret"></span></a>
                    <ul id="g-account-menu" class="dropdown-menu" role="menu">
                        <li><a href="#">My Profile</a></li>
                    </ul>
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
            <!-- Left column -->
            <%--<a href="#"><strong><i class="glyphicon glyphicon-wrench"></i> Tools</strong></a>--%>

            <%--<hr>--%>

            <ul class="nav nav-stacked">
                <li class="nav-header"><a href="#" data-toggle="collapse" data-target="#user-menu">Settings <i
                        class="glyphicon glyphicon-chevron-down"></i></a>
                    <ul class="nav nav-stacked collapse in" id="user-menu">
                        <%--<li class="active"><a href="#"><i class="glyphicon glyphicon-home"></i> Home</a></li>--%>
                        <%--<li><a href="#"><i class="glyphicon glyphicon-envelope"></i> Messages <span--%>
                        <%--class="badge badge-info">4</span></a></li>--%>
                        <%--<li><a href="#"><i class="glyphicon glyphicon-cog"></i> Options</a></li>--%>
                        <%--<li><a href="#"><i class="glyphicon glyphicon-comment"></i> Shoutbox</a></li>--%>
                        <li><a href="#" content="/admin/admin-account" onclick="setIframe(this);return false;"><i
                                class="glyphicon glyphicon-user"></i> Staff
                            List</a></li>
                        <li><a href="#" content="/admin/user" onclick="setIframe(this);return false;"><i
                                class="glyphicon glyphicon-user"></i> User List</a>
                        </li>
                        <li><a href="#" content="/admin/group-name" onclick="setIframe(this);return false;"><i
                                class="glyphicon glyphicon-user"></i> Group List</a>
                        </li>
                        <%--<li><a href="#"><i class="glyphicon glyphicon-flag"></i> Transactions</a></li>--%>
                        <%--<li><a href="#"><i class="glyphicon glyphicon-exclamation-sign"></i> Rules</a></li>--%>
                        <%--<li><a href="#"><i class="glyphicon glyphicon-off"></i> Logout</a></li>--%>
                    </ul>
                </li>
                <%--<li class="nav-header"><a href="#" data-toggle="collapse" data-target="#menu2"> Reports <i--%>
                <%--class="glyphicon glyphicon-chevron-right"></i></a>--%>

                <%--<ul class="nav nav-stacked collapse" id="menu2">--%>
                <%--<li><a href="#">Information &amp; Stats</a>--%>
                <%--</li>--%>
                <%--<li><a href="#">Views</a>--%>
                <%--</li>--%>
                <%--<li><a href="#">Requests</a>--%>
                <%--</li>--%>
                <%--<li><a href="#">Timetable</a>--%>
                <%--</li>--%>
                <%--<li><a href="#">Alerts</a>--%>
                <%--</li>--%>
                <%--</ul>--%>
                <%--</li>--%>
                <%--<li class="nav-header">--%>
                <%--<a href="#" data-toggle="collapse" data-target="#menu3"> Social Media <i--%>
                <%--class="glyphicon glyphicon-chevron-right"></i></a>--%>
                <%--<ul class="nav nav-stacked collapse" id="menu3">--%>
                <%--<li><a href=""><i class="glyphicon glyphicon-circle"></i> Facebook</a></li>--%>
                <%--<li><a href=""><i class="glyphicon glyphicon-circle"></i> Twitter</a></li>--%>
                <%--</ul>--%>
                <%--</li>--%>
            </ul>

            <%--<hr>--%>

            <%--<a href="#"><strong><i class="glyphicon glyphicon-link"></i> Resources</strong></a>--%>

            <%--<hr>--%>

            <%--<ul class="nav nav-pills nav-stacked">--%>
            <%--<li class="nav-header"></li>--%>
            <%--<li><a href="#"><i class="glyphicon glyphicon-list"></i> Layouts &amp; Templates</a></li>--%>
            <%--<li><a href="#"><i class="glyphicon glyphicon-briefcase"></i> Toolbox</a></li>--%>
            <%--<li><a href="#"><i class="glyphicon glyphicon-link"></i> Widgets</a></li>--%>
            <%--<li><a href="#"><i class="glyphicon glyphicon-list-alt"></i> Reports</a></li>--%>
            <%--<li><a href="#"><i class="glyphicon glyphicon-book"></i> Pages</a></li>--%>
            <%--<li><a href="#"><i class="glyphicon glyphicon-star"></i> Social Media</a></li>--%>
            <%--</ul>--%>

            <%--<hr>--%>
            <%--<ul class="nav nav-stacked">--%>
            <%--<li class="active"><a href="http://bootply.com" title="The Bootstrap Playground"--%>
            <%--target="ext">Playground</a></li>--%>
            <%--<li><a href="/tagged/bootstrap-3">Bootstrap 3</a></li>--%>
            <%--<li><a href="/61518" title="Bootstrap 3 Panel">Panels</a></li>--%>
            <%--<li><a href="/61521" title="Bootstrap 3 Icons">Glyphicons</a></li>--%>
            <%--<li><a href="/62603">Layout</a></li>--%>
            <%--</ul>--%>

            <%--<hr>--%>

            <%--<a href="#"><strong><i class="glyphicon glyphicon-list"></i> More Templates</strong></a>--%>

            <%--<hr>--%>

            <%--<ul class="nav nav-stacked">--%>
            <%--<li class="active"><a rel="nofollow" href="http://goo.gl/pQoXEh" target="ext">Premium Themes</a></li>--%>
            <%--<li><a rel="nofollow" href="https://wrapbootstrap.com/?ref=bootply">Wrap Bootstrap</a></li>--%>
            <%--<li><a rel="nofollow" href="http://bootstrapzero.com">BootstrapZero</a></li>--%>
            <%--</ul>--%>
        </div>
        <!-- /col-3 -->
        <div class="col-sm-9" style="height:100%;">
            <iframe id="content-iframe" src="/admin/admin-account" style="width: 100%;height: 100%;border: 0;"></iframe>
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
                <!-- column 2 -->
                <%--<ul class="list-inline pull-right">--%>
                <%--<li><a href="#"><i class="glyphicon glyphicon-cog"></i></a></li>--%>
                <%--<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i--%>
                <%--class="glyphicon glyphicon-comment"></i><span class="count">3</span></a>--%>
                <%--<ul class="dropdown-menu" role="menu">--%>
                <%--<li><a href="#">1. Is there a way..</a></li>--%>
                <%--<li><a href="#">2. Hello, admin. I would..</a></li>--%>
                <%--<li><a href="#"><strong>All messages</strong></a></li>--%>
                <%--</ul>--%>
                <%--</li>--%>
                <%--<li><a href="#"><i class="glyphicon glyphicon-user"></i></a></li>--%>
                <%--<li><a title="Add Widget" data-toggle="modal" href="#addWidgetModal"><span--%>
                <%--class="glyphicon glyphicon-plus-sign"></span> Add Widget</a></li>--%>
                <%--</ul>--%>
                <%--<a href="#"><strong><i class="glyphicon glyphicon-dashboard"></i> My Dashboard</strong></a>--%>
                <%--<hr>--%>
                <%--<div class="modal" id="addWidgetModal">--%>
                <%--<div class="modal-dialog">--%>
                <%--<div class="modal-content">--%>
                <%--<div class="modal-header">--%>
                <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">횞</button>--%>
                <%--<h4 class="modal-title">Add Widget</h4>--%>
                <%--</div>--%>
                <%--<div class="modal-body">--%>
                <%--<p>Add a widget stuff here..</p>--%>
                <%--</div>--%>
                <%--<div class="modal-footer">--%>
                <%--<a href="#" data-dismiss="modal" class="btn">Close</a>--%>
                <%--<a href="#" class="btn btn-primary">Save changes</a>--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--<!-- /.modal-content -->--%>
                <%--</div>--%>
                <%--<!-- /.modal-dalog -->--%>
                <%--</div>--%>


</body>
</html>