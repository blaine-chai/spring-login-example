<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setCharacterEncoding("utf-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title>REMOS</title>
    <script src="/js/jquery.min.js"></script>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet"
          href="/css/bootstrap.min.css">
    <!-- 부가적인 테마 -->

    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="/js/bootstrap.min.js"></script>
    <style type="text/css">
        @media screen and (max-width: 1080px) {
            .datepicker-container {
                display: none;
            }
        }

        .graph-overall-item {
            cursor: pointer;
        }

        .graph-overall-item:hover {
            background: rgba(100, 100, 100, 0.1)
        }

        svg {
            /*background-color: #fff;*/
            border-radius: 4px;
            /*fill: gray;*/
        }

        svg g path.line {
            /*stroke-width: 2px;*/
            /*stroke-opacity: 0.5;*/
            /*fill: none;*/
        }

        svg g path.line.total {
            /*stroke-dasharray: 3;*/
            /*stroke-width: 2px;*/
            /*stroke-opacity: 0.7;*/
            /*fill: none;*/
        }

        svg g circle {
            /*fill: #1db34f;*/
            /*stroke: #16873c;*/
            /*stroke-width: 2px;*/
        }

        .axis path,
        .axis line {
            /*fill: none;*/
            /*stroke: grey;*/
            /*stroke-width: 1;*/
            /*shape-rendering: crispEdges;*/
        }

        .y.axis text {
            /*font-size: 10px;*/
        }

        .x.axis text {
            /*font-size: 10px;*/
        }

        .graph-container {
            cursor: pointer;
        }
    </style>

    <!-- Latest compiled and minified CSS -->
    <link href="/css/main-style.css" rel="stylesheet" type="text/css">
    <link href="/css/jquery.datetimepicker.css" rel="stylesheet" type="text/css">

    <!-- Latest compiled and minified JavaScript -->

    <!-- Latest compiled and minified Locales -->
    <script src="/js/colResizable-1.6.js"></script>
    <script src="/js/moment.js"></script>
    <script src="/js/jquery.datetimepicker.full.js"></script>
    <script src="/js/jquery-ui.js"></script>
    <script src="/js/FileSaver.js"></script>
    <script src="/js/Blob.js"></script>
    <script src="/js/d3.v3.min.js"></script>
    <script src="/js/randomColor.js"></script>
    <script src="/js/jquery.base64.js"></script>

</head>
<body>
<div id="header-wrapper">
    <img src="/imgs/logo.png" style="margin: 0 auto;">
    <div id="user-info-container" class=""
         style="position: absolute;top:50%;right: 20px;padding-right: 5px;color:#646464;"><span
            style="padding-right: 15px; padding-left:5px;">${userId}</span><c:if test="${userType.equals(\"admin\")}"><a
            href="/admin" style="margin-right: 5px;"><label class="btn badge logout-btn" style="">admin<span
            class="glyphicon glyphicon-cog" style="padding-left: 10px;"></span></label></a></c:if><a
            href="/logout"><label class="btn badge logout-btn" style="">로그아웃<span class="glyphicon glyphicon-log-out"
                                                                                  style="padding-left: 10px;"></span></label></a>
    </div>
</div>
<div id="nav-wrapper">
    <div id="nav">
        <a href="/main">
            <div class="header-button btn">
                <div class="glyphicon glyphicon-bell"><span class="badge alarm-badge"
                                                            style="position:absolute;vertical-align: middle;font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;"></span>
                </div>
                <div>알림</div>
            </div>
        </a>
        <a href="/main/search">
            <div class="header-button btn ">
                <div class="glyphicon glyphicon-search"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>검색</div>
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
            <div class="header-button btn active">
                <div class="glyphicon glyphicon-signal"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>통계</div>
            </div>
        </a>
    </div>
</div>

<div id="content" class="col-xs-12" style="background: #efefef;">
    <div id="content-wrapper" style="margin-top: 15px; height: 100%;">
        <%--<div id="total-graph-container" class="col-md-6" style="margin-top: 15px; height: 100%;">--%>
        <div id="total-book-graph-group" class="col-xs-5" style="height: 100%;">
            <div class="panel panel-default"
                 style="position: relative;height: calc(50% - 45px);background: #f8f8f8;margin: 10px;margin-top: 15px;margin-bottom: 30px;">
                <div class="panel panel-default"
                     style="position: relative;height: 40px;margin-bottom: 0;margin-left: 15px;margin-right: 15px;margin-top: 15px;">
                    <div class="graph-title-text"
                         style="height: 40px;line-height: 40px;vertical-align: middle;margin-left: 20px;float: left"
                         title="total" onclick="titleClickListener(this);return false;">EVENTS(MSG)
                    </div>
                    <div class="datepicker-container"
                         style="width: 170px;text-align: center;margin: auto;float: left;position:absolute;right:125px;bottom:7px;">
                        <div class="" style="padding: 0; margin:0 auto; float: left;"><input
                                id="total-book-graph-datepicker-1" data-provide="datepicker"
                                style="width: 80px;text-align: center;font-size: 12px;float: left;">
                        </div>
                        <div style="float:left; width: 10px; font-size:11px;text-align: center; padding:0;vertical-align: middle;line-height: 23px;">
                            ~
                        </div>
                        <div style="padding:0;margin:0 auto;float: left;"><input id="total-book-graph-datepicker-2"
                                                                                 data-provide="datepicker"
                                                                                 style="width: 80px;text-align: center;font-size: 12px;float: left;">
                        </div>
                    </div>
                    <div class="btn-group" style="position:absolute;right:65px;bottom:4px;">
                        <button type="button" class="btn btn-default btn-sm dropdown-toggle total-book-dropdown"
                                data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false" style="width: 55px">
                            <span class="search-category-option">월별</span>
                            <div style="display: inline-block"><span class="caret"></span><span
                                    class="sr-only"></span>
                            </div>
                        </button>
                        <ul class="dropdown-menu search-category-selector">
                            <li><a role="total-book-dropdown" onclick="getSearchTotalData('일별');return false;"
                                   period="0" href="#">일별</a></li>
                            <li><a role="total-book-dropdown" onclick="getSearchTotalData('월별');return false;"
                                   period="2" tabindex="-1" href="#">월별</a></li>
                        </ul>
                    </div>
                    <div class="btn-group2" style="position:absolute;right:10px;bottom:4px;">
                       <button type="button"
                              class="btn btn-primary btn-sm dropdown-toggle author-dropdown"
                              data-toggle="dropdown" aria-haspopup="true"
                              aria-expanded="false" style="width:50px">
                          <span class="search-category-option">그룹</span>
                      </button>
                      <div class="dropdown-menu panel panel-default checkbox"
                           style="position:absolute;width: 200px;min-height: 50px;background: rgba(255, 255, 255, 0.95);z-index: 10;left: -150px;top: 25px;overflow-y:auto;text-align: left;">
                          <c:forEach items="${userGroups}" var="userGroup">
                              <label style="margin-left: 2px;width:85px;font-size: 12px;max-width:85px;">
                                  <input style="width: 20px;" type="radio" name="groups1"
                                         onclick="getSearchTotalData2();"
                                         value="${userGroup.groupName.groupName}"
                                         checked="checked"
                                         style="">${userGroup.groupName.groupName}</label>
                          </c:forEach>
                      </div>
                    </div>

                </div>
                <div id="total-book-graph-container" class="panel panel-default graph-container"
                     style="margin-top: 20px;width: calc(100% - 30px);height: calc(100% - 91px);margin-left: 15px;margin-right: 15px;margin-bottom: 15px;position: relative;">
                </div>
            </div>
            <div class="panel panel-default"
                 style="position: relative;height: calc(50% - 45px);background: #f8f8f8;margin: 10px;margin-top: 15px;">
                <div class="panel panel-default"
                     style="position: relative;height: 40px;margin-bottom: 0;margin-left: 15px;margin-right: 15px;margin-top: 15px;">
                    <div class="graph-title-text"
                         style="height: 40px;line-height: 40px;vertical-align: middle;margin-left: 20px;float: left;"
                         title="author-total"
                         onclick="titleClickListener(this);return false;">EVENTS(DB)
                    </div>
                    <div class="datepicker-container"
                         style="width: 170px;text-align: center;margin: auto;float: left;position:absolute;right:125px;bottom:7px;">
                        <div class="" style="padding: 0; margin:0 auto; float: left;"><input
                                id="total-author-graph-datepicker-1" data-provide="datepicker"
                                style="width: 80px;text-align: center;font-size: 12px;float: left;">
                        </div>
                        <div style="float:left; width: 10px; font-size:11px;text-align: center; padding:0;vertical-align: middle;line-height: 23px;">
                            ~
                        </div>
                        <div style="padding:0;margin:0 auto;float: left;"><input id="total-author-graph-datepicker-2"
                                                                                 data-provide="datepicker"
                                                                                 style="width: 80px;text-align: center;font-size: 12px;float: left;">
                        </div>
                    </div>
                    <div class="btn-group" style="position:absolute;right:65px;bottom:4px;">
                        <button type="button" class="btn btn-default btn-sm dropdown-toggle total-book-dropdown"
                                data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false" style="width: 55px">
                            <span class="search-category-option">월별</span>
                            <div style="display: inline-block"><span class="caret"></span><span
                                    class="sr-only"></span>
                            </div>
                        </button>
                        <ul class="dropdown-menu search-category-selector" role="menu"
                            aria-labelledby="dropdownMenu1">
                            <li><a role="total-author-dropdown" onclick="getAuthorTotalGraphData('일별');return false;"
                                   period="0" tabindex="-1" href="#">일별</a></li>
                            <li><a role="total-author-dropdown" onclick="getAuthorTotalGraphData('월별');return false;"
                                   period="2" tabindex="-1" href="#">월별</a></li>
                        </ul>
                    </div>
                    <div class="btn-group2" style="position:absolute;right:10px;bottom:4px;">
                       <button type="button"
                              class="btn btn-primary btn-sm dropdown-toggle author-dropdown"
                              data-toggle="dropdown" aria-haspopup="true"
                              aria-expanded="false" style="width:50px">
                          <span class="search-category-option">그룹</span>
                      </button>
                      <div class="dropdown-menu panel panel-default checkbox"
                           style="position:absolute;width: 200px;min-height: 50px;background: rgba(255, 255, 255, 0.95);z-index: 10;left: -150px;top: 25px;overflow-y:auto;text-align: left;">
                          <c:forEach items="${userGroups}" var="userGroup">
                              <label style="margin-left: 2px;width:85px;font-size: 12px;max-width:85px;">
                                  <input style="width: 20px;" type="radio" name="groups2"
                                  		 onclick="getAuthorTotalGraphData2();"
                                         value="${userGroup.groupName.groupName}"
                                         checked="checked"
                                         style="">${userGroup.groupName.groupName}</label>
                          </c:forEach>
                      </div>
                    </div>
                </div>
                <div id="total-author-graph-container" class="panel panel-default graph-container"
                     style="margin-top: 20px;width: calc(100% - 30px);height: calc(100% - 91px);margin-left: 15px;margin-right: 15px;margin-bottom: 15px;position: relative;">
                </div>
            </div>
        </div>
        <div class="col-xs-7" style="height: 100%;padding: 15px;padding-left: 0;">
            <div id="author-component-container" class="panel panel-default"
                 style="float: left; width:100%;height: calc(100% - 30px);position: relative;background: #f8f8f8;">
                <div style="width: calc(100% - 40px);padding: 20px;position: relative;height: 142px;margin-bottom: 10px;margin-top: 20px;margin-left: 20px;"
                     class="panel panel-default">
                    <div style="max-width: 500px;margin: auto;">
                        <div id="statistic-author-input-container">
                            <div class="input-group input-group-sm"
                                 style="float: left; width: calc(100% - 200px);margin-bottom: 10px;padding-right: 20px;">
                                <div id="search-option-radio-wrapper" class="btn-group btn-group-justified"
                                     data-toggle="buttons" style="padding-top: 0;">
                                    <label class="btn btn-default btn-sm active"><input type="radio" name="options"
                                                                                        id="option1"
                                                                                        autocomplete="off" checked>문자포함</label>
                                    <label class="btn btn-default btn-sm"><input type="radio" name="options"
                                                                                 id="option2"
                                                                                 autocomplete="off">형태소</label>
                                    <label class="btn btn-default btn-sm"><input type="radio" name="options"
                                                                                 id="option3"
                                                                                 autocomplete="off">완전일치</label>
                                </div>
                                <div id="search-input-wrapper" class="" style="padding-left: 0;">
                                    <div class="input-group input-group-sm search-input-group">
                                        <div class="dropdown input-group-btn">
                                            <div class="btn-group" style="">
                                                <button type="button" class="btn btn-default btn-sm dropdown-toggle"
                                                        data-toggle="dropdown" aria-haspopup="true"
                                                        aria-expanded="false"
                                                        style="width: 50px">
                                                    <span class="search-category-option">내용</span>
                                                    <div style="display: inline-block"><span class="caret"></span><span
                                                            class="sr-only"></span>
                                                    </div>
                                                </button>
                                                <ul class="dropdown-menu search-category-selector" role="menu"
                                                    aria-labelledby="dropdownMenu1">
                                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">내용</a></li>
                                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">저자</a></li>
                                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">순위</a></li>
                                                    <%--<li role="presentation"><a role="menuitem" tabindex="-1"href="#">참조</a></li>--%>
                                                </ul>
                                            </div>
                                        </div>
                                        <input type="text" class="form-control col-xs-4 search-input"
                                               placeholder="검색어를 입력해주세요.">
                                        <div class="dropdown input-group-btn">
                                            <div class="btn-group">
                                                <button type="button" class="btn btn-default btn-sm dropdown-toggle"
                                                        data-toggle="dropdown" aria-haspopup="true"
                                                        aria-expanded="false"
                                                        style="width: 50px;padding-left: 7px;"><span
                                                        class="search-operator-option">SEL</span>
                                                    <div style="display: inline-block"><span class="caret"></span><span
                                                            class="sr-only"></span></div>
                                                </button>
                                                <ul class="dropdown-menu search-category-selector" role="menu"
                                                    aria-labelledby="dropdownMenu2">
                                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">SEL</a>
                                                    </li>
                                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">AND</a>
                                                    </li>
                                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">O
                                                        R</a></li>
                                                </ul>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div id="search-input-wrapper2" class="" style="padding-right:0;">
                                    <div class="input-group input-group-sm search-input-group  ">
                                        <div class="dropdown input-group-btn">
                                            <div class="btn-group" style="">
                                                <button type="button" class="btn btn-default btn-sm dropdown-toggle"
                                                        data-toggle="dropdown" aria-haspopup="true"
                                                        aria-expanded="false"
                                                        style="width: 50px;">
                                                    <span class="search-category-option">내용</span>
                                                    <div style="display: inline-block"><span class="caret"></span><span
                                                            class="sr-only"></span>
                                                    </div>
                                                </button>
                                                <ul class="dropdown-menu search-category-selector" role="menu"
                                                    aria-labelledby="dropdownMenu1">
                                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">내용</a></li>
                                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">저자</a></li>
                                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">순위</a></li>
                                                    <%--<li role="presentation"><a role="menuitem" tabindex="-1"href="#">참조</a></li>--%>
                                                </ul>
                                            </div>
                                        </div>
                                        <input type="text" class="form-control col-xs-4 search-input"
                                               placeholder="검색어를 입력해주세요.">
                                        <div class="dropdown input-group-btn">
                                            <div class="btn-group">
                                                <button type="button" class="btn btn-default btn-sm"
                                                        style="width: 50px; padding-left: 7px;" disabled><span
                                                        class="search-operator-option">-</span>

                                                </button>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div style="float: left;width: 200px;margin-bottom: 10px;">
                                <div class="author-datepicker-container"
                                     style="height: 30px;width: 100%">
                                    <div style="position: relative;height: 30px;text-align: center;margin: 0 auto;width: 200px;">
                                        <div style="display: inline-block">
                                            <div class="btn-group"
                                                 style="display: inline-block; text-align: center;float: left;margin-right: 10px;">
                                                <div class="btn-group" style="float:left;margin: auto;">
                                                    <button type="button"
                                                            class="btn btn-default btn-sm dropdown-toggle author-dropdown"
                                                            data-toggle="dropdown" aria-haspopup="true"
                                                            aria-expanded="false" style="width: 70px">
                                                        <span class="search-category-option">MSG</span>
                                                        <div style="display: inline-block"><span
                                                                class="caret"></span><span
                                                                class="sr-only"></span>
                                                        </div>
                                                    </button>
                                                    <ul class="dropdown-menu search-category-selector" role="menu"
                                                        aria-labelledby="dropdownMenu1">
                                                        <li><a role="author-dropdown" period="0" tabindex="-1" href="#">MSG</a></li>
                                                        <li><a role="author-dropdown" period="3" tabindex="-1" href="#">DB</a></li>
                                                    </ul>
                                                </div>
                                                <div class="btn-group" style="float:left; margin: auto;">
                                                    <button type="button"
                                                            class="btn btn-default btn-sm dropdown-toggle author-dropdown"
                                                            data-toggle="dropdown" aria-haspopup="true"
                                                            aria-expanded="false" style="width: 70px">
                                                        <span class="search-category-option">월별</span>
                                                        <div style="display: inline-block"><span
                                                                class="caret"></span><span
                                                                class="sr-only"></span>
                                                        </div>
                                                    </button>
                                                    <ul class="dropdown-menu search-category-selector" role="menu"
                                                        aria-labelledby="dropdownMenu1">
                                                        <li><a role="author-dropdown" period="2" tabindex="-1"
                                                               href="#">일별</a>
                                                        </li>
                                                        <li><a role="author-dropdown" period="3" tabindex="-1"
                                                               href="#">월별</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="btn-group"
                                                 style="float: left;display: inline-block;position: relative">
                                                <button type="button"
                                                        class="btn btn-primary btn-sm dropdown-toggle author-dropdown"
                                                        data-toggle="dropdown" aria-haspopup="true"
                                                        aria-expanded="false" style="width:50px">
                                                    <span class="search-category-option">그룹</span>
                                                </button>
                                                <div class="dropdown-menu panel panel-default checkbox"
                                                     style="position:absolute;width: 300px;min-height: 50px;background: rgba(255, 255, 255, 0.95);z-index: 10;left: -250px;top: 25px;overflow-y:auto;text-align: left;">
                                                    <c:forEach items="${userGroups}" var="userGroup">
                                                        <label style="margin-left: 2px;width:85px;font-size: 12px;max-width:85px;">
                                                            <input style="width: 20px;" type="radio" name="groups"
                                                                   value="${userGroup.groupName.groupName}"
                                                                   checked="checked"
                                                                   style="">${userGroup.groupName.groupName}</label>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="width: 200px;text-align: center;display: flex;margin: auto;margin-top: 10px;">
                                            <div class="" style="padding: 0; margin:0 auto; float: left;"><input
                                                    id="datepicker1" data-provide="datepicker"
                                                    style="width: 90px;text-align: center;font-size: 12px;float: left;">
                                            </div>
                                            <div style="float:left; width: 20px; font-size:11px;text-align: center; padding:0;vertical-align: middle;line-height: 23px;">
                                                ~
                                            </div>
                                            <div style="padding:0;margin:0 auto;float: left;"><input id="datepicker2"
                                                                                                     data-provide="datepicker"
                                                                                                     style="width: 90px;text-align: center;font-size: 12px;float: left;">
                                            </div>
                                        </div>
                                        <div style="margin-top: 7px;width: 200px; display: inline-block; text-align: center;">
                                            <div class="btn-group" style="width:200px;margin:0 auto;">
                                                <label style="width: 50%;max-width: 100px;" id="author-graph-add-btn"
                                                       class="btn btn-default btn-sm">추가</label>
                                                <label style="width: 50%;max-width: 100px;" id="author-graph-new-btn"
                                                       class="btn btn-default btn-primary btn-sm">신규</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div id="author-graph-container" class="panel panel-default graph-container"
                     style="margin-top: 5px;height: calc(100% - 192px);float: left;width: calc(100% - 40px);background: #fff;margin-left: 20px;margin-right: 20px; position:relative;">

                    <%--<div id="author-graph-container" class="col-md-6" style="margin-top: 15px; height: 100%;">--%>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" charset="UTF-8" src="/js/line-graph.js"></script>
<%--<script type="text/javascript" charset="UTF-8" src="/js/alarm-update.js"></script>--%>
<script type="text/javascript" charset="UTF-8" src="/js/auto-logout.js"></script>
<script type="text/javascript" charset="UTF-8" src="/js/table-to-csv.js"></script>
<script type="text/javascript" charset="UTF-8">
    var relStartPos = new Object();
    relStartPos.left = 100;
    relStartPos.top = 200;
    relStartPos.iLeft = 100;
    relStartPos.iTop = 200;
    relStartPos.maxLeft = 300;
    relStartPos.maxTop = 300;
    relStartPos.count = 0;
    var totalGraph;
    var authorGraph;
    var authorTotalGraph;
    var graphCount = 0;

    var loadingRing = $('<img class="loading-ring" src="/imgs/30.gif" style="position: absolute;right: 200px; top: 180px;">');

    function setRelTablePos() {
        if (relStartPos.top < relStartPos.maxTop) {
            relStartPos.left += 15;
            relStartPos.top += 15;
        } else {
            relStartPos.count++;
            relStartPos.left = relStartPos.iLeft + (relStartPos.count * 15);
            relStartPos.top = relStartPos.iTop;
        }
    }

    function titleClickListener(element) {
        var el = $(element);
//        $('.graph-title-text').click(function(){

        var graphModule;
        if (el.attr('title') == 'total') {
            graphModule = totalGraph;
        } else {
            graphModule = authorTotalGraph;
        }

        var result = graphModule.getData();
        var relativeTitle = el.text();
        var tmpHtml = $('<div class="alert bg-white alert-dismissible fade in border-gray relative-table-wrapper" style="position: absolute; z-index: 10; width: 250px;' +
                ' left:' + relStartPos.left + 'px;top:' + relStartPos.top + 'px;" role="alert">' +
                '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                '<span aria-hidden="true">×</span>' +
                '</button>' +
                '<div class="relative-title">' + relativeTitle + '</div>' +
                '<div class="draggable-content-container" style="margin-top: 5px;">' +
                '<div id="search-result-export-container" style="position: relative;height: 35px;">' +
                '<div class="total-number" style="position:absolute; text-align: right;font-size: 12px;line-height: 30px;vertical-align: middle;">Total : ' + graphModule.getTotalData()[graphModule.getTotalData().length - 1]['total'].format() + '</div>' +
                '<a class="btn btn-default btn-sm btn-export" style="right: 0;position: absolute;">내보내기</a></div>' +
                '<div style="overflow: scroll;height: 300px;">' +
                '<table class="table table-hover table-fixed table-bordered table-striped table-condensed" style="font-size: 11px; margin-bottom: 0;">' +
                '<thead></thead>' +
                '<tbody></tbody></table></div>' +
                '</div>');
        setRelTablePos();

        var thEl = $('<tr>' +
                '<th>날짜</th>' +
                '<th>개수</th>' +
                '</tr>');
        tmpHtml.find('thead').append(thEl);

        $.each(result, function (i, mResult) {
            var tmpEl = $('<tr><td>' + mResult.index + '</td>' +
                    '<td style="text-align: right;padding-right: 10px;">' + mResult.total.format() + '</td>' +
                    '</tr>');
            tmpHtml.find('tbody').append(tmpEl);
        });

        $('body').append(tmpHtml);
        tmpHtml.draggable({cancel: '.draggable-content-container'});

        tmpHtml.find('.btn-export').click(function (event) {
            exportTableToCSVInStatistics.apply(this, [$(tmpHtml.find('table')), 'export.csv', graphModule.getTotalData()[graphModule.getTotalData().length - 1]['total'].format()]);
        });
    }

    $(document).ready(function () {
        $(document).ajaxComplete(function (e, xhr, settings) {
            if (xhr.status === 403) {
                window.location.replace('/')
            }
        });

        authorTotalGraph = GraphModule.graph({graphOverall: false});
        totalGraph = GraphModule.graph({graphOverall: false});

        $('.dropdown-menu.panel.panel-default.checkbox').on('click', function (event) {
            event.stopPropagation();
        });
//        $('.graph-overall').draggable({
//            containment: '#author-graph-container'
//        });

        $(window).resize(function () {
            $('#content').height($(window).height() - 197);
            totalGraph.refresh();
            authorTotalGraph.refresh();
            if (authorGraph != undefined) {
                authorGraph.refresh();
            }
        });
        $('#content').height($(window).height() - 197);

        handleOperatorSelect();

        $("input:radio[name='groups']").eq(0).prop("checked", true);
        $("input:radio[name='groups']:radio[value='전부']").prop("checked", true);
        $("input:radio[name='groups1']").eq(0).prop("checked", true);
        $("input:radio[name='groups1']:radio[value='전부']").prop("checked", true);
        $("input:radio[name='groups2']").eq(0).prop("checked", true);
        $("input:radio[name='groups2']:radio[value='전부']").prop("checked", true);

        $('#author-graph-add-btn').click(function (e) {		// 추가 버튼을 클릭할 때
            if (authorList.length == 0) $('#author-graph-new-btn').click();
            else            {
               	$('#author-graph-container').append(loadingRing);
            	addAuthorGraphData();
            }
        });

        $('#author-graph-new-btn').click(function (e) {		// 신규 버튼을 클릭할 때
            graphCount = 1;
            if (authorGraph != undefined) {
                authorGraph.removeNameList();
                authorGraph.removeData();
                authorGraph.removeSvg();
            }
            $('#author-graph-container').append(loadingRing);
            getNewAuthorGraphData();
        });

        fetch_unix_timestamp = function () {     	//return parseInt(new Date().getTime().toString().substring(0, 10));
            return Math.floor(new Date().getTime() / 1000);
        };

        var timestamp = fetch_unix_timestamp();
        console.log(timestamp);

        console.log(timeConverter(timestamp - 3600 * 24 * 50));

        var ttt = timeConverter(timestamp - 3600 * 24 * 730);

        $('#datepicker1').datetimepicker({
            format: 'Y/m/d',
            value: ttt
        });

        $('#datepicker2').datetimepicker({
            format: 'Y/m/d',
            value: new Date()
        });

        $('#total-book-graph-datepicker-1').datetimepicker({
            format: 'Y/m/d',
            value: ''
        });

        $('#total-book-graph-datepicker-2').datetimepicker({
            format: 'Y/m/d',
            value: ''
        });

        $('#total-author-graph-datepicker-1').datetimepicker({
            format: 'Y/m/d',
            value: ''
        });

        $('#total-author-graph-datepicker-2').datetimepicker({
            format: 'Y/m/d',
            value: ''
        });

        getSearchTotalData($('.search-category-option').eq(0).text());
        getAuthorTotalGraphData($('.search-category-option').eq(1).text());

        $('label[name=dateOption]').click(function () {
            if ($(this).text() == 'MSG') $(this).text('DB');
            else 						 $(this).text('MSG');
        });
    });

    var authorList = [];
    var aList = "";
    var getNewAuthorGraphData = (function () {
        authorList = [];
        aList = "";
        var searchWord = searchInfo();
        if (searchWord == "") {
            $('.loading-ring').remove();
        	return;
        }

        var keyword = "";

        if ($('.search-operator-option').eq(0).text() == "SEL")
            keyword = $('.search-input').eq(0).val();
        else if ($('.search-operator-option').eq(0).text() == "AND")
            keyword = $('.search-input').eq(0).val() + "&" + $('.search-input').eq(1).val();
        else
            keyword = $('.search-input').eq(0).val() + "|" + $('.search-input').eq(1).val();

        keyword += "@" + $('input[name=groups]:checked').val();

        aList = "";
        var id = "stat3";

        authorList.push(keyword);
        callAjax(id, 0, aList, keyword, searchWord);
    });

    var addAuthorGraphData = (function () {
        //var author = [];
        var searchWord = searchInfo();
        if (searchWord == "") {
            $('.loading-ring').remove();
        	return;
        }

        var keyword = "";

        if ($('.search-operator-option').eq(0).text() == "SEL")
            keyword = $('.search-input').eq(0).val();
        else if ($('.search-operator-option').eq(0).text() == "AND")
            keyword = $('.search-input').eq(0).val() + "&" + $('.search-input').eq(1).val();
        else
            keyword = $('.search-input').eq(0).val() + "|" + $('.search-input').eq(1).val();

        keyword += "@" + $('input[name=groups]:checked').val();
        var beGood = false;
//        console.log(keyword + " : " + authorList[i] + " : " + beGood);
        for (var i = 0; i < authorList.length; i++) {
            if (keyword == authorList[i]) beGood = true;
            console.log(keyword + " : " + authorList[i] + " : " + beGood);
        }
        if (beGood) {
            alert("중복 검색입니다!!!");
            $('.loading-ring').remove();
            return;
        }
        if (authorList.length >= 10) {
            alert("그래프는 10개까지 추가 할 수 있습니다.");
            $('.loading-ring').remove();
            return;
        }

        authorGraph.removeSvg();
        var id = "stat3";
        var sel = 1;

        authorList.push(keyword);
        callAjax(id, sel, aList, keyword, searchWord);
    });

    var setTime = 0;
    function callAjax(id, sel, aList, keyword, searchWord) {
        $.ajax({
            url: "/main/statistics/search-author-data",
            type: "post",
            data: {
                id: id,
                sel: sel,
                authorJson: aList,
                keyword: keyword,
                msg: searchWord
            },
            success: function (responseData) {
                var tdata = JSON.parse(responseData);
                console.log(tdata.id + " : " + tdata.sel + " : " + tdata.contents);
                if (tdata.contents == "NotOK") {
                    setTime = setTimeout(function () {
                        callAjax(tdata.id, tdata.sel, aList, tdata.keyword, searchWord);
                    }, 1000);
                }
                else if (tdata.contents == "NoData") {
                    $('.loading-ring').remove();
                    alert("다시 한번 검색해 주세요. 동일한 결과가 반복될 경우에는 데이터베이스에 저장된 자료가 없을 수 있습니다!!!");
                }
                else {
                    if (sel == 0) {
                        setTime = setTimeout(function () {
                            callAjax(tdata.id, 2, aList, tdata.keyword, searchWord);
                        }, 100);
                    }
                    else if (sel == 1) {
                        setTime = setTimeout(function () {
                            callAjax(tdata.id, 3, aList, tdata.keyword, searchWord);
                        }, 100);
                    }
                    else if (sel == 2) {
                        var resultData = JSON.parse(tdata.resultList);
                        aList = tdata.resultList;
                        //                console.error(resultData);
                        authorGraph = GraphModule.graph();
                        authorGraph.setMargin({top: 20, right: 60, bottom: 30, left: 60});
                        authorGraph.setGraphContainer('#author-graph-container');
                        authorGraph.removeNameList();
                        authorGraph.removeData();
                        $.each(authorList, function (i, author) {
                            authorGraph.addNameList(author);
                        });
                        authorGraph.setData(resultData);
                        authorGraph.init();
                        $('.loading-ring').remove();
                   }
                    else if (sel == 3) {
                        var resultData = JSON.parse(tdata.resultList);
                        aList = tdata.resultList;
                        //console.error(resultData);
                        authorGraph.removeSvg();
                        authorGraph.setGraphContainer('#author-graph-container');
                        authorGraph.setMargin({top: 20, right: 60, bottom: 30, left: 60});
                        authorGraph.addNameList(tdata.keyword);
                        authorGraph.addData(tdata.keyword, resultData);
                        authorGraph.refresh();
                        $('.loading-ring').remove();
                    }
                }
            }
        })
    }

    var getSearchTotalData2 = (function () {
        //$("input:radio[name='groups2']").eq(0).prop("checked", true);
        //$(element).prop("checked", true);
        getSearchTotalData($('.search-category-option').eq(0).text());
    });

    var getSearchTotalData = (function (category) {
        totalGraph.removeNameList();
        totalGraph.removeData();
        totalGraph.removeSvg();
        //console.log($('#total-book-graph-datepicker-1').val());
        //console.log($('#total-book-graph-datepicker-2').val());

        //var startTime = "2015/01/01 00:00:00";
        var startTime = $('#total-book-graph-datepicker-1').val() + " 00:00:00";
        var endTime = $('#total-book-graph-datepicker-2').val() + " 23:59:59";
        if($('#total-book-graph-datepicker-1').val() == "") startTime = "";
        if($('#total-book-graph-datepicker-2').val() == "") endTime = "";

        if (category == '일별') category = 'MSG_' + 'daily';
        else                  category = 'MSG_' + 'monthly';
        console.log(startTime + '>' + category);

        $.ajax({
            url: "/main/statistics/search-total-data",
            type: "post",
            data: {
                "id": "stat1",
                "searchPeriod": startTime+"-"+endTime,
                "groups": $('input[name=groups1]:checked').val(),
                "category": category
            },
            success: function (responseData) {
                var resultData = JSON.parse(responseData);
                //console.error(resultData);
                totalGraph = GraphModule.graph({graphOverall: false});
                totalGraph.setGraphContainer('#total-book-graph-container');
//				totalGraph.addData(responseData);

                totalGraph.addNameList('total');
                totalGraph.setData(resultData);
                totalGraph.init();
            }
        });
    });

    var getAuthorTotalGraphData2 = (function () {
		getAuthorTotalGraphData($('.search-category-option').eq(1).text());
    });

    var getAuthorTotalGraphData = (function (category) {
        authorTotalGraph.removeNameList();
        authorTotalGraph.removeData();
        authorTotalGraph.removeSvg();
        //console.log($('#total-author-graph-datepicker-1').val());
        //console.log($('#total-author-graph-datepicker-2').val());
        var startTime = $('#total-author-graph-datepicker-1').val() + " 00:00:00";
        var endTime = $('#total-author-graph-datepicker-2').val() + " 23:59:59";
        if($('#total-author-graph-datepicker-1').val() == "") startTime = "";
        if($('#total-author-graph-datepicker-2').val() == "") endTime = "";

        //var startTime = "2016/11/01 00:00:00";
        if (category == '일별') category = 'DB_' + 'daily';
        else                  category = 'DB_' + 'monthly';

        console.log(startTime + '>' + category);
        $.ajax({
            url: "/main/statistics/search-total-data",
            type: "post",
            data: {
                "id": "stat2",
                "searchPeriod": startTime+"-"+endTime,
                "groups": $('input[name=groups2]:checked').val(),
                "category": category
            },
            success: function (responseData) {

                var resultData = JSON.parse(responseData);
                //console.error(resultData);
                authorTotalGraph = GraphModule.graph({graphOverall: false});
                authorTotalGraph.setGraphContainer('#total-author-graph-container');
                authorTotalGraph.addNameList('total');
                authorTotalGraph.setData(resultData);
                authorTotalGraph.init();
            }
        })

    });

    function handleOperatorSelect() {
        $('.search-category-selector li a').click(function (e) {
            $($(this).parent().parent().parent()).find('button span').eq(0).text($(this).text());
        });
    }


    function wordCheck(word1) {
        var word = word1.replace(/(^[&|\s]*)|([&|\s]*$)/g, "");
        //console.log(word);

        word = word.replace(/(&+)\s*(&+)/g, "&");
        word = word.replace(/(\|+)\s*(\|+)/g, "|");
        word = word.replace(/(\|+)\s*(&+)/g, "|&");
        word = word.replace(/(&+)\s*(\|+)/g, "&|");
        //console.log(word);

        tmp = word.split("&\|");
        if (tmp.length > 1) {
            alert("검색어를 다시 입력해주세요.");
            return "";
        }

        tmp = word.split("\|&");
        if (tmp.length > 1) {
            alert("검색어를 다시 입력해주세요.");
            return "";
        }

        word = word.replace(/(\s*)&+(\s*)/g, "<AND>");
        word = word.replace(/(\s*)\|+(\s*)/g, "<OR>");
        word = word.replace(/(\s+)/g, "<OR>");
        word = word.replace(/<OR>/g, " | ");
        word = word.replace(/<AND>/g, " & ");
        //console.log(word);
        if (word == "") {
            alert("검색어를 다시 입력해주세요.");
            //isOK = false;
            return "";
        }
        return word;
    }

    function searchInfo() {
        var SearchWord = "";

        var isOK = true;
        var typeInfo = $('#search-option-radio-wrapper>.active').text();
        var categoryEls = $('.search-category-option');
        var inputEls = $('.search-input');
        var operatorEls = $('.search-operator-option');
        var data = new Object();
        var list = [];
        var obj;
        SearchWord = "";

        var input = wordCheck(inputEls.eq(0).val());
        if (input == "") isOK = false;

        var category = categoryEls.eq(4).text();
        if (category == "내용") SearchWord += "indexA^" + input;
        else if (category == "저자") SearchWord += "indexB^" + input;
        else if (category == "순위") {
        	if((input >= 1) && (input <= 8)) SearchWord += "priority^" + input;
        	else {
        		alert("우선순위의 범위는 1~8입니다.");
        		isOK = false;
        	}
        }

        var operator = operatorEls.eq(0).text();
        if (operator != "SEL") {
            if (operator == "O R") SearchWord += " <OR> ";
            else if (operator == "AND") SearchWord += " <AND> ";

            input = wordCheck(inputEls.eq(1).val());
            if (input == "") isOK = false;

            var category = categoryEls.eq(5).text();
            if (category == "내용") SearchWord += "indexA^" + input;
            else if (category == "저자") SearchWord += "indexB^" + input;
            else if (category == "순위") {
            	if((input >= '1') && (input <= '9')) SearchWord += "priority^" + input;
            	else {
            		alert("우선순위의 범위는 1~9입니다.");
            		isOK = false;
            	}
            }
        }

        SearchWord += ">" + typeInfo;
		var from = $('#datepicker1').val() + " 00:00:00";
		var to = $('#datepicker2').val() + " 23:59:59";
		if ($('#datepicker1').val() == '') {
			isOK = false; //from = "";
        	alert("시작 시간을 입력하세요.");
		}
		if ($('#datepicker2').val() == '') {
			isOK = false; //to = "";
        	alert("종료 시간을 입력하세요.");
		}
        SearchWord += ">" + from + "-" + to;

        if (categoryEls.eq(7).text() == "일별")
            SearchWord += ">" + categoryEls.eq(6).text() + "_" + "daily";
        else
            SearchWord += ">" + categoryEls.eq(6).text() + "_" + "monthly";

        SearchWord += ">" + $('input[name=groups]:checked').val();

        console.log("ZZZ : " + SearchWord);
        if (!isOK) SearchWord = "";
///
        return SearchWord;
    }

    function binaryblob(selector) {
        var byteString = atob(document.querySelector(selector).toDataURL().replace(/^data:image\/(png|jpg);base64,/, ""));
        var ia = new Uint8Array(ab);
        for (var i = 0; i < byteString.length; i++) {
            ia[i] = byteString.charCodeAt(i);
        }
        var dataView = new DataView(ab);
        var blob = new Blob([dataView], {type: "image/png"});
        var DOMURL = self.URL || self.webkitURL || self;
        var newurl = DOMURL.createObjectURL(blob);

        var img = '<img src="' + newurl + '">';
        d3.select("#img").html(img);
    }

    var w = 1400, // or whatever your svg width is
            h = 700;

    function svgToCanvas() {
        // Select the first svg element
        console.error('aa');
        var svg = d3.select('svg')[0][0];
        var img = new Image();
        var serializer = new XMLSerializer();
        console.error('bb');
        var svgStr = serializer.serializeToString(svg);
        console.error('cc');
        img.src = 'data:image/svg+xml;base64,' + jQuery.base64.encode(svgStr);
        console.error(jQuery.base64.encode(svgStr));
        // You could also use the actual string without base64 encoding it:
//        img.src = "data:image/svg+xml;utf8," + svgStr;


        var canvas = document.createElement("canvas");
        document.body.appendChild(canvas);
        console.error('dd');

        canvas.width = w;
        canvas.height = h;
        console.error('ee');
        canvas.getContext('2d').drawImage(img, 0, 0, w, h);
        // Now save as png or whatever

        console.error($('canvas')[0].toDataURL());
        $('body').append($('<a download="graph.png" href="' + $('canvas')[0].toDataURL() + '">aaaaaaaaaaaaa</a>'));
        console.error('ff');
//        var tar = $('<a>b</a>');
        var filename = "hi.png";
        if (window.navigator.msSaveBlob) { // IE 10+
////            alert('IE' + csv);
            console.error('gg');
//            console.error(canvas.toDataURL().replace('data:image/png;base64,',''));
//            var data = canvas.toDataURL().replace('data:image/png;base64,', '');
//            var bytes = new Uint8Array(data.length / 2);
//
//            for (var i = 0; i < data.length; i += 2) {
//                bytes[i / 2] = parseInt(data.substring(i, i + 2), /* base = */ 16);
//            }
            console.log(canvas.msToBlob());
            window.navigator.msSaveOrOpenBlob(new Blob(canvas.msToBlob()), filename);
////            window.navigator.msSaveOrOpenBlob(new Blob([canvas.toDataURL().replace('data:image/png;base64,', '')], {type: "image/png;base64"}), filename);
            console.error('hihi');
        }
        else {
            tar.attr({
                'download': filename,
                'href': canvas.toDataURL().replace('data:image', 'data:application'),
                'target': '_blank'
            });
            $('body').append(tar);
            tar[0].click();
            console.error('tar');
//
        }
    }


    jQuery.fn.tableToCSV = function () {

        var clean_text = function (text) {
            text = text.replace(/"/g, '""');
            return '"' + text + '"';
        };
console.log(clean_text);
        $(this).each(function () {
            var table = $(this);
            var caption = $(this).find('caption').text();
            var title = [];
            var rows = [];

            $(this).find('tr').each(function () {
                var data = [];
                $(this).find('th').each(function () {
                    var text = clean_text($(this).text());
                    title.push(text);
                });
                $(this).find('td').each(function () {
                    var text = clean_text($(this).text());
                    data.push(text);
                });
                data = data.join(",");
                rows.push(data);
            });
            title = title.join(",");
            rows = rows.join("\n");

            var csv = title + rows;
            var uri = 'data:text/csv;charset=utf-8,' + encodeURIComponent(csv);
            var download_link = document.createElement('a');
            download_link.href = uri;
            var ts = new Date().getTime();
            if (caption == "") {
                download_link.download = ts + ".csv";
            } else {
                download_link.download = caption + "-" + ts + ".csv";
            }
            download_link = $(download_link);
            console.error(download_link);
//            document.body.appendChild(download_link);
            download_link.text('a');
            download_link.attr('download', ts + ".csv");
            download_link.html('<span>a</span>');
            console.error($('body').append(download_link));
            download_link.find('span').click();
            console.error(download_link.click());
		});

    };

    function timeConverter(UNIX_timestamp) {
        var a = new Date(UNIX_timestamp * 1000);
        //var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
        //var month = months[a.getMonth()];

        /*	console.log(tdata.fromDate + "-" + tdata.toDate);
         console.log(timeConverter(timestamp));
         timestamp = timeConverter(timestamp - 3600 * 24 * 30);
         console.log(timestamp);
         */
        var year = a.getFullYear();
        var month = a.getMonth()+1;
        var date = a.getDate();
        var hour = a.getHours();
        var min = a.getMinutes();
        var sec = a.getSeconds();

        if(month < 10) month = "0" + month;
        if(date < 10) date = "0" + date;
        if(hour < 10) hour = "0" + hour;
        if(min < 10) min = "0" + min;
        if(sec < 10) sec = "0" + sec;

        var time = a.getFullYear() + '/' + month + '/' + date;
        //var time = a.getFullYear() + '/' + month + '/' + date + ' ' + hour + ':' + min + ':' + sec ;

        return time;
    }

</script>
</body>
</html>