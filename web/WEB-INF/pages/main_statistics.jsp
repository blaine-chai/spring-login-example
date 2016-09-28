<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title>REMOS</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/bootstrap.css">

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <style type="text/css">
        /*@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);*/
    </style>
    <link href="/css/main-style.css" rel="stylesheet" type="text/css">
</head>
<body>
<!-- Split button -->
<div id="header-wrapper" style="align-content: center; text-align: center"><h1
        style="margin:0 auto; padding: 20px 0 20px 0">
    Real-Time Monitoring System(REMOS)</h1></div>
<div id="nav-wrapper">
    <div id="nav">
        <a href="/main">
            <div class="header-button btn active">
                <div class="glyphicon glyphicon-bell"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>알림</div>
            </div>
        </a>
        <a href="/main/status">
            <div class="header-button btn">
                <div class="glyphicon glyphicon-off"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>시스템 상태</div>
            </div>
        </a>
        <a href="/main/profile">
            <div class="header-button btn">
                <div class="glyphicon glyphicon-list-alt"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>프로파일링</div>
            </div>
        </a>
        <a href="#">
            <div class="header-button btn">
                <div class="glyphicon glyphicon-signal"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>통계</div>
            </div>
        </a>
        <a href="/main/search">
            <div class="header-button btn">
                <div class="glyphicon glyphicon-search"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>검색</div>
            </div>
        </a>
    </div>
</div>
<div id="content">
<div id="content-wrapper">
    <div id="search" class="col-xs-4">
        <div style="background: rgba(239, 239, 239, 1); height: 100%;">
            <div id="search-input-wrapper" class="col-xs-12">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="검색어를 입력해주세요.">
                    <%--<div class="input-group-btn">--%>

                    <%--<button class="btn btn-default"--%>
                    <%--type="button">검색</button>--%>
                    <div class="dropdown input-group-btn">
                        <button type="button" class="btn btn-default">검색</button>
                        <div class="btn-group">
                            <button type="button" class="btn btn-default dropdown-toggle"
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">&nbsp;
                                <span class="caret"></span><span class="sr-only"></span></button>
                            <ul class="dropdown-menu">
                                <!-- Dropdown menu links -->
                                <li><a href="#">문자 포함</a></li>
                                <li><a href="#">형태소</a></li>
                                <li><a href="#">문자 일치</a></li>
                                <li class="divider"></li>
                                <li><a href="#">날짜 선택</a></li>
                            </ul>
                        </div>
                    </div>
                    <%--</div>--%>
                </div>
                <%--<div id="search-radio-wrapper"></div>--%>
            </div>
        </div>
    </div>
    <div id="menu" class="col-xs-8">
        <div style="background: rgba(224, 234, 244, 1);  height: 700px;">

        </div>
    </div>
</div>
</div>
</body>
</html>