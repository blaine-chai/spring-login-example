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
        svg {
            background-color: #fff;
            border-radius: 4px;
            /*fill: gray;*/
        }

        svg g path.line {
            stroke-width: 2px;
            stroke-opacity: 0.5;
            fill: none;
        }

        svg g path.line.total {
            stroke-dasharray: 3;
            stroke-width: 2px;
            stroke-opacity: 0.7;
            fill: none;
        }

        svg g circle {
            fill: #1db34f;
            stroke: #16873c;
            stroke-width: 2px;
        }

        .axis path,
        .axis line {
            fill: none;
            stroke: grey;
            stroke-width: 1;
            shape-rendering: crispEdges;
        }

        .y.axis text {
            font-size: 10px;
        }

        .x.axis text {
            font-size: 10px;
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

</head>
<body>
<div id="header-wrapper">
    <h1>REMOS</h1>
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
                <div class="glyphicon glyphicon-bell"><span class="badge alarm-badge" style="position:absolute;vertical-align: middle;font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;"></span></div>
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
        <div id="total-graph-group" class="col-xs-5" style="height: 100%;">
            <div class="panel panel-default"
                 style="position: relative;height: calc(50% - 45px);background: #f8f8f8;margin: 10px;margin-top: 15px;margin-bottom: 30px;">
                <div class="panel panel-default"
                     style="position: relative;height: 40px;margin-bottom: 0;margin-left: 15px;margin-right: 15px;margin-top: 15px;">
                    <div class="graph-title-text"
                         style="height: 40px;line-height: 40px;vertical-align: middle;margin-left: 20px;">events
                    </div>
                    <div class="btn-group" style="position:absolute;right:10px;bottom:4px;">
                        <button type="button" class="btn btn-default btn-sm dropdown-toggle total-book-dropdown"
                                data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false" style="width: 60px">
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
                </div>
                <div id="total-book-graph-container" class="panel panel-default"
                     style="margin-top: 20px;width: calc(100% - 30px);height: calc(100% - 91px);margin-left: 15px;margin-right: 15px;margin-bottom: 15px;position: relative;">
                </div>
            </div>
            <div class="panel panel-default"
                 style="position: relative;height: calc(50% - 45px);background: #f8f8f8;margin: 10px;margin-top: 15px;">
                <div class="panel panel-default"
                     style="position: relative;height: 40px;margin-bottom: 0;margin-left: 15px;margin-right: 15px;margin-top: 15px;">
                    <div class="graph-title-text"
                         style="height: 40px;line-height: 40px;vertical-align: middle;margin-left: 20px;">events
                    </div>
                    <div class="btn-group" style="position:absolute;right:10px;bottom:4px;">
                        <button type="button" class="btn btn-default btn-sm dropdown-toggle total-book-dropdown"
                                data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false" style="width: 60px">
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
                </div>
                <div id="total-author-graph-container" class="panel panel-default"
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
                                                    <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                               href="#">내용</a>
                                                    </li>
                                                    <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                               href="#">저자</a>
                                                    </li>
                                                    <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                               href="#">참조</a>
                                                    </li>
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
                                                    <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                               href="#">내용</a>
                                                    </li>
                                                    <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                               href="#">저자</a>
                                                    </li>
                                                    <li role="presentation"><a role="menuitem" tabindex="-1"
                                                                               href="#">참조</a>
                                                    </li>
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
                                        <div style="display: inline-block; text-align: center;">
                                            <div class="btn-group" style="float:left;margin: auto;">
                                                <button type="button"
                                                        class="btn btn-default btn-sm dropdown-toggle author-dropdown"
                                                        data-toggle="dropdown" aria-haspopup="true"
                                                        aria-expanded="false" style="width: 100px">
                                                    <span class="search-category-option">MSG</span>
                                                    <div style="display: inline-block"><span class="caret"></span><span
                                                            class="sr-only"></span>
                                                    </div>
                                                </button>
                                                <ul class="dropdown-menu search-category-selector" role="menu"
                                                    aria-labelledby="dropdownMenu1">
                                                    <li><a role="author-dropdown" period="0" tabindex="-1"
                                                           href="#">MSG</a>
                                                    </li>
                                                    <li><a role="author-dropdown" period="3" tabindex="-1"
                                                           href="#">DB</a>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="btn-group" style="float:left; margin: auto;">
                                                <button type="button"
                                                        class="btn btn-default btn-sm dropdown-toggle author-dropdown"
                                                        data-toggle="dropdown" aria-haspopup="true"
                                                        aria-expanded="false" style="width: 100px">
                                                    <span class="search-category-option">월별</span>
                                                    <div style="display: inline-block"><span class="caret"></span><span
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

                <div id="author-graph-container" class="panel panel-default"
                     style="margin-top: 5px;height: calc(100% - 192px);float: left;width: calc(100% - 40px);background: #fff;margin-left: 20px;margin-right: 20px; position:relative;">

                    <%--<div id="author-graph-container" class="col-md-6" style="margin-top: 15px; height: 100%;">--%>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" charset="UTF-8" src="/js/line-graph.js"></script>
<script type="text/javascript" charset="UTF-8" src="/js/alarm-update.js"></script>
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


    $(document).ready(function () {
        $(document).ajaxComplete(function (e, xhr, settings) {
            if (xhr.status === 403) {
                window.location.replace('/')
            }
        });

        authorTotalGraph = GraphModule.graph({graphOverall: false});
        totalGraph = GraphModule.graph({graphOverall: false});
        getSearchTotalData($('.search-category-option').eq(0).text());
        getAuthorTotalGraphData($('.search-category-option').eq(1).text());

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
//        a = GraphModule.graph();
//        a.setGraphContainer('#total-graph-container');
//        a.init();

        handleOperatorSelect();
//        authorGraph = GraphModule.graph();
//        authorGraph.setGraphContainer('#author-graph-container');


        $('#author-graph-add-btn').click(function (e) {		// 추가 버튼을 클릭할 때
        	if(authorList.length == 0) $('#author-graph-new-btn').click();
        	else 			addAuthorGraphData();
        });

        $('#author-graph-new-btn').click(function (e) {		// 신규 버튼을 클릭할 때
            graphCount = 1;
            if (authorGraph != undefined) {
                authorGraph.removeNameList();
                authorGraph.removeData();
                authorGraph.removeSvg();
            }
            getNewAuthorGraphData();
        });
        fetch_unix_timestamp = function () {     	//return parseInt(new Date().getTime().toString().substring(0, 10));
            return Math.floor(new Date().getTime() / 1000);
        };

        var timestamp = fetch_unix_timestamp();
        console.log(timestamp);

        function timeConverter(UNIX_timestamp) {
            var a = new Date(UNIX_timestamp * 1000);
            //var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
            //var month = months[a.getMonth()];
            var year = a.getFullYear();
            var month = a.getMonth();
            var date = a.getDate();
            var hour = a.getHours();
            var min = a.getMinutes();
            var sec = a.getSeconds();
            //var time = date + ' ' + month + ' ' + year + ' ' + hour + ':' + min + ':' + sec ;
            var time = a.getFullYear() + "/" + (a.getMonth() + 1) + "/" + a.getDate();
            return time;
        }

        console.log(timeConverter(timestamp - 3600 * 24 * 50));

        //var d = new Date();
        //var ttt = d.getFullYear() + "/" + (d.getMonth()+1) + "/" + d.getDate();
        var ttt = timeConverter(timestamp - 3600 * 24 * 700);

        $('#datepicker1').datetimepicker({
            format: 'Y/m/d',
            value: ttt
        });

        $('#datepicker2').datetimepicker({
            format: 'Y/m/d',
            value: new Date()
        });

        $('label[name=dateOption]').click(function () {
            if ($(this).text() == 'MSG') {
                $(this).text('DB');
            } else {
                $(this).text('MSG');
            }
        });
    });

    var authorList = [];
    var aList = "";
    var getNewAuthorGraphData = (function () {
        authorList = [];
        aList = "";
        var searchWord = searchInfo();
        if (searchWord == "") return;

        var keyword = "";

        if ($('.search-operator-option').eq(0).text() == "SEL")
            keyword = $('.search-input').eq(0).val();
        else if ($('.search-operator-option').eq(0).text() == "AND")
            keyword = $('.search-input').eq(0).val() + "&" + $('.search-input').eq(1).val();
        else
            keyword = $('.search-input').eq(0).val() + "|" + $('.search-input').eq(1).val();

        aList = "";
        var id = "stat3";
        var sel = 0;

        authorList.push(keyword);
        callAjax(id, sel, aList, keyword, searchWord);
    });

    var addAuthorGraphData = (function () {
        //var author = [];
        var searchWord = searchInfo();
        if (searchWord == "") return;

        var keyword = "";

        if ($('.search-operator-option').eq(0).text() == "SEL")
            keyword = $('.search-input').eq(0).val();
        else if ($('.search-operator-option').eq(0).text() == "AND")
            keyword = $('.search-input').eq(0).val() + "&" + $('.search-input').eq(1).val();
        else
            keyword = $('.search-input').eq(0).val() + "|" + $('.search-input').eq(1).val();

        var beGood = false;
//        console.log(keyword + " : " + authorList[i] + " : " + beGood);
        for (var i = 0; i < authorList.length; i++) {
            if (keyword == authorList[i]) beGood = true;
            console.log(keyword + " : " + authorList[i] + " : " + beGood);
        }
        if (beGood) {
            alert("중복 검색입니다!!!");
            return;
        }
        if (authorList.length >= 10) {
            alert("그래프는 10개까지 추가 할 수 있습니다.");
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
                if (tdata.contents != "OK") {
                    setTime = setTimeout(function () {
                        callAjax(tdata.id, tdata.sel, aList, tdata.keyword, searchWord);
                    }, 100);
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
                    }
                }
            }
        })
    }

    var getSearchTotalData = (function (category) {
        totalGraph.removeNameList();
        totalGraph.removeData();
        totalGraph.removeSvg();

		var startTime = "2015/01/01 00:00:00";

        if (category == '일별') category = 'MSG_' + 'daily';
        else                  category = 'MSG_' + 'monthly';
        console.log(category);

        $.ajax({
            url: "/main/statistics/search-total-data",
            type: "post",
            data: {
                "id": "stat1",
                "searchPeriod": startTime + '-' + category
            },
            success: function (responseData) {
                var resultData = JSON.parse(responseData);
//                console.error(resultData);
                totalGraph = GraphModule.graph({graphOverall: false});
                totalGraph.setGraphContainer('#total-book-graph-container');
//                totalGraph.addData(responseData);

                totalGraph.addNameList('total');
                totalGraph.setData(resultData);
                totalGraph.init();
            }
        });
    });


    var getAuthorTotalGraphData = (function (category) {
        authorTotalGraph.removeNameList();
        authorTotalGraph.removeData();
        authorTotalGraph.removeSvg();

        var startTime = "2016/03/01 00:00:00";
        if (category == '일별') category = 'DB_' + 'daily';
        else                  category = 'DB_' + 'monthly';

        console.log(category);
        $.ajax({
            url: "/main/statistics/search-total-data",
            type: "post",
            data: {
                "id": "stat2",
                "searchPeriod": startTime + '-' + category
            },
            success: function (responseData) {

                var resultData = JSON.parse(responseData);
//                console.error(resultData);
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
            alert("입력 ERROR : " + word1);
            return "";
        }

        tmp = word.split("\|&");
        if (tmp.length > 1) {
            alert("입력 ERROR : " + word1);
            return "";
        }

        word = word.replace(/(\s*)&+(\s*)/g, "<AND>");
        word = word.replace(/(\s*)\|+(\s*)/g, "<OR>");
        word = word.replace(/(\s+)/g, "<OR>");
        word = word.replace(/<OR>/g, " | ");
        word = word.replace(/<AND>/g, " & ");
        //console.log(word);
        if (word == "") {
            alert("입력 ERROR : " + word1);
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

        var category = categoryEls.eq(2).text();
        if (category == "내용") SearchWord += "indexA^" + input;
        else if (category == "저자") SearchWord += "indexB^" + input;
        else if (category == "참조") SearchWord += "indexC^" + input;


        var operator = operatorEls.eq(0).text();
        if (operator != "SEL") {
            if (operator == "O R") SearchWord += " <OR> ";
            else if (operator == "AND") SearchWord += " <AND> ";

            input = wordCheck(inputEls.eq(1).val());
            if (input == "") isOK = false;

            var category = categoryEls.eq(3).text();
            if (category == "내용") SearchWord += "indexA^" + input;
            else if (category == "저자") SearchWord += "indexB^" + input;
            else if (category == "참조") SearchWord += "indexC^" + input;
        }

        SearchWord += ">" + typeInfo;
        SearchWord += ">" + $('#datepicker1').val() + " 00:00:00" + "-" + $('#datepicker2').val() + " 00:00:00";
        if (categoryEls.eq(5).text() == "일별")
            SearchWord += ">" + categoryEls.eq(4).text() + "_" + "daily";
        else
            SearchWord += ">" + categoryEls.eq(4).text() + "_" + "monthly";


        if (!isOK) SearchWord = "";
///
        return SearchWord;
    }

</script>
</body>
</html>