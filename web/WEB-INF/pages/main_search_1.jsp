<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title>REMOS</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/bootstrap.css">
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!-- 부가적인 테마 -->
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">--%>

    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <style type="text/css">
        /*@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);*/
    </style>
    <link href="/css/main-style.css" rel="stylesheet" type="text/css">

    <%--<!-- Latest compiled and minified CSS -->--%>
    <%--<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.0/bootstrap-table.min.css">--%>
    <%----%>
    <%--<!-- Latest compiled and minified JavaScript -->--%>
    <%--<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.0/bootstrap-table.min.js"></script>--%>

    <!-- Latest compiled and minified Locales -->
    <%--<script src="../../js/bootstrap-table-resizable.js"></script>--%>
    <%----%>
    <%--<script src="https://rawgit.com/wenzhixin/colResizable/master/source/colResizable-1.5.source.js"></script>--%>

    <script src="/js/colResizable-1.6.js"></script>
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
        <a href="/main/statistics">
            <div class="header-button btn">
                <div class="glyphicon glyphicon-signal"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>통계</div>
            </div>
        </a>
        <a href="#">
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
        <div id="search" class="col-xs-4" style="max-width: 333px">
            <div id="search-wrapper" style="background: rgba(239, 239, 239, 1);">
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
                                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">상세 검색
                                    <span class="caret"></span><span class="sr-only"></span></button>
                            </div>
                        </div>
                        <%--</div>--%>
                    </div>
                    <%--<div id="search-radio-wrapper"></div>--%>
                </div>
                <div class="col-xs-12" role="group" aria-label="..." style="margin-bottom: 15px;">
                    <button type="button" class="btn btn-default btn-sm btn-primary">문자 포함</button>
                    <button type="button" class="btn btn-default btn-sm">형태소</button>
                    <button type="button" class="btn btn-default btn-sm">문자 일치</button>
                    <button type="button" class="btn btn-default btn-sm">날짜 선택</button>
                </div>
                <div class="btn-group btn-group-justified col-xs-12">
                    <a class="btn btn-default">개인 히스토리 관리</a>
                    <a class="btn btn-default">전체 히스토리 보기</a>
                </div>
                <div class="col-xs-12" style="margin-top: 15px;">
                    <div class="panel panel-default">
                        <table class="table table-hover"
                               style="font-size: 12px;">
                            <thead style="background:rgba(165, 197, 230, 1);">
                            <tr>
                                <th>이름</th>
                                <th>저자</th>
                                <th>내용</th>
                                <th>발행일</th>
                            </tr>
                            </thead>
                            <tbody style="background: rgba(251,251,255,1)">
                            <tr>
                                <td>computer</td>
                                <td>john</td>
                                <td>cse</td>
                                <td>2012-08-06</td>
                            </tr>
                            <tr>
                                <td>computer</td>
                                <td>john</td>
                                <td>cse</td>
                                <td>2012-08-06</td>
                            </tr>
                            <tr>
                                <td>computer</td>
                                <td>john</td>
                                <td>cse</td>
                                <td>2012-08-06</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-xs-12" style="margin-top: 15px;">
                    <img src="/imgs/graph_sample.png" alt="" style="background-repeat: no-repeat;width: 100%;">
                </div>
            </div>
        </div>
        <div id="menu" class="col-xs-8" style="width: calc(100% - 333px)">
            <div id="menu-wrapper" style="background: rgba(224, 234, 244, 1);">
                <%--<div id="tab-wrapper">--%>
                <%--<ul class="nav nav-tabs" style="padding-top: 15px;">--%>
                <%--<li role="presentation" class="active"><a href="#">학교</a></li>--%>
                <%--<li role="presentation"><a href="#">저자</a></li>--%>
                <%--<li role="presentation"><a href="#">제목</a></li>--%>
                <%--</ul>--%>
                <%--</div>--%>
                <div class="alert alert-success">총 1000건의 검색 결과가 있습니다</div>
                <%--<div id="progress-wrapper">--%>
                <%--<div class="progress">--%>
                <%--<div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0"--%>
                <%--aria-valuemax="100"--%>
                <%--style="width: 60%;">--%>
                <%--60%--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--</div>--%>

                <div class="input-group" style="position: relative; left: 500px;">
                    <input type="text" class="form-control" style="width: 30px">
                    <button
                            class="btn btn-default">페이지로
                    </button>
                </div>
                <div id="result-table-wrapper" class="panel panel-default"
                     style="margin: 15px; overflow: scroll; height: calc(100% - 200px)">
                    <%--<div id="result-table-wrapper" class="panel panel-default"--%>
                    <%--style="margin: 15px; overflow: auto; height: calc(100% - 200px)">--%>
                    <table id="book-table" class="table table-hover table-fixed table-bordered">
                        <%--style="height: calc(100% - 200px)">--%>
                        <thead style="background:rgba(165, 197, 230, 1);">
                        <tr>
                            <th>번호</th>
                            <th>라인</th>
                            <th>파일 경로</th>
                            <th>출현 일자</th>
                            <th>출현 일자</th>
                            <th>출현 일자</th>
                            <th>비고</th>
                            <th>비고1</th>
                            <th>비고2</th>
                            <th>비고3</th>
                            <th> </th>
                        </tr>
                        </thead>
                        <tbody style="background: rgba(251,251,255,1)">
                        <tr>
                            <td><div>1</div></td>
                            <td>file1</td>
                            <td><div>file/path/file1.txt</div></td>
                            <td><div>1990-02-17</div></td>
                            <td>1990-02-17</td>
                            <td>1990-02-17</td>
                            <td style="width: 10px">비고1111111111111111111111</td>
                            <td>비고</td>
                            <td>비고</td>
                            <td>
                                <%--file/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txtfile/path/file1.txt--%>
                                file/path/file1.txt
                            </td>
                            <td></td>
                        </tr>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>1</td>--%>
                            <%--<td>file1</td>--%>
                            <%--<td>file/path/file1.txt</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>1990-02-17</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td>비고</td>--%>
                            <%--<td></td>--%>
                        <%--</tr>--%>
                        </tbody>
                    </table>
                </div>
                <div>
                    <nav aria-label="..." style="text-align: center;">
                        <ul class="pagination pagination-sm" style="margin: 0 auto;">
                            <li><a href="#" aria-label="Previous" class="disabled"><span
                                    aria-hidden="true">«</span></a>
                            </li>
                            <li><a href="#" class="active">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#" aria-label="Next"><span aria-hidden="true">»</span></a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $(window).resize(function () {
//            $('#content').height($(window).height());
            $('#search-wrapper').height($(window).height() - 194);
//            console($(document).width() + 'px');
            $('#menu-wrapper').height($(window).height() - 194);
//            $('#book-table').attr('data-height', $(window).height() - 194 - 200)
//            $('#book-table').height($(window).height() - 194 - 200)
            $('#result-table-wrapper').height($(window).height() - 194 - 200);
//            if ($('#book-table').width() < $('#result-table-wrapper').width()) {
//                console.log("hihi")
//                $('#book-table').width('100%');
//            }

        });
        $('#search-wrapper').height($(window).height() - 194);
        $('#menu-wrapper').height($(window).height() - 194);
//        $('#book-table').height($(window).height() - 194 - 200)
        $('#result-table-wrapper').height($(window).height() - 194 - 200);
        $('#book-table').colResizable({
            resizeMode: 'flex'
//            liveDrag: true
//            ,tableCel
        });
//        $('#book-table').width(605);
    });
</script>
</body>
</html>