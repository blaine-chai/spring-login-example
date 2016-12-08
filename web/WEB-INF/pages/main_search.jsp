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
        /*@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);*/
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
                <div class="glyphicon glyphicon-bell"><span class="badge alarm-badge"
                                                            style="position:absolute;vertical-align: middle;font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;"></span>
                </div>
                <div>알림</div>
            </div>
        </a>
        <a href="#">
            <div class="header-button btn active">
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
        <a href="/main/statistics">
            <div class="header-button btn">
                <div class="glyphicon glyphicon-signal"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>통계</div>
            </div>
        </a>
    </div>
</div>

<div id="content" style="">
    <div id="content-wrapper">
        <div id="search" class="col-xs-4">
            <div id="search-wrapper">
                <div id="search-option-radio-wrapper" class="btn-group btn-group-justified" data-toggle="buttons">
                    <label class="btn btn-default btn-sm active"><input type="radio" name="options" id="option1"
                                                                        autocomplete="off" checked>문자포함</label>
                    <label class="btn btn-default btn-sm"><input type="radio" name="options" id="option2"
                                                                 autocomplete="off">형태소</label>
                    <label class="btn btn-default btn-sm"><input type="radio" name="options" id="option3"
                                                                 autocomplete="off">완전일치</label>
                </div>
                <div id="search-input-wrapper" class="">
                    <div class="input-group input-group-sm search-input-group">
                        <div class="dropdown input-group-btn">
                            <div class="btn-group" style="">
                                <button type="button" class="btn btn-default btn-sm dropdown-toggle"
                                        data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false" style="width: 72px">
                                    <span class="search-category-option">내용</span>
                                    <div style="display: inline-block"><span class="caret"></span><span
                                            class="sr-only"></span>
                                    </div>
                                </button>
                                <ul class="dropdown-menu search-category-selector" role="menu"
                                    aria-labelledby="dropdownMenu1">
                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">내용</a></li>
                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">저자</a></li>
                                    <%--<li role="presentation"><a role="menuitem" tabindex="-1" href="#">참조</a></li>--%>
                                </ul>
                            </div>
                        </div>
                        <input type="text" class="form-control col-xs-4 search-input" onkeypress="onkeypressClick(event)" placeholder="검색어를 입력해주세요.">
                        <div class="dropdown input-group-btn">
                            <div class="btn-group">
                                <button type="button" class="btn btn-default btn-sm dropdown-toggle"
                                        data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false" style="width: 55px"><span class="search-operator-option">SEL</span>
                                    <div style="display: inline-block"><span class="caret"></span><span
                                            class="sr-only"></span></div>
                                </button>
                                <ul class="dropdown-menu operator-selector" role="menu"
                                    aria-labelledby="dropdownMenu1">
                                    <li role="presentation"><a role="menuitem" tabindex="1" href="#">SEL</a>
                                    </li>
                                    <li role="presentation"><a role="menuitem" tabindex="2" href="#"
                                                               onclick="handleOperatorSelect(this);return false;">AND</a>
                                    </li>
                                    <li role="presentation">
                                        <a role="menuitem" tabindex="3" href="#"
                                           onclick="handleOperatorSelect(this);return false;">O R</a>
                                    </li>
                                </ul>
                            </div>
                            <label class="btn btn-default btn-sm close-search-option-btn" disabled>-</label>
                        </div>
                    </div>
                </div>
                <div style="margin-top: 10px;height: 30px;">
                    <div id="search-date-option-container" class="btn-group btn-group-justified">
                        <label class="btn btn-default btn-sm" name="dateOption" style="padding: 4px;">ALL</label>
                    </div>
                    <div style="float: left;margin-top: 3px;display: flex;width: calc(100% - 55px);">
                        <div class="" style="padding: 0; margin:0 auto; float: left;"><input id="datepicker1"
                                                                                             data-provide="datepicker"
                                                                                             style="width: 113px; text-align:center; font-size:12px; float:left;">
                        </div>
                        <div style="float:left; width: 20px; font-size:11px;text-align: center; padding:0;vertical-align: middle;line-height: 23px;">
                            ~
                        </div>
                        <div style="padding:0;margin:0 auto;float: left;"><input id="datepicker2"
                                                                                 data-provide="datepicker"
                                                                                 style="width: 113px; text-align:center; font-size:12px; float:left;">
                        </div>
                    </div>
                </div>
                <div class="panel panel-default checkbox"
                     style="padding-top: 5px;padding-bottom:5px;margin-top:10px;margin-bottom: 0;">
                    <c:forEach items="${userGroups}" var="userGroup">
                        <label style="margin-left: 2px;width:85px;font-size: 12px;max-width:85px;">
                            <input type="radio" name="groups" value="${userGroup.groupName.groupName}"
                                   checked="checked" style="width: 20px;">${userGroup.groupName.groupName}</label>
                    </c:forEach>
                </div>

                <div class="btn-group btn-group-justified" style="padding-top: 10px">
                    <label class="btn btn-default btn-sm btn-primary search-btn">검색</label>
                </div>

                <%--<div class="btn-group" style="padding-top: 20px; width: 100%; margin:0;">--%>
                <%--<label class="btn btn-default btn-sm expand-btn btn-primary"--%>
                <%--style="width: 29px; margin:0;">+</label>--%>
                <%--<label class="btn btn-default btn-sm" style="width:calc(100% - 29px); margin:0;">연관 문자</label>--%>
                <%--<div id="relative-word" class="panel history"--%>
                <%--style="display:block;overflow: scroll; max-height:300px; margin-left: 2px; margin-right: 2px; display: none;">--%>
                <%--<table style="font-size:11px;max-height: 300px; overflow: scroll"--%>
                <%--class="table table-fixed table-bordered table-striped table-condensed">--%>
                <%--<tbody></tbody>--%>
                <%--</table>--%>
                <%--</div>--%>
                <%--</div>--%>

                <c:if test="${userType.equals(\"admin\")}">
                    <div class="btn-group" style="padding-top: 5px; width: 100%; margin:0;">
                        <label class="btn btn-default btn-sm expand-btn btn-primary"
                               style="width: 29px; margin:0;">+</label>
                        <label class="btn btn-default btn-sm" style="width:calc(100% - 29px); margin:0;"
                               onclick="$(this).parent().find('.expand-btn').click();return false;">Admin
                            History</label>
                        <div id="admin-history" class="panel history"
                             style="overflow: auto; max-height:300px; margin-left: 2px; margin-right: 2px; display: none;">
                            <table style="font-size:11px;max-height: 300px; overflow: auto;word-break: break-all;"
                                   class="table table-fixed table-bordered table-striped table-condensed">
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </c:if>


                <div class="btn-group" style="padding-top: 5px; width: 100%;margin:0;">
                    <label class="btn btn-default btn-sm expand-btn btn-primary"
                           style="width: 29px; margin:0;">+</label>
                    <label class="btn btn-default btn-sm" style="width:calc(100% - 29px); margin:0;"
                           onclick="$(this).parent().find('.expand-btn').click();return false;">User History</label>
                    <div id="user-history" class="panel history"
                         style="overflow: auto; max-height:300px; margin-left: 2px; margin-right: 2px; display: none;">
                        <table style="font-size:11px;max-height: 300px; overflow: auto;word-break: break-all;"
                               class="table table-fixed table-striped table-condensed">
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>


        <div id="menu" class="col-xs-8" style="width: calc(100% - 333px)">
            <div id="relative-table-container" style="position: absolute; z-index: 10;"></div>
            <div id="menu-wrapper" style="background: rgba(224, 234, 244, 1);">
                <div class="alert alert-info">
                    <div id="search-result-number">검색결과 :
                    </div>
                    <div id="search-progress" class="progress">
                        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0"
                             aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
                            0%
                        </div>
                    </div>
                    <div id="search-result-export-container" style="position: absolute;right: 30px;top: 12px;"><button class="btn btn-default btn-sm">내보내기</button></div>
                </div>
                <div id="result-table-wrapper" class="panel panel-default"
                     style="margin: 15px; overflow: auto; height: calc(100% - 200px); font-size: 11px">
                    <div style="background: #ffffff;">
                        <table id="book-table-header"
                               class="table table-fixed table-bordered table-striped JColResizer JCLRFlex table-condensed"
                               style="position: absolute; top: 0; background: #ffffff; z-index: 4;">
                            <thead id="header" style="">
                            <tr>
                                <th>번호</th>
                                <th>우선순위</th>
                                <th>그룹</th>
                                <th>발행일자</th>
                                <th>저장일자</th>
                                <th>저자</th>
                                <th>참조저자</th>
                                <th>R</th>
                                <th>E</th>
                                <th>내용</th>
                                <th>비고1</th>
                                <th>비고2</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                    <div>
                        <table id="book-table"
                               class="table table-hover table-fixed table-bordered table-striped table-condensed"
                               style="height: 100%;">
                            <thead>
                            <tr style="">
                                <th>번호</th>
                                <th>우선순위</th>
                                <th>그룹</th>
                                <th>발행일자</th>
                                <th>저장일자</th>
                                <th>저자</th>
                                <th>참조저자</th>
                                <th>R</th>
                                <th>E</th>
                                <th>내용</th>
                                <th>비고1</th>
                                <th>비고2</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div style="display:flex">
                    <div id="page-counter-wrapper" style="display:inline-block;margin: 0 auto;">
                        <nav aria-label="..." style="text-align: center;float:left;">
                            <ul class="pagination pagination-sm pagination-main" style="margin: 0 auto;">
                            </ul>
                        </nav>
                        <%--<div>하이라이팅<input id="highlight-checkbox" type="checkbox"></div>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--<script type="text/javascript" charset="UTF-8" src="/js/alarm-update.js"></script>--%>
<script type="text/javascript" charset="UTF-8" src="/js/auto-logout.js"></script>
<script type="text/javascript" charset="UTF-8">
    //var userHistory;
    var userHistory = [];
    var adminHistory = [];
    var tableData = "";
    var authInfoJson = "";
    var lastQuery;
    var relStartPos = new Object();
    var lastPageMain = 0;
    var currentPageMain = 0;
    relStartPos.left = 100;
    relStartPos.top = 200;
    relStartPos.iLeft = 100;
    relStartPos.iTop = 200;
    relStartPos.maxLeft = 300;
    relStartPos.maxTop = 300;
    relStartPos.count = 0;
    var loadingRing = $('<img class="loading-ring" src="/imgs/ajax-loader.gif" style="">');

    function handleOperatorSelect(element) {
        var list = $(element).parent().parent().parent().parent().parent();
        if ($('#search-input-wrapper>div').length - 1 == $('#search-input-wrapper>div').index(list) && $(element).text() != "SEL") {
            $('#search-input-wrapper').append('<div class="input-group input-group-sm search-input-group"><div class="dropdown input-group-btn"><div class="btn-group"><button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 72px"><span class="search-category-option">내용</span>\n<div style="display: inline-block"><span class="caret"></span><span class="sr-only"></span></div></button><ul class="dropdown-menu search-category-selector" role="menu" aria-labelledby="dropdownMenu1"><li role="presentation"><a role="menuitem" tabindex="-1" href="#">내용</a></li><li role="presentation"><a role="menuitem" tabindex="-1" href="#">저자</a></li></ul></div></div><input type="text" class="form-control col-xs-4 search-input" onkeypress="onkeypressClick(event)" placeholder="검색어를 입력해주세요."><div class="dropdown input-group-btn"><div class="btn-group"><button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 55px"><span class="search-operator-option">SEL</span>\n<div style="display: inline-block"><span class="caret"></span><span class="sr-only"></span></div></button><ul id="operator-selector" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1"><li role="presentation"><a role="menuitem" tabindex="1" href="#">SEL</a></li><li role="presentation"><a role="menuitem" tabindex="2" href="#" onclick="handleOperatorSelect(this);return false;">AND</a></li><li role="presentation"><a role="menuitem" tabindex="3" href="#" onclick="handleOperatorSelect(this);return false;">O R</a></li></ul></div><label class="btn btn-default btn-sm close-search-option-btn">-</label></div></div>');
            $('.close-search-option-btn').click(function (e) {
                $(this).parent().parent().remove();
                $('#search-input-wrapper>div').eq($('#search-input-wrapper>div').length - 1).find('.search-operator-option').text('SEL');
                if ($('#search-input-wrapper>div').length == 1) {
                    $('.close-search-option-btn').attr('disabled', '');
                }
            });

            $('.search-category-selector li a').click(function (e) {
                $($(this).parent().parent().parent()).find('button span').eq(0).text($(this).text());
            });
        }
        $($(element).parent().parent().parent()).find('button span').eq(0).text($(element).text());
    }

    $(document).ready(function () {

        $(document).ajaxComplete(function (e, xhr, settings) {
            if (xhr.status === 403) {
                window.location.replace('/')
            }
        });

        $(window).resize(
                function () {
                    //            $('#content').height($(window).height());
                    $('#search-wrapper').height(
                            $(window).height() - 197);
                    //            console($(document).width() + 'px');
                    $('#menu-wrapper').height(
                            $(window).height() - 197);
                    //            $('#book-table').attr('data-height', $(window).height() - 194 - 200)
                    //            $('#book-table').height($(window).height() - 194 - 200)
                    $('#result-table-wrapper').height(
                            $(window).height() - 197 - 130);

                });
        $('#search-wrapper').height($(window).height() - 197);
        $('#menu-wrapper').height($(window).height() - 197);
        //        $('#book-table').height($(window).height() - 194 - 200)
        $('#result-table-wrapper').height(
                $(window).height() - 197 - 130);
        //        $('#book-table').width($('#result-table-wrapper').width());

        $('#book-table').colResizable({
            resizeMode: 'flex',
            initC: ${colSize}
        });

        $('#result-table-wrapper').scroll(function () {
            $('#book-table-header').css("top",
                    252 - $('#book-table').offset().top);
        });

        $('.expand-btn').click(function (e) {
            if ($(this).text() == "+" && $(this).parent().find('div>table>tbody>tr').length > 0) {
//                $('.history').hide(300);
                $(this).parent().find('div').show(300);
//                $('.expand-btn').text('+');
                $(this).text("-");
            } else {
                $(this).text("+");
                $(this).parent().find('div').hide(300, function () {
//                    $(this).parent().find('div').remove();
                });
            }
        });

        getSearchHistory();
        getAdminHistory();
        //$("input:radio[name='groups']").removeAttr('checked');
        $('input:radio[name="groups"]').eq(0).prop("checked", true);
        $('input:radio[name="groups"]:radio[value="전부"]').prop("checked", true);
        <%--/*--%>
        <%--<c:forEach items="${userGroups}" var="userGroup">--%>
        <%--<label style="margin-left: 1px;font-size: 12px;">--%>
        <%--<input type="radio" name="groups" value="${userGroup.groupName.groupName}"--%>
        <%--checked="checked" style=""> ${userGroup.groupName.groupName}</label>--%>
        <%--</c:forEach>--%>
        <%--*/--%>


        $('.search-category-selector li a').click(function (e) {
            $($(this).parent().parent().parent()).find('button span').eq(0).text($(this).text());
        });


        $('.search-btn').click(function () {
            searchBTNclick();
        });

        $('#datepicker1').val("").attr("disabled", true);
        $('#datepicker2').val("").attr("disabled", true);

        $('label[name=dateOption]').click(function () {
            if ($(this).text() == 'ALL') {
                $(this).text('MSG');
                var timestamp = fetch_unix_timestamp();
                var ttt = timeConverter(timestamp - 3600 * 24 * 50);

                $('#datepicker1').datetimepicker({value: ttt}).removeAttr('disabled');
                $('#datepicker2').datetimepicker({value: new Date()}).removeAttr('disabled');
            }
            else if ($(this).text() == 'MSG') {
                var timestamp = fetch_unix_timestamp();
                var ttt = timeConverter(timestamp - 3600 * 24 * 50);

                $('#datepicker1').datetimepicker({value: ttt}).removeAttr('disabled');
                $('#datepicker2').datetimepicker({value: new Date()}).removeAttr('disabled');
                $(this).text('DB');
            }
            else {
                $(this).text('ALL');
                $('#datepicker1').val("");
                $('#datepicker2').val("");
                $('#datepicker1').datetimepicker("destroy").attr("disabled", true);
                $('#datepicker2').datetimepicker("destroy").attr("disabled", true);
            }
        });


    });

    //function initPagination(current, from, to, lastPage)
    function initPagination(current, jump, lastPage) {
        //current += 1;
        //currentPageMain = page;
        var from = current - current % 10 + 1 + jump;

        if (current < 1) {
            from = 1;
        }
        var to = from + 10 - 1;

        if (to > lastPage) {
            to = lastPage;
        }
        console.log("current = " + current + " : from = " + from + " : to = " + to + " : lastPage = " + lastPage);
        $('.pagination-main').children().remove();
        $('.pageInput-container').remove();
        var pageEl = "";
        if (from == 1)
            pageEl += '<li><a href="#" aria-label="Previous" class="disabled"><span aria-hidden="true">«</span></a></li>';
        else
            pageEl += '<li><a href="#" aria-label="Previous"><span aria-hidden="true">«</span></a></li>';

        for (i = from; i <= to; i++) {
            if (i != (current + 1)) pageEl += '<li><a href="#">' + i + '</a></li>';
            else pageEl += '<li><a href="#" class="active">' + i + '</a></li>';
        }

        if (to < lastPage)
            pageEl += '<li><a href="#" aria-label="Next"><span aria-hidden="true">»</span></a></li>';
        else
            pageEl += '<li><a href="#" aria-label="Next" class="disabled"><span aria-hidden="true">»</span></a></li>';

        var tmpDiv = '<div class="pageInput-container" style="color:#4682B4;float:left;padding-left:15px;margin: 0 auto;">  To : <input class="pageInput" onkeypress="onkeypressPage(event);" style=" border:1px solid #90a0a0; width:65px; text-align: center;margin-top:2px;">' +
                ' <label> / ' + lastPageMain + ' pages</label></div>';
        $('.pagination-main').append(pageEl);
        $('#page-counter-wrapper').append(tmpDiv);

        //$(this).addClass("active");
    }

    function onkeypressClick(event) {
        //$('#search-input-wrapper .search-input').keypress(onkeypressClick());
        //console.log();
        if (event.keyCode == 13) {
            searchBTNclick();
            return false;
        }
    }

    function onkeypressPage(event) {
        if (event.keyCode == 13) {
            //console.log($('.pageInput').val());

            if ($('.pageInput').val() == "")
                alert("숫자를 다시 입력해주세요.");
            else {
                var jumpPage = $('.pageInput').val();
                if ((jumpPage > 0) && (jumpPage <= lastPageMain))
                    callAjaxLoop(userID, 2, 0, 2, jumpPage - 1, "", "");
                else
                    alert("숫자를 다시 입력해주세요.");
            }

            return false;
        }
    }

    function searchBTNclick() {
        var data = jsonSearchInfo();
        console.error(data);
        //var SearchWord =
        if (SearchWord != "") {
            //$('#book-table').empty();
            $("#search-result-number").html("검색결과 : 0");		// 검색 건수
            $("#search-progress").empty();
            $("#search-progress").append("<div class='progress-bar progress-bar-striped active' role='progressbar' aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style='width: 0%;'>0%</div>");			// 검색 률

            addHistory(data);
            removeAllRelDiv();
            startTime = new Date();
            jobRun = true;
            repeatCnt = 0;
            stop = false;
            callAjaxLoop(userID, 0, 1, 0, 0, SearchWord, data);
        }
    }

    function addHistory(data) {
        $.ajax({
            url: '/main/history/add',
            type: 'post',
            data: {
                "data": data
            },
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
                getSearchHistory();
                getAdminHistory();
            }
        });
    }

    var authorNUM = 0;
    var priNUM = 0;
    function addCheckBtnListener() {
        $('.pagination-main .active').css("background-color", "#4682B4");//#4169E1
        $('.pagination-main .active').css("color", "white");//#4169E1

        $('#page-counter-wrapper li').click(function (e) {
            if (jobRun) return;
            startTime = new Date();

            var col = $(this).parent().children().index($(this));
            console.log("length = " + $(this).parent().children().length + " ::: col = " + col);
            //console.log($('#page-counter-wrapper ul').find('li').eq(col).text());
            //if (col == (($(this).parent().children().length) - 1)) return;

            var textPage = $('#page-counter-wrapper ul').find('li').eq(col).text();
            //var row = $(this).parent().parent().children().index($(this).parent());

            //$('#book-table tbody').empty();
            //removeAllRelDiv();
            removeAllRelDiv();
            repeatCnt = 0;
            stop = false;
            if ((col > 0) && (col < ($(this).parent().children().length) - 1))
                callAjaxLoop(userID, 2, 0, 2, textPage - 1, "", "");
            else {

                var pageCNT = parseInt($('#page-counter-wrapper ul').find('li').eq(1).text());
                if (col == 0) {
                    pageCNT = pageCNT - 10;

                    if (pageCNT < 1) pageCNT = 1;

                    //initPagination(pageCNT-1, 0, 32);
                    callAjaxLoop(userID, 2, 0, 2, pageCNT - 1, "", "");
                    //initPagination(1, 1, 5, 50);
                } else {
                    pageCNT = pageCNT + 10;
                    if (pageCNT > lastPageMain) pageCNT = lastPageMain;

                    //initPagination(pageCNT-1, 0, 32);
                    callAjaxLoop(userID, 2, 0, 2, pageCNT - 1, "", "");
                }
                console.log(col + " : " + pageCNT + " : " + textPage);
                //addCheckBtnListener();
            }
            //alert($(this).text());
        });

        $('#book-table tbody td').click(function () {
            if (jobRun) return;

            var col = $(this).parent().children().index($(this));
            var row = $(this).parent().parent().children().index($(this).parent());
            //console.log($(this).parent().html());
            //console.log('Row: ' + row + ', Column: ' + col);
            if (col == 7) {
                repeatCnt = 0;
                stop = false;
                console.log($('#book-table tbody').find('tr').eq(row).find('td').eq(col).find('span').hasClass("glyphicon-ok"));
//                $('#book-table tbody').find('tr').eq(row).find('td').eq(col).append(loadingRing);

                var msg = "indexB^" + tableData[row].author
                        + " & " + tableData[row].referencedAuthor + ">완전일치>"
                        + lastQuery.fromDate + "-" + lastQuery.toDate + ">" + lastQuery.dateOption;

                msg += ">" + $('input[name="groups"]:checked').val();
                console.log(msg);

                //if ($('#book-table tbody').find('tr').eq(row).find('td').eq(col).find('span').hasClass( "glyphicon-ok"))
                callAjaxLoop("author" + authorNUM, row, 1, 1, col, msg, "");
                //else
                //	callAjaxLoop("author"+authorNUM, 8, row, 1, 0, m, tableData[row].eventNo);

                authorNUM = authorNUM + 1;
                console.log("authorNUM = " + authorNUM);
            }
            else if (col == 1) {
                var priChange = tableData[row].eventNo + ">" + tableData[row].priority + ">" + $('#book-table tbody').find('tr').eq(row).find('select').val();

                //console.log($('#book-table tbody').find('tr').eq(row).find('select').val())
                repeatCnt = 0;
                stop = false;
                //alert(priChange);
                if (tableData[row].priority != $('#book-table tbody').find('tr').eq(row).find('select').val())
                    callAjaxLoop("pri" + priNUM, 6, row, 6, 0, priChange, "");
                tableData[row].priority = $('#book-table tbody').find('tr').eq(row).find('select').val();
                priNUM = priNUM + 1;
            }
            //else if(col == 9) {
            //	addContentTdClickListener($('#book-table tbody').find('tr').eq(row).find('td').eq(9),
            //			$('#book-table tbody').find('tr').eq(row).find('td').eq(9).text());
            //}
            //$('#book-table tbody').find('tr').eq(row).find('td').eq(0).text('dsafafd');
        });

        $('.content-td').popover({
            html: true,
            content: function () {
                return $(this).text();
            },
            template: '<div class="popover popover-content-td"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><button type="button" class="close" data-dismiss="popover" aria-label="Close"><span aria-hidden="true">×</span></button><div class="popover-content"><p></p></div></div></div>',
            container: '#book-table',
            placement: 'auto'
        }).on('show.bs.popover', function () {
            //remove popover when other popover appeared
            $('.popover-content-td').popover('hide');
        }).on('shown.bs.popover', function () {
            $('.popover-content-td .close').click(function () {
                $('.popover-content-td').popover('hide');
            });
        });

    }

    //function addContentTdClickListener(i, contents) {
    //}

    var startTime = "";

    var userID = "USER1";
    var repeatCnt = 0;
    var stop = false;
    var jobRun = true;
    var setTime = 0;

    function callAjaxLoop(id, job, jobOrder, sel, page, msg, data) {
        if (sel == 2) $('#book-table tbody').empty();

        //console.log(jobRun + " : id=" + userID + " : job=" + job + " jobOrder=" + jobOrder + " : sel=" + sel + " page=" + page + " repeatCnt=" + repeatCnt);
        if (sel == 0) {
            console.log("id=" + userID + "  : job=" + job + " jobOrder=" + jobOrder + " repeatCnt=" + repeatCnt);
            if (setTime != 0) clearTimeout(setTime);
        }
        else  stop = true;

        callAjax(id, job, jobOrder, sel, page, msg, data);
        repeatCnt++;
    }

    function callAjax(id, job, jobOrder, sel, page, msg, data) {
        $.ajax({
            url: '/main/searching',
            type: 'post',
            data: {
                "id": id,
                "job": job,
                "jobOrder": jobOrder,
                "sel": sel,
                "page": page,
                "msg": msg,
                "data": data
            },
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: whenSuccess
        });
    }

    var isMore = false;

    function whenSuccess(responseData) {
        var data = JSON.parse(responseData);

        $.each(data, function (i, tdata) {
            console.log("!!!!! : " + jobRun + " : id=" + tdata.id + " : job=" + tdata.job + " jobOrder="
                    + tdata.jobOrder + " : sel=" + tdata.sel + " : page=" + tdata.page + " content=" + tdata.contents + " repeatCnt=" + repeatCnt);
            if (tdata.contents == "NotOK") {
                if (repeatCnt <= 10000) {
                    if (stop) {
                        console.log("NotOK : " + jobRun + " : id=" + tdata.id + " : job=" + tdata.job + " jobOrder="
                                + tdata.jobOrder + " : sel=" + tdata.sel + " page=" + tdata.page + " repeatCnt=" + repeatCnt);
                        setTime = setTimeout(function () {
                            callAjaxLoop(tdata.id, tdata.job, tdata.jobOrder, tdata.sel, tdata.page, "", "");
                        }, 100);
                    }
                }
                else {
                    alert("Network Error!!!");
                    repeatCnt = 0;
                }
            }
            else if (tdata.contents == "NoData") {
                alert("데이터베이스에 저장된 자료가 없습니다!!!");
            }
            else {
                if (tdata.sel == "0") {
                    setTime = setTimeout(function () {
                        callAjaxLoop(tdata.id, tdata.job, 1, 4, 0, 0, "");
                    }, 100);
                }
                else if (tdata.sel == "1") {
                    setTime = setTimeout(function () {
                        callAjaxLoop(tdata.id, tdata.job, 1, 14, 0, tdata.page, "");
                    }, 100);
                }
                else if (tdata.sel == "2") {
                    setQuery(tdata.bookInfoList, tdata.page);
                    jobRun = false;
                    if (tdata.jobOrder == "1")
                        setTime = setTimeout(function () {
                            callAjaxLoop(tdata.id, tdata.job, 2, 4, 0, "", "");
                        }, 1000);
                }
                else if (tdata.sel == "3") {
                    $('#relative-word>table>tbody').append(tdata.contents);
                }
                else if (tdata.sel == "4") {
                    console.log(tdata.contents);
                    var sel2 = tdata.contents.split("!@#$");
                    $("#search-result-number").html("검색결과 : " + sel2[0]);		// 검색 건수

                    lastPageMain = ((sel2[0] - 1) - (sel2[0] - 1) % 50) / 50 + 1;
                    $('.pagination-main label').text(' / ' + lastPageMain + ' pages');		// 검색 건수

                    $("#search-progress").empty();
                    $("#search-progress").append("<div class='progress-bar progress-bar-striped active' role='progressbar' aria-valuenow='"
                            + sel2[1] + "' aria-valuemin='0' aria-valuemax='100' style='width: " + sel2[1] + "%;'>" + sel2[1] + "%</div>");			// 검색 률

					if (sel2[1] == 100){
						$('.progress-bar').removeClass('progress-bar-striped');
					}

                    console.log(sel2[0] + " : " + sel2[1]);
					if((sel2[1] == 100)&&(sel2[0]==0)) alert("검색결과가 없습니다!!!");

                    if (tdata.jobOrder == "1") {
                        if (sel2[1] < 100)
                            setTime = setTimeout(function () {
                                callAjaxLoop(tdata.id, tdata.job, 1, 2, 0, "", "");
                            }, 100);
                        else
                            setTime = setTimeout(function () {
                                callAjaxLoop(tdata.id, tdata.job, 0, 2, 0, "", "");
                            }, 100);
                    }
                    else if ((tdata.jobOrder == "2") && (sel2[1] < 100)) {
                        setTime = setTimeout(function () {
                            callAjaxLoop(tdata.id, tdata.job, 2, 4, 0, "", "");
                        }, 1000);
                    }
                }
                else if (tdata.sel == "6") {
                    ;
                }
                else if (tdata.sel == "12") {
                    if (tdata.jobOrder == "3") {
                        setCheckR2(tdata.bookInfoList, tdata.job, tdata.contents, tdata.id, tdata.page);
                    } else {
                        setCheckR(tdata.bookInfoList, tdata.job, tdata.contents, tdata.id, tdata.page);
                        var td = $('#book-table tbody').find('tr').eq(tdata.job).find('td').eq(7);
                        td.empty();
                        td.append('<span class="glyphicon glyphicon-ok"></span>');

                        if (tdata.jobOrder == "1") {
                            setTime = setTimeout(function () {
                                callAjaxLoop(tdata.id, tdata.job, 2, 14, tdata.page, tdata.contents, "");
                            }, 1000);
                        }
                        setTime = setTimeout(function () {
                            callAjaxLoop(tdata.id, tdata.job, 2, 13, tdata.page, tableData[tdata.job].eventNo, "");
                        }, 1000);
                    }
                }
                else if (tdata.sel == "14") {
                    var sel2 = tdata.contents.split("!@#$");

                    console.log(sel2[0] + " : " + sel2[1]);
                    if (tdata.jobOrder == "1") {
                        if (sel2[1] < 100)
                            setTime = setTimeout(function () {
                                callAjaxLoop(tdata.id, tdata.job, 1, 12, tdata.page, sel2[0], "");
                            }, 100);
                        else
                            setTime = setTimeout(function () {
                                callAjaxLoop(tdata.id, tdata.job, 0, 12, tdata.page, sel2[0], "");
                            }, 100);
                    }
                    else if ((tdata.jobOrder == "2") && (sel2[1] < 100)) {
                        setTime = setTimeout(function () {
                            callAjaxLoop(tdata.id, 0, 2, 14, tdata.page, sel2[0], "");
                        }, 100);
                    }
                }
                else if (tdata.sel == "8") {
                    var td = $('#book-table tbody').find('tr').eq(tdata.jobOrder).find('td').eq(8);
                    td.empty();
                    td.append('<span class="glyphicon glyphicon-ok"></span>');
                }

                stop = false;
                repeatCnt = 0;
            }
        });
    }

    var nicNameDB = [];
    function nicNameAdd(name, nicName) {
        obj = new Object();
        obj.name = name;
        obj.nicName = nicName;
        nicNameDB.push(obj);
    }

    function nicNameDel(name) {
        for (var i = 0; i < nicNameDB.length; i++) {
            if (nicNameDB[i].name == name) {
                nicNameDB.splice(i, 1);
                break;
            }
        }
    }

    function nicNameChange(name, Nic) {
        console.log(name + " :333: " + nicNameDB.length);
        console.log(name + " :333: " + Nic);
        for (var i = 0; i < nicNameDB.length; i++) {
            console.log(name + " :333: " + Nic);
            if (nicNameDB[i].name == name) {
                nicNameDB[i].nicName = Nic;
                break;
            }
        }
    }

    function nicNameFind(name, Nic) {
        var nicname = "";
        //console.log(name + " :222: " + nicNameDB.length);
        for (var i = 0; i < nicNameDB.length; i++) {

            //console.log(nicNameDB[i].name + " :333: " + nicNameDB[i].nicName);
            if (nicNameDB[i].name == name) {
                nicname = nicNameDB[i].nicName;
                break;
            }
        }
        return nicname;
    }


    function wordCheck(word1) {
        var word = word1.replace(/(^[&|\s]*)|([&|\s]*$)/g, "");
        console.log(word);

        word = word.replace(/(&+)\s*(&+)/g, "&");
        word = word.replace(/(\|+)\s*(\|+)/g, "|");
        word = word.replace(/(\|+)\s*(&+)/g, "|&");
        word = word.replace(/(&+)\s*(\|+)/g, "&|");
        console.log(word);

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
        console.log(word);
        if (word == "") {
            alert("검색어를 다시 입력해주세요.");
            //isOK = false;
            return "";
        }
        return word;
    }

    var SearchWord = "";
    function jsonSearchInfo() {
        var isOK = true;
        var typeInfo = $('#search-option-radio-wrapper>.active').text();
        var categoryEls = $('.search-category-option');
        var inputEls = $('.search-input');
        var operatorEls = $('.search-operator-option');
        var data = new Object();
        var list = [];
        var obj;
        SearchWord = "";
        inputEls.each(function (i) {
            obj = new Object();
            obj.category = categoryEls.eq(i).text();
            obj.input = inputEls.eq(i).val();
            obj.operator = operatorEls.eq(i).text();
///
            console.log(i + " : " + obj.category + " : " + obj.input + " : " + obj.operator);

            var tmp = wordCheck(obj.input);
            if (tmp == "") isOK = false;
            obj.input = tmp;

            if (obj.category == "내용") SearchWord += "indexA^" + tmp;
            else if (obj.category == "저자") SearchWord += "indexB^" + tmp;
            //else if (obj.category == "참조") SearchWord += "indexC^" + tmp;

            if (obj.operator == "O R") SearchWord += " <OR> ";
            else if (obj.operator == "AND") SearchWord += " <AND> ";
            ///
            list.push(obj);
        });
        SearchWord += ">";

        data.data = list;
        data.typeInfo = typeInfo;
        data.fromDate = $('#datepicker1').val();
        data.toDate = $('#datepicker2').val();
        data.dateOption = $('label[name=dateOption]').text();
        if ((data.fromDate != "") && (data.toDate != "")) {
            if (data.fromDate > data.toDate) {
                isOK = false;
                alert("입력 날짜를 다시 입력해주세요.");
            }
        }
        data.groups = $('input[name="groups"]:checked').val();

        lastQuery = data;

///
        SearchWord += typeInfo;
        SearchWord += ">";
        SearchWord += data.fromDate + "-" + data.toDate;
        SearchWord += ">" + data.dateOption;
        console.log(data.typeInfo + " : " + data.fromDate + " : " + data.toDate);
        SearchWord += ">" + $('input[name="groups"]:checked').val();

        if (!isOK) SearchWord = "";
///
        return JSON.stringify(data);
    }

    function setQuery(responseData, page) {
        var data = JSON.parse(responseData);
        tableData = data;
        if (!data) {
            alert("존재하지 않는 ID입니다");
            return false;
        }
        var html = '<tbody>';
        $.each(data, function (i, tdata) {
            var authorNic = nicNameFind(tdata.author);
            var refAuthorNic = nicNameFind(tdata.referencedAuthor);
            //console.log(tdata.author + " : " + tdata.referencedAuthor);
            //console.log(authorNic + " : " + refAuthorNic);

            html += '<tr><td>' + tdata.number + '</td>';
//          var priorityEl = $('')
//          priorityEl.find('select').val(tdata.priority);
            html += '<td>' + '<select><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select>' + '</td>';
            html += '<td class="group-td">' + tdata.groupName + '</td>';
            html += '<td>' + tdata.publishedDate + '</td>';
            html += '<td>' + tdata.savedDate + '</td>';
            /*
             html += '<td class="author-td author' + i + '" title="' + tdata.author + '" href="#">' + tdata.author +
             '<span>' + (authorNic != "" ? '(' + authorNic + ')' : '') + '</span>' + '</td>';
             //html += '<td class="relation-td">' + tdata.referencedAuthor + '</td>';
             html += '<td class="relation-td relation' + i + '" title="' + tdata.referencedAuthor + '" href="#">' + tdata.referencedAuthor
             + '<span>' + (refAuthorNic != "" ? '(' + refAuthorNic + ')' : '') + '</span>' + '</td>';
             */
            html += '<td class="author-td author' + i + '" title="' + tdata.author + '" href="#">' + tdata.author +
                    '<span>' + (tdata.authNickname != undefined ? '(' + tdata.authNickname + ')' : '') + '</span>' + '</td>';
            //html += '<td class="relation-td">' + tdata.referencedAuthor + '</td>';
            html += '<td class="relation-td relation' + i + '" title="' + tdata.referencedAuthor + '" href="#">' + tdata.referencedAuthor
                    + '<span>' + (tdata.refNickname != undefined ? '(' + tdata.refNickname + ')' : '') + '</span>' + '</td>';

            if (tdata.r == 't') {
                tdata.r = '<span class="glyphicon glyphicon-ok"></span>';
            } else {
                tdata.r = '';
            }
            if (tdata.e == 't') {
                tdata.e = '<span class="glyphicon glyphicon-ok"></span>';
            } else {
                tdata.e = '';
            }
            html += '<td class="check-r' + i + '" title="' +
                    tdata.author + ' - 참조저자' +
                    '" href="#">' + tdata.r + '</td>';
            html += '<td class="check-e">' + tdata.e + '</td>';
            html += '<td class="content-td">' + tdata.contents + '</td>';
            html += '<td>' + tdata.note1 + '</td>';
            html += '<td>' + tdata.eventNo + '</tr></td>';
        });
        html += '</tbody>'
        $('#book-table tbody').hide(0, function () {
            $('#book-table tbody').remove();
            html = $(html);
            html.hide();
            $('#book-table').append(html);
            $.each(data, function (i, tdata) {
                $('#book-table select').eq(i).val(tdata.priority);
                $('#book-table select').eq(i).change(function () {
//                    console.error($(this).val());
                    setPriority($(this));
                })
            });

            html.show(0, function () {

                $.each(data, function (i, tdata) {
                    addAuthorClickListener(i, tdata.author);
                    addRefAuthorClickListener(i, tdata.referencedAuthor);
                    //addContentTdClickListener(i, tdata.contents);
                    //addCheckRBtnListener(i);
                });

                initPagination(page, 0, lastPageMain);
                //initPagination(page, 1, 5, 50);
                addCheckBtnListener();

                //addCheckEBtnListener();
                highLightResult();
            });
        });

        $('.matched-content').toggleClass('highlight-background');

        elapsed = new Date() - startTime;
        console.log("Processing Time : elapsed : " + (new Date() - startTime));
    }


    function setPriority(priority) {
        var bookId = priority.parent().parent().find('td').eq(0).text();
        var data = new Object();
        data.bookId = bookId;
        data.priority = priority.val();
        $.ajax({
            url: '/main/priority/update',
            type: 'post',
            data: {'data': JSON.stringify(data)},
//            data: {"data": jsonSearchInfo()},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
            }
        });
    }

    var noticeNo = 0;
    function getSearchHistory(json) {
        var data;
        $.ajax({
            url: "/main/user-history/get",
            type: "post",
//                data: {"data": jsonSearchInfo()},
//            data: {"data": jsonSearchInfo()},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
                data = userHistory = JSON.parse(responseData);
                $('#user-history>table>tbody>tr').remove();
                $.each(data, function (i, d) {
                    var tmpEl = $('<tr><td class="user-history-bookmark-td"><img class="bookmark-btn" style="width: 26px;height: 26px;" src="/imgs/bookmark-empty-star.png"></td><td>' + changeHistory(data[i].word) + '</td><td class="user-history-remove-td"><label class="btn btn-default btn-sm close-search-option-btn">-</label></td></tr>');
                    if (d.isBookmarked) {
                        tmpEl.find('img').addClass('bookmark-btn-active');
                        tmpEl.find('img').attr('src','/imgs/bookmark-empty-star-active.png');
                    }
                    $('#user-history>table>tbody').prepend(tmpEl);
                    tmpEl.find('.close-search-option-btn').click(function (e) {
                        deleteUserHistory(this, d.id);
                        $(this).parent().parent().remove();

                    });
                });
                $('#user-history>table>tbody>tr>td:nth-child(2)').click(function (e) {
                    if (($(this).text() == "") || ($(this).text() == "-")) return;
                    var col = $(this).parent().parent().children().index($(this).parent());
                    //addSearchInfo(JSON.parse($(this).find('td').eq(1).text()));
                    addSearchInfo(JSON.parse(userHistory[userHistory.length - col - 1].word));
                });

                $('#user-history .user-history-bookmark-td').click(function (e) {
                    var col = $(this).parent().parent().children().index($(this).parent());
                    //addSearchInfo(JSON.parse($(this).find('td').eq(1).text()));
                    var word = userHistory[userHistory.length - col - 1].word;
                    var icon = $(this).find('img');
                    if ($(this).find('img').hasClass('bookmark-btn-active')) {
//                    	console.log("AAAAAAAAAAAAAAAAAAAAAAAAAA");
                        $.ajax({
                            url: '/main/user-bookmark/delete',
                            type: 'post',
                            data: {'data': word},
                            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                            success: function (responseData) {
                                icon.toggleClass('bookmark-btn-active');
                                icon.attr('src', '/imgs/bookmark-empty-star.png');
                            }
                        });
                    } else {
                        noticeNo++;
                        $.ajax({
                            url: '/main/user-bookmark/add',
                            type: 'post',
                            data: {
                                'id': 'notice' + noticeNo,
                                'msg': dataParsing(word),
                                'data': word
                            },
                            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                            success: function (responseData) {
                                icon.toggleClass('bookmark-btn-active');
                                icon.attr('src','/imgs/bookmark-empty-star-active.png');
                            }
                        });
                    }
                });
            }
        });
    }

    function changeHistory(source) {
        var tdata = JSON.parse(source);

        var data = tdata.data;
        var str = "";

        for (var i = 0; i < data.length; i++) {
            str += data[i].category + "^";
            str += data[i].input;
            if (i < data.length - 1) str += " " + data[i].operator + " ";
        }
        str += ">" + tdata.typeInfo;
        str += ">" + tdata.fromDate + "-" + tdata.toDate;
        str += ">" + tdata.dateOption;
        str += ">" + tdata.groups;

        return str;
    }

    function getRelativeWord(json) {
        var data;
        $.ajax({
            url: "/relative-word",
            type: "post",
            data: {"data": jsonSearchInfo()},
//            data: {"data": jsonSearchInfo()},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
//                console.error(responseData);
                data = JSON.parse(responseData);
                $('#relative-word>table>tbody>tr').remove();
                $.each(data, function (i) {
                    $('#relative-word>table>tbody').append('<tr><td><input type="checkbox"></td><td>' + data[i] + '</td></tr>');
                });
            }
        });
    }

    function deleteUserHistory(element, id) {
        $.ajax({
            url: "/main/user-history/delete",
            type: "post",
            data: {"id": id},
//            data: {"data": jsonSearchInfo()},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
//                data = userHistory = JSON.parse(responseData);
//                console.error(id);
                getSearchHistory();
            }
        });
    }

    function getAdminHistory(json) {
        var data;
        $.ajax({
            url: "/main/admin-history/get",
            type: "post",
//                data: {"data": jsonSearchInfo()},
//            data: {"data": jsonSearchInfo()},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
                data = adminHistory = JSON.parse(responseData);
                console.error(responseData);
                $('#admin-history>table>tbody>tr').remove();
                $.each(data, function (i, d) {
                    var tmpEl = $('<tr><td class="user-history-bookmark-td"><img class="bookmark-btn" style="width: 26px;height: 26px;" src="/imgs/bookmark-empty-star.png"></td><td>' + changeHistory(data[i].word) + '</td><td class="user-history-remove-td"><label class="btn btn-default btn-sm close-search-option-btn">-</label></td></tr>');
                    if (d.isBookmarked) {
                        tmpEl.find('img').addClass('bookmark-btn-active');
                        tmpEl.find('img').attr('src','/imgs/bookmark-empty-star-active.png');
                    }
                    $('#admin-history>table>tbody').prepend(tmpEl);
                    tmpEl.find('.close-search-option-btn').click(function (e) {
                        deleteAdminHistory(this, d.id);
                        $(this).parent().parent().remove();
                    });
                });
                $('#admin-history>table>tbody>tr>td:nth-child(2)').click(function (e) {
                    if (($(this).text() == "") || ($(this).text() == "-")) return;
                    var col = $(this).parent().parent().children().index($(this).parent());
                    //addSearchInfo(JSON.parse($(this).find('td').eq(1).text()));
                    addSearchInfo(JSON.parse(adminHistory[adminHistory.length - col - 1].word));
//                    addSearchInfo(JSON.parse($(this).text()));
                });

                $('#admin-history .user-history-bookmark-td').click(function (e) {
                    var col = $(this).parent().parent().children().index($(this).parent());
                    //addSearchInfo(JSON.parse($(this).find('td').eq(1).text()));
                    var word = adminHistory[adminHistory.length - col - 1].word;
                    var icon = $(this).find('img');
                    if ($(this).find('img').hasClass('bookmark-btn-active')) {
                        $.ajax({
                            url: '/main/admin-bookmark/delete',
                            type: 'post',
                            data: {'data': word},
                            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                            success: function (responseData) {
//                                console.error(responseData);
                                icon.toggleClass('bookmark-btn-active');
                                icon.attr('src', '/imgs/bookmark-empty-star.png')
                            }
                        });
                    } else {
                        noticeNo++;
                        $.ajax({
                            url: '/main/admin-bookmark/add',
                            type: 'post',
                            data: {
                                'id': 'notice' + noticeNo,
                                'msg': dataParsing(word),
                                'data': word
                            },
                            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                            success: function (responseData) {
//                                console.error(responseData);
                                icon.toggleClass('bookmark-btn-active');
                                icon.attr('src', '/imgs/bookmark-empty-star-active.png')
                            }
                        });
                    }
                });
            }
        });
    }
    function dataParsing(source) {
        var tdata = JSON.parse(source);
        lastQuery = tdata;

        var data = tdata.data;

        var str = "";
		var isOK = true;

        for (var i = 0; i < data.length; i++) {
        	var tmp = data[i].input;
            if (data[i].category == "내용") str += 'indexA^' + tmp;
            else if (data[i].category == "저자") str += "indexB^" + tmp;
            //else if (data[i].category == "참조") str += 'indexC^';

            if (i < data.length - 1) {
                if (data[i].operator == "O R") str += " <OR> ";
                else str += " <AND> ";
            }
        }
        str += ">" + tdata.typeInfo;
        str += ">" + tdata.fromDate + "-" + tdata.toDate;
        str += ">" + tdata.dateOption;
        console.log("dataParsing : " + tdata.groups);
        str += ">" + tdata.groups;

        //if(!isOK) str = "";

        return str;
    }
    function deleteAdminHistory(element, id) {
        $.ajax({
            url: "/main/admin-history/delete",
            type: "post",
            data: {"id": id},
//            data: {"data": jsonSearchInfo()},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
//                data = userHistory = JSON.parse(responseData);
//                console.error(id);
                getAdminHistory();
            }
        });
    }

    //    function getAdminHistory(json) {
    //    }
    //
    //    function deleteAdminHistory(element, id) {
    //    }

    function addSearchInfo(a) {
        $('.search-input-group').remove();
        if (a.typeInfo == '문자포함') {
            $('#option1').parent().click();
        } else if (a.typeInfo == '형태소') {
            $('#option2').parent().click();
        } else {
            $('#option3').parent().click();
        }

        $('label[name=dateOption]').text(a.dateOption);
        if (a.dateOption == 'ALL') {
		    $('#datepicker1').val("");
		    $('#datepicker2').val("");
			$('#datepicker1').datetimepicker("destroy").attr("disabled", true);
		    $('#datepicker2').datetimepicker("destroy").attr("disabled", true);
		}
		else {
		    $('#datepicker1').removeAttr('disabled');
		    $('#datepicker2').removeAttr('disabled');
		}
		//$('input:radio[name="groups"]').eq(0).prop("checked",true);
		$('input:radio[name="groups"]:radio[value="' + a.groups + '"]').prop("checked",true);

        $.each(a.data, function (i) {
            var newDiv = $('<div class="input-group input-group-sm search-input-group"><div class="dropdown input-group-btn"><div class="btn-group"><button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 72px"><span class="search-category-option">내용</span><div style="display: inline-block"><span class="caret"></span><span class="sr-only"></span></div></button><ul class="dropdown-menu search-category-selector" role="menu" aria-labelledby="dropdownMenu1"><li role="presentation"><a role="menuitem" tabindex="-1" href="#">내용</a></li><li role="presentation"><a role="menuitem" tabindex="-1" href="#">저자</a></li></ul></div></div><input type="text" class="form-control col-xs-4 search-input" onkeypress="onkeypressClick(event)" placeholder="검색어를 입력해주세요."><div class="dropdown input-group-btn"><div class="btn-group"><button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 55px"><span class="search-operator-option">SEL</span>\n<div style="display: inline-block"><span class="caret"></span><span class="sr-only"></span></div></button><ul id="operator-selector" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1"><li role="presentation"><a role="menuitem" tabindex="1" href="#">SEL</a></li><li role="presentation"><a role="menuitem" tabindex="2" href="#" onclick="handleOperatorSelect(this);return false;">AND</a></li><li role="presentation"><a role="menuitem" tabindex="3" href="#" onclick="handleOperatorSelect(this);return false;">O R</a></li></ul></div><label class="btn btn-default btn-sm close-search-option-btn">-</label></div></div>');
            if (i == 0) {
                newDiv.find('.close-search-option-btn').attr('disabled', '');
            }
//            console.error(i)
            newDiv.find('.search-category-option').text(a.data[i].category);
//            console.error(a.data[i].operator)
            newDiv.find('.search-input').val(a.data[i].input);
            newDiv.find('.search-operator-option').text(a.data[i].operator);
            $('#datepicker1').val(a.fromDate);
            $('#datepicker2').val(a.toDate);
            $('#search-input-wrapper').append(newDiv);
            $('#search-input-wrapper .close-search-option-btn').click(function (e) {
                $(this).parent().parent().remove();
                $('#search-input-wrapper>div').eq($('#search-input-wrapper>div').length - 1).find('.search-operator-option').text('SEL');
            });

            $('.search-category-selector li a').click(function (e) {
                $($(this).parent().parent().parent()).find('button span').eq(0).text($(this).text());
            });
        });
    }

    function setCheckR(responseData, row, count, id, page) {
        var data = JSON.parse(responseData);
        authInfoJson = data;

        var tmpEl = '<div class="alert bg-white alert-dismissible fade in border-gray relative-table-wrapper" style="position: absolute; z-index: 10; width: 700px; left:' + relStartPos.left + 'px;top:' + relStartPos.top + 'px;" role="alert">' +
                '<button type="button" class="close" onclick="$(this).parent().remove(); return false;" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>' +
                '<div class="relative-title" style="font-size: 13px;">' + tableData[row].author + ' - ' + tableData[row].referencedAuthor + '<span>  : ' + count + ' 건</span></div>' +
                //' <div id="checkR-result-number">검색결과 : 00000000</div>' +
                '<div style="font-size: 11px;position: relative;left: 450px;">' +
                //'<span class="relative-author-from-date">' + lastQuery.fromDate + '</span>' + (lastQuery.fromDate == '' && lastQuery.toDate == '' ? '' : '</span><span> ~ </span><span class="relative-author-to-date">' + lastQuery.toDate + '</span>') +
                '<span class="relative-author-from-date">' + lastQuery.fromDate + '</span>' + (lastQuery.fromDate == '' && lastQuery.toDate == '' ? '' : '</span><span> ~ </span><span class="relative-author-to-date">' + lastQuery.toDate + '(' + lastQuery.dateOption + ')' + '</span>') +
                '</div>' +
                '<div><div style="overflow:auto; height: 300px;">' +
                '<table class="table table-hover table-fixed table-bordered table-striped table-condensed" style="font-size: 11px; margin-bottom: 0;">' +
                '<thead><tr><th width="120px">시간</th><th width="70px">저자</th><th width="70px">참조</th><th>내용</th></tr></thead>' +
                '<tbody></tbody></table></div><div><nav aria-label="..." style="text-align: center; margin-top:10px;">';
        tmpEl += '<ul class="pagination pagination-sm pagination-' + id + '" style="margin: 0 auto;">';
        tmpEl += '<li><a href="#" aria-label="Previous" class="disabled"><span aria-hidden="true">«</span></a></li>';
        for (var j = 0; j * 50 < count; j++) {
            if (j != page) tmpEl += '<li><a href="#">' + (j + 1) + '</a></li>';
            else tmpEl += '<li><a href="#">' + (j + 1) + '</a></li>';
            if (j == 4) break;
        }
        tmpEl += '<li><a href="#" aria-label="Next"><span aria-hidden="true">»</span></a></li></ul></nav></div>' +
                '<label class="btn btn-primary btn-export" style="position: absolute;right: 15px;bottom: 15px;font-size: 11px;">export</label></div>';

        tmpEl = $(tmpEl);
        setRelTablePos();
        console.log(relStartPos.left);
        console.log(data);

        $.each(data, function (i, tdata) {
            tmpEl.find('tbody').append('<tr>' +
                    '<td>' + tdata.publishedDate + '</td>' +
                    '<td class="author-td author' + i + '" title="' + tdata.author + '" href="#">' + tdata.author +
                    '<span>' + (tdata.authNickname != undefined ? '(' + tdata.authNickname + ')' : '') + '</span>' + '</td>' +
                    '<td class="relation-td relation' + i + '" title="' + tdata.referencedAuthor + '" href="#">' + tdata.referencedAuthor
                    + '<span>' + (tdata.refNickname != undefined ? '(' + tdata.refNickname + ')' : '') + '</span>' + '</td>' +
                    '<td style="word-break: break-all">' + tdata.contents + '</td>' +
                    '</tr>');
        });

        $('body').append(tmpEl);
        var tarEl = $(this);
        tmpEl.draggable();

        $('.pagination-' + id + ' .active').css("background-color", "#4682B4").css("color", "white");
        $('.pagination-' + id + ' li').eq(1).addClass('active');

        tmpEl.find('.pagination-' + id + ' li').click(function (e) {

            var col = $(this).parent().children().index($(this));
            console.log($(this).parent().children().length);

            var textPage = $('.pagination-' + id).find('li').eq(col).text();
            var prePage = $('.pagination-' + id + ' .active').text();

            if (textPage == prePage) return;

            if ((col > 0) && (col < ($(this).parent().children().length) - 1)) {
                repeatCnt = 0;
                stop = false;
                $(this).addClass('active').siblings().removeClass('active');
                callAjaxLoop(id, 2, 3, 12, textPage - 1, count, "");
                console.log(col + " :111: " + textPage);
            }
            else {
                textPage = parseInt($('.pagination-' + id).find('li').eq(1).text());

                if (col == 0) {
                    textPage = textPage - 5;
                    if (textPage < 1) textPage = 1;

                    if (textPage == prePage) return;
                    $('.pagination-' + id).find('li').eq(1).addClass('active').siblings().removeClass('active');
                    repeatCnt = 0;
                    stop = false;
                    callAjaxLoop(id, 2, 3, 12, textPage - 1, count, "");
                }
                else {
                    textPage = textPage + 5;
                    var lastp = ((count - 1) - (count - 1) % 50) / 50 + 1;
                    if (textPage > lastp) textPage = lastp;

                    if (textPage == prePage) return;
                    $('.pagination-' + id).find('li').eq($(this).parent().children().length - 2).addClass('active').siblings().removeClass('active');
                    repeatCnt = 0;
                    stop = false;
                    callAjaxLoop(id, 2, 3, 12, textPage - 1, count, "");
                }
                console.log(col + " :222: " + textPage);
            }
        });

        tmpEl.find('.btn-export').click(function (e) {
            //exportCsv(tmpEl.find('table'));
            repeatCnt = 0;
            stop = false;
            console.log($('#book-table tbody').find('tr').eq(row).find('td').eq(8).find('span').hasClass("glyphicon-ok"));
            /*
             if (!$('#book-table tbody').find('tr').eq(row).find('td').eq(8).find('span').hasClass( "glyphicon-ok"))
             callAjaxLoop("author"+authorNUM, 8, row, 8, 8, tableData[row].eventNo+">t", "");
             else
             callAjaxLoop("author"+authorNUM, 8, row, 8, 8, tableData[row].eventNo+">f", "");
             */
            callAjaxLoop("author" + authorNUM, 8, row, 8, 8, tableData[row].eventNo + ">" + "indexB^" + tableData[row].author + " & "
                    + "indexB^" + tableData[row].referencedAuthor + ">완전일치>" + lastQuery.fromDate + "-" + lastQuery.toDate + '>' + lastQuery.dateOption, "");
        });
    }

    function setCheckR2(responseData, row, count, id, page) {
        var data = JSON.parse(responseData);
        authInfoJson = data;

        $('.pagination-' + id).parent().parent().parent().find('tbody').children().remove();
        $.each(data, function (i, tdata) {
            $('.pagination-' + id).parent().parent().parent().find('tbody').append('<tr>' +
                    '<td>' + tdata.publishedDate + '</td>' +
                    '<td class="author-td author' + i + '" title="' + tdata.author + '" href="#">' + tdata.author +
                    '<span>' + (tdata.authNickname != undefined ? '(' + tdata.authNickname + ')' : '') + '</span>' + '</td>' +
                    '<td class="relation-td relation' + i + '" title="' + tdata.referencedAuthor + '" href="#">' + tdata.referencedAuthor
                    + '<span>' + (tdata.refNickname != undefined ? '(' + tdata.refNickname + ')' : '') + '</span>' + '</td>' +
                    '<td style="word-break: break-all">' + tdata.contents + '</td>' +
                    '</tr>');
        });
    }

    function addCheckRBtnListener(i) {
        $('.check-r' + i).click(function () {
            $.ajax({
                url: "/r-check",
                type: "post",
                data: {"bookId": tarEl.parent().find('td').eq(0).text()},
                success: function (responseData) {
//                    var data = JSON.parse(responseData);

//                    console.error(tarEl);
                    tarEl.find('span').remove();
                    tarEl.append('<span class="glyphicon glyphicon-ok"></span>');
//                    console.log(html);
                }
            });
        });
    }

    function exportCsv(table) {
        var rows = table.find('tbody>tr');
        table.tableToCSV();

    }


    function addAuthorClickListener(i, tdata) {
        var content = $('<div class="popover-content-wrapper' + i + '" style="display: none;">' +
                '<div class="input-group input-group-sm" style=" width:100%">' +
                '<span class="input-group-addon" style="width: 70px">저자</span>' +
                '<input type="text" class="form-control popover-input-author" disabled>' +
                '</div>' +
                '<div class="input-group input-group-sm" style="width:100%">' +
                '<span class="input-group-addon" style="width: 70px" >별명</span>' +
                '<input type="text" class="form-control popover-input popover-input-nickname">' +
                '<span class="input-group-btn">' +
                '<label class="btn btn-default btn-sm btn-identity-check popover-input" style="width:70px;">중복 확인</label></span>' +
                '</div>' +
                '<div class="input-group input-group-sm" style="width:100%">' +
                '<span class="input-group-addon" style="width: 70px;" disabled >수정시간</span>' +
                '<input type="text" class="form-control popover-input-modified-time" disabled>' +
                '</div>' +
                '<div class="input-group input-group-sm" style=" width:100%">' +
                '<span class="input-group-addon" style="width: 70px" >우선순위</span>' +
                '<span class="input-group-addon" style="width:calc(100% - 70px);" ><select class="popover-input popover-input-priority"><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select></span>' +
                '</div>' +
                '<div class="input-group input-group-sm" style="width:100%; height: 60px;">' +
                '<span class="input-group-addon" style="width: 70px" >메모</span>' +
                '<textarea class="form-control popover-input popover-input-note" style="height: 60px;resize: none;"></textarea>' +
                '</div>' +
                '<div style="padding-top: 15px; position:relative">' +
                '<label class="btn btn-default btn-sm btn-modify-nickname"  style="width:70px;">편집</label>' +
                '<label class="btn btn-default btn-sm btn-popover-close" style="width:70px;position: absolute;right: 0; ">취소</label>' +
                '</div></div>');

        $('.author' + i).popover({
            html: true,
            content: function () {
                return content.html();
            },
            container: '#book-table',
            template: '<div class="popover popover-author-td"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>',
            placement: 'auto'
        }).on('show.bs.popover', function () {
            //remove popover when other popover appeared
            $('.popover-author-td').popover('hide');
        }).on('shown.bs.popover', function () {
            //handle after popover shown
            var clickedTd = $(this);
            $('.popover-input-author').val(tdata);
            $('.btn-popover-close').click(function (e) {
                $('.popover-author-td').popover('hide');
            });

            $('.popover-input').attr('disabled', '');

            //update nickname
            $('.popover .btn-modify-nickname').click(function (e) {
                if ($(this).text() == '편집') {
                    $('.popover-input').removeAttr('disabled');
                    $(this).toggleClass('btn-primary').text('저장');
                } else {
                    if ($('.btn-identity-check').attr('disabled') != undefined) {
                        var nicname = $('.popover-input-nickname').val();
                        var author = $('.popover-input-author').val();
                        $.ajax({
                            url: "/main/nickname/update",
                            type: "post",
                            data: {
                                "nickname": nicname,
                                "author": author,
//                                "lastModifiedDate": $('.popover-input-modified-time').val(),
                                "priority": $('.popover-input-priority').val(),
                                "note": $('.popover-input-note').val()
                            },
                            success: function (responseData) {
                                if (responseData == 'true') {

                                    for (var k = 0; k < $('#book-table tbody').find('tr').length; k++) {
                                        var nicTmp = $('#book-table tbody').find('tr').eq(k).find('td').eq(5).text();
                                        var html = '';
                                        if (nicTmp == author) {
                                            html = author + '<span>(' + nicname + ')</span>';
                                            $('#book-table tbody').find('tr').eq(k).find('td').eq(5).html(html);
                                        }

                                        nicTmp = $('#book-table tbody').find('tr').eq(k).find('td').eq(6).text();
                                        html = '';
                                        if (nicTmp == $('.popover-input-author').val()) {
                                            html = author + '<span>(' + nicname + ')</span>';
                                            $('#book-table tbody').find('tr').eq(k).find('td').eq(6).html(html);
                                        }

                                        //console.log("BBBBBB : " + $('#book-table tbody').find('tr').eq(k).find('td').eq(5).text());
                                    }
                                    //highLightResult();

                                    $('.popover .btn-identity-check').attr('disabled', '');
                                    $('.popover .btn-modify-nickname').toggleClass('btn-primary').text('편집');
                                    clickedTd.find('span').text('(' + $('.popover-input-nickname').val() + ')');
                                    $('.popover').remove();
                                    $('.popover-input').attr('disabled', '');
                                }
                                else {
                                    //when nickname not checked
                                    alert('send error');
                                }
                            }
                        });
                    } else {
                        alert('중복 확인을 해 주세요.');
                    }
                }
            });

            //when popover opened get nickname info from server
            $.ajax({
                url: "/main/nickname/get",
                type: "post",
                data: {
                    "author": $('.popover-input-author').val()
                },
                success: function (responseData) {
                    var result = JSON.parse(responseData);
//                    console.error(responseData);
                    $('.popover-input-nickname').val(result.nickname);
                    $('.popover-input-modified-time').val(result.lastModifiedDate);
                    $('.popover-input-priority').val(result.priority);
                    $('.popover-input-note').val(result.note);
                }
            });

            $('.popover .btn-identity-check').click(function (e) {
                $.ajax({
                    url: "/main/nickname/check",
                    type: "post",
                    data: {
                        "nickname": $('.popover-input-nickname').val(),
                        "author": $('.popover-input-author').val()
                    },
                    success: function (responseData) {
                        if (responseData == 'true') {
                            $('.popover .btn-identity-check').attr('disabled', '');
                            $('.popover .btn-identity-check').append('<span class="glyphicon glyphicon-ok" style="color:#3ce63d;"></span>');
                            $('.popover .popover-input-nickname').on('input', function () {
                                $('.popover .btn-identity-check span').remove();
                                $('.popover .btn-identity-check').removeAttr('disabled');
                            });
                        } else {
                            alert('이미 같은 별명이 존재합니다.');
                        }
                    }
                });
            });

            $('#book-table').on('hidden.bs.popover', function (e) {
                $(e.target).data("bs.popover").inState = {click: false, hover: false, focus: false}
            });
        });
    }

    function addRefAuthorClickListener(i, tdata) {

        var content = $('<div class="popover-content-wrapper' + i + '" style="display: none;">' +
                '<div class="input-group input-group-sm" style=" width:100%">' +
                '<span class="input-group-addon" style="width: 70px">저자</span>' +
                '<input type="text" class="form-control popover-input-author" disabled>' +
                '</div>' +
                '<div class="input-group input-group-sm" style="width:100%">' +
                '<span class="input-group-addon" style="width: 70px" >별명</span>' +
                '<input type="text" class="form-control popover-input popover-input-nickname">' +
                '<span class="input-group-btn">' +
                '<label class="btn btn-default btn-sm btn-identity-check popover-input" style="width:70px;">중복 확인</label></span>' +
                '</div>' +
                '<div class="input-group input-group-sm" style="width:100%">' +
                '<span class="input-group-addon" style="width: 70px;" disabled >수정시간</span>' +
                '<input type="text" class="form-control popover-input-modified-time" disabled>' +
                '</div>' +
                '<div class="input-group input-group-sm" style=" width:100%">' +
                '<span class="input-group-addon" style="width: 70px" >우선순위</span>' +
                '<span class="input-group-addon" style="width:calc(100% - 70px);" ><select class="popover-input popover-input-priority"><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select></span>' +
                '</div>' +
                '<div class="input-group input-group-sm" style="width:100%; height: 60px;">' +
                '<span class="input-group-addon" style="width: 70px" >메모</span>' +
                '<textarea class="form-control popover-input popover-input-note" style="height: 60px;resize: none;"></textarea>' +
                '</div>' +
                '<div style="padding-top: 15px; position:relative">' +
                '<label class="btn btn-default btn-sm btn-modify-nickname"  style="width:70px;">편집</label>' +
                '<label class="btn btn-default btn-sm btn-popover-close" style="width:70px;position: absolute;right: 0; ">취소</label>' +
                '</div></div>');

        $('.relation' + i).popover({
            html: true,
            content: function () {
                return content.html();
            },
            container: '#book-table',
            template: '<div class="popover popover-author-td"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>',
            placement: 'auto'
        }).on('show.bs.popover', function () {
            //remove popover when other popover appeared
            $('.popover-author-td').popover('hide');
        }).on('shown.bs.popover', function () {
            //handle after popover shown
            var clickedTd = $(this);
            $('.popover-input-author').val(tdata);
            $('.btn-popover-close').click(function (e) {
                $('.popover-author-td').popover('hide');
            });

            $('.popover-input').attr('disabled', '');

            //update nickname
            $('.popover .btn-modify-nickname').click(function (e) {
                if ($(this).text() == '편집') {
                    $('.popover-input').removeAttr('disabled');
                    $(this).toggleClass('btn-primary').text('저장');
                } else {
                    var nicname = $('.popover-input-nickname').val();
                    var author = $('.popover-input-author').val();
                    if ($('.btn-identity-check').attr('disabled') != undefined) {
                        $.ajax({
                            url: "/main/nickname/update",
                            type: "post",
                            data: {
                                "nickname": nicname,
                                "author": author,
//                                "lastModifiedDate": $('.popover-input-modified-time').val(),
                                "priority": $('.popover-input-priority').val(),
                                "note": $('.popover-input-note').val()
                            },
                            success: function (responseData) {
                                if (responseData == 'true') {
                                    for (var k = 0; k < $('#book-table tbody').find('tr').length; k++) {
                                        var nicTmp = $('#book-table tbody').find('tr').eq(k).find('td').eq(5).text();
                                        var html = '';
                                        if (nicTmp == author) {
                                            html = author + '<span>(' + nicname + ')</span>';
                                            $('#book-table tbody').find('tr').eq(k).find('td').eq(5).html(html);
                                        }

                                        nicTmp = $('#book-table tbody').find('tr').eq(k).find('td').eq(6).text();
                                        html = '';
                                        if (nicTmp == $('.popover-input-author').val()) {
                                            html = author + '<span>(' + nicname + ')</span>';
                                            $('#book-table tbody').find('tr').eq(k).find('td').eq(6).html(html);
                                        }
                                        //console.log("BBBBBB : " + $('#book-table tbody').find('tr').eq(k).find('td').eq(5).text());
                                    }
                                    //highLightResult();
                                    $('.popover .btn-identity-check').attr('disabled', '');
                                    $('.popover .btn-modify-nickname').toggleClass('btn-primary').text('편집');
                                    clickedTd.find('.nickname-td').text('(' + $('.popover-input-nickname').val() + ')');
                                    $('.popover').remove();
                                    $('.popover-input').attr('disabled', '');
                                } else {
                                    //when nickname not checked
                                    alert('send error');
                                }
                            }
                        });
                    } else {
                        alert('중복 확인을 해 주세요.');
                    }
                }
            });

            //when popover opened get nickname info from server
            $.ajax({
                url: "/main/nickname/get",
                type: "post",
                data: {
                    "author": $('.popover-input-author').val()
                },
                success: function (responseData) {
                    var result = JSON.parse(responseData);
//                    console.error(responseData);
                    $('.popover-input-nickname').val(result.nickname);
                    $('.popover-input-modified-time').val(result.lastModifiedDate);
                    $('.popover-input-priority').val(result.priority);
                    $('.popover-input-note').val(result.note);
                }
            });

            $('.popover .btn-identity-check').click(function (e) {
                $.ajax({
                    url: "/main/nickname/check",
                    type: "post",
                    data: {
                        "nickname": $('.popover-input-nickname').val(),
                        "author": $('.popover-input-author').val()
                    },
                    success: function (responseData) {
                        if (responseData == 'true') {
                            $('.popover .btn-identity-check').attr('disabled', '');
                            $('.popover .btn-identity-check').append('<span class="glyphicon glyphicon-ok" style="color:#3ce63d;"></span>');
                            $('.popover .popover-input-nickname').on('input', function () {
                                $('.popover .btn-identity-check span').remove();
                                $('.popover .btn-identity-check').removeAttr('disabled');
                            });
                        } else {
                            alert('이미 같은 별명이 존재합니다.');
                        }
                    }
                });
            });

            $('#book-table').on('hidden.bs.popover', function (e) {
                $(e.target).data("bs.popover").inState = {click: false, hover: false, focus: false}
            });
        });
    }

    function clearSearchItem() {
        $('.search-input-group').remove();
    }

    jQuery.fn.tableToCSV = function () {

        var clean_text = function (text) {
            text = text.replace(/"/g, '""');
            return '"' + text + '"';
        };

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
            document.body.appendChild(download_link);
            download_link.click();
            document.body.removeChild(download_link);


        });

    };


    function removeAllRelDiv() {
        $('.relative-table-wrapper').remove();
    }

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

    $('#highlight-checkbox').click(function () {
        $('.matched-content').toggleClass('highlight-background');
    });

    function highLightResult() {
        console.log("QQQ : " + lastQuery);
        $.each($('.author-td'), function (j, contentTd) {
            var stt = $(contentTd).text();
            for (i = 0; i < lastQuery.data.length; i++) {
                if (lastQuery.data[i].category == '저자') {
                    var strTmp = lastQuery.data[i].input.split(/[ ]*[&|][ ]*/);
                    for (var k = 0; k < strTmp.length; k++)
                        stt = stt.replace(strTmp[k], '<span class="matched-content">' + strTmp[k] + '</span>');
                }
            }
            $(contentTd).html(stt);
        });
        $.each($('.relation-td'), function (j, contentTd) {
            var stt = $(contentTd).text();
            for (i = 0; i < lastQuery.data.length; i++) {
                if (lastQuery.data[i].category == '저자') {
                    var strTmp = lastQuery.data[i].input.split(/[ ]*[&|][ ]*/);
                    for (var k = 0; k < strTmp.length; k++)
                        stt = stt.replace(strTmp[k], '<span class="matched-content">' + strTmp[k] + '</span>');
                }
            }
            $(contentTd).html(stt);
        });
        $.each($('.content-td'), function (j, contentTd) {
            var stt = $(contentTd).text();
            for (i = 0; i < lastQuery.data.length; i++) {
                if (lastQuery.data[i].category == '내용') {
                    var strTmp = lastQuery.data[i].input.split(/[ ]*[&|][ ]*/);
                    for (var k = 0; k < strTmp.length; k++)
                        stt = stt.replace(strTmp[k], '<span class="matched-content">' + strTmp[k] + '</span>');
                }
            }
            $(contentTd).html(stt);
        });
        $.each($('.group-td'), function (j, contentTd) {
            var stt = $(contentTd).text();
            for (i = 0; i < lastQuery.data.length; i++) {
                if (lastQuery.data[i].category == '참조') {
                    var strTmp = lastQuery.data[i].input.split(/[ ]*[&|][ ]*/);
                    for (var k = 0; k < strTmp.length; k++)
                        stt = stt.replace(strTmp[k], '<span class="matched-content">' + strTmp[k] + '</span>');
                }
            }
            $(contentTd).html(stt);
        });
    }

    RegExp.escape = function (str) {
        var specials = /[.*+?|()\[\]{}\\$^]/g; // .*+?|()[]{}\$^
        return str.replace(specials, "\\$&");
    };

	fetch_unix_timestamp = function () {  return Math.floor(new Date().getTime() / 1000); };
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

</script>
</body>
</html>