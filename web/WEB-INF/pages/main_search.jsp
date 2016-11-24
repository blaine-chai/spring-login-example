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

    <%--<link rel="stylesheet"--%>
    <%--href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.0/bootstrap-table.min.css">--%>

    <link href="/css/main-style.css" rel="stylesheet" type="text/css">
    <link href="/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
    <%--<link href="/css/bootstrap-select.css" rel="stylesheet" type="text/css">--%>


    <!-- Latest compiled and minified JavaScript -->
    <%--<script--%>
    <%--src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.0/bootstrap-table.min.js"></script>--%>

    <!-- Latest compiled and minified Locales -->

    <script src="/js/colResizable-1.6.js"></script>
    <script src="/js/moment.js"></script>
    <%--<script src="/js/transition.js"></script>--%>
    <script src="/js/bootstrap-datetimepicker.js"></script>
    <%--<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>
    <script src="/js/jquery-ui.js"></script>
    <script src="/js/FileSaver.js"></script>
    <script src="/js/Blob.js"></script>

</head>
<body>
<div id="header-wrapper">
    <h1>REMOS</h1>
    <div id="user-info-container" class="" style="position: absolute;top:50%;right: 20px;padding-right: 5px;color:#646464;"><span style="padding-right: 15px; padding-left:5px;">${userId}</span><c:if test="${userType.equals(\"admin\")}"><a href="/admin" style="margin-right: 5px;"><label class="btn badge logout-btn" style="">admin<span class="glyphicon glyphicon-cog" style="padding-left: 10px;"></span></label></a></c:if><a href="/logout"><label class="btn badge logout-btn" style="">로그아웃<span class="glyphicon glyphicon-log-out" style="padding-left: 10px;"></span></label></a></div>
</div>
<div id="nav-wrapper">
    <div id="nav">
        <a href="/main">
            <div class="header-button btn">
                <div class="glyphicon glyphicon-bell"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>알림</div>
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
            <div class="header-button btn active">
                <div class="glyphicon glyphicon-search"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>검색</div>
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
                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">참조</a></li>
                                </ul>
                            </div>
                        </div>
                        <input type="text" class="form-control col-xs-4 search-input" placeholder="검색어를 입력해주세요.">
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
                <div style="margin-top: 10px">

                    <div id="search-date-option-container" class="btn-group btn-group-justified" data-toggle="buttons">
                        <label class="btn btn-default btn-sm active"><input type="radio" name="dateOption"
                                                                            autocomplete="off" checked>발행일자</label>
                        <label class="btn btn-default btn-sm"><input type="radio" name="dateOption"
                                                                     autocomplete="off">저장일자</label>
                    </div>
                    <div style="float:left; margin:0 auto;"><span class="glyphicon glyphicon-calendar"
                                                                  style="left:2px; top:5px; width:20px;"></span></div>
                    <div class="" style="padding: 0;  margin:0 auto;"><input id="datepicker1" data-provide="datepicker"
                                                                             style="width: 123px; text-align:center; font-size:12px; float:left;">
                    </div>
                    <div class="" style="float:left; width: 20px; font-size:11px;text-align: center; padding:0;">~</div>
                    <div class="" style="padding:0;  margin:0 auto;"><input id="datepicker2" data-provide="datepicker"
                                                                            style="width: 123px; text-align:center; font-size:12px; float:left;">
                    </div>
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
                           onclick="$(this).parent().find('.expand-btn').click();return false;">User
                        History</label>
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
                        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="45"
                             aria-valuemin="0" aria-valuemax="100" style="width: 45%;">
                            45%
                        </div>
                    </div>
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
                <div id="page-counter-wrapper">
                    <nav aria-label="..." style="text-align: center;">
                        <ul class="pagination pagination-sm" style="margin: 0 auto;">
                            <li class="disabled"><a href="#" aria-label="Previous"><span
                                    aria-hidden="true">«</span></a></li>
                            <li class="active"><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#" aria-label="Next"><span
                                    aria-hidden="true">»</span></a></li>
                        </ul>
                    </nav>
                    <div>하이라이팅<input id="highlight-checkbox" type="checkbox"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" charset="UTF-8">
    var userHistory = [];
    var adminHistory = [];
    var tableData;
    var lastQuery;
    var relStartPos = new Object();
    relStartPos.left = 100;
    relStartPos.top = 200;
    relStartPos.iLeft = 100;
    relStartPos.iTop = 200;
    relStartPos.maxLeft = 300;
    relStartPos.maxTop = 300;
    relStartPos.count = 0;

    function handleOperatorSelect(element) {
        var list = $(element).parent().parent().parent().parent().parent();
        if ($('#search-input-wrapper>div').length - 1 == $('#search-input-wrapper>div').index(list) && $(element).text() != "SEL") {
            $('#search-input-wrapper').append('<div class="input-group input-group-sm search-input-group"><div class="dropdown input-group-btn"><div class="btn-group"><button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 72px"><span class="search-category-option">내용</span>\n<div style="display: inline-block"><span class="caret"></span><span class="sr-only"></span></div></button><ul class="dropdown-menu search-category-selector" role="menu" aria-labelledby="dropdownMenu1"><li role="presentation"><a role="menuitem" tabindex="-1" href="#">내용</a></li><li role="presentation"><a role="menuitem" tabindex="-1" href="#">저자</a></li><li role="presentation"><a role="menuitem" tabindex="-1" href="#">참조</a></li></ul></div></div><input type="text" class="form-control col-xs-4 search-input" placeholder="검색어를 입력해주세요."><div class="dropdown input-group-btn"><div class="btn-group"><button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 55px"><span class="search-operator-option">SEL</span>\n<div style="display: inline-block"><span class="caret"></span><span class="sr-only"></span></div></button><ul id="operator-selector" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1"><li role="presentation"><a role="menuitem" tabindex="1" href="#">SEL</a></li><li role="presentation"><a role="menuitem" tabindex="2" href="#" onclick="handleOperatorSelect(this);return false;">AND</a></li><li role="presentation"><a role="menuitem" tabindex="3" href="#" onclick="handleOperatorSelect(this);return false;">O R</a></li></ul></div><label class="btn btn-default btn-sm close-search-option-btn" disabled>-</label></div></div>');
            $('.close-search-option-btn').removeAttr('disabled');
            $('#search-input-wrapper .close-search-option-btn').click(function (e) {
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

        $('#datepicker1').datetimepicker({
            format: 'YYYY/MM/DD HH:mm:a'
        });
        $('#datepicker2').datetimepicker({
            format: 'YYYY/MM/DD HH:mm:a'
        });


        $('.expand-btn').click(function (e) {
            if ($(this).text() == "+" && $(this).parent().find('div>table>tbody>tr').length > 0) {
                $('.history').hide(300);
//                $(this).parent().append(new_div);
//                new_div.show(300);
                $(this).parent().find('div').show(300);
                $('.expand-btn').text('+');
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


        $('.search-category-selector li a').click(function (e) {
            $($(this).parent().parent().parent()).find('button span').eq(0).text($(this).text());
        });


        $('.search-btn').click(function () {
            removeAllRelDiv();
            $.ajax({
                url: '/main/searching',
                type: 'post',
                data: {"data": jsonSearchInfo()},
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                success: function (responseData) {
                    var data = JSON.parse(responseData);
                    tableData = data;
                    if (!data) {
                        alert("존재하지 않는 ID입니다");
                        return false;
                    }
                    var html = '<tbody>';
                    $.each(data, function (i, tdata) {
                        html += '<tr><td>' + tdata.number + '</td>';
                        var priorityEl = $('');
                        priorityEl.find('select').val(tdata.priority);
                        html += '<td>' + '<select><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select>' + '</td>';
                        html += '<td>' + tdata.groupName + '</td>';
                        html += '<td>' + tdata.publishedDate + '</td>';
                        html += '<td>' + tdata.savedDate + '</td>';
                        html += '<td class="author-td author' + i + '" title="' + tdata.author + '" href="#">' + tdata.author +
                                '<span class="nickname-td">' + (tdata.nickname != undefined ? ('(' + tdata.nickname + ')') : '') + '</span>' + '</td>';
                        //rel-author
                        html += '<td class="relation-td rel-author' + i + '" title="' + tdata.referencedAuthor + '" href="#">' + tdata.referencedAuthor + '</td>';
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
                        html += '<td>' + tdata.note2 + '</tr></td>';
                    });
                    html += '</tbody>';
                    $('#book-table tbody').hide(300, function () {
                        $('#book-table tbody').remove();
                        html = $(html);
                        html.hide();
                        $('#book-table').append(html);
                        $.each(data, function (i, tdata) {
                            $('#book-table select').eq(i).val(tdata.priority);
                            $('#book-table select').eq(i).change(function () {
//                                console.error($(this).val());
                                setPriority($(this));
                            })
                        });
                        html.show(300, function () {
                            addCheckEBtnListener();

                            $.each(data, function (i, tdata) {
                                addAuthorClickListener(i, tdata);
                                addCheckRBtnListener(i, tdata);
                                addRelAuthorClickListener(i, tdata);
                                addContentTdClickListener(i, tdata.contents);
                            });
                            highLightResult();
                        });
                    });
                    getSearchHistory();
                    getAdminHistory();
                    getRelativeWord();
                }
            });
        })

    });

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
//                console.error(responseData);
                $('#user-history>table>tbody>tr').remove();
                $.each(data, function (i, d) {
                    var tmpEl = $('<tr><td class="user-history-bookmark-td"><img class="bookmark-btn" style="width: 26px;height: 26px;"></td><td>' + d.word + '</td><td class="user-history-remove-td"><label class="btn btn-default btn-sm close-search-option-btn">-</label></td></tr>');
                    if (d.isBookmarked) {
                        tmpEl.find('img').addClass('bookmark-btn-active');
                    }
                    $('#user-history>table>tbody').prepend(tmpEl);
                    tmpEl.find('.close-search-option-btn').click(function (e) {
                        deleteUserHistory(this, d.id);
                        $(this).parent().parent().remove();
                    });
                });
                $('#user-history>table>tbody>tr>td:nth-child(2)').click(function (e) {
                    addSearchInfo(JSON.parse($(this).text()));
                });

                $('#user-history .user-history-bookmark-td').click(function (e) {
                    var icon = $(this).find('img');
                    if ($(this).find('img').hasClass('bookmark-btn-active')) {
                        $.ajax({
                            url: '/main/user-bookmark/delete',
                            type: 'post',
                            data: {'data': $(this).parent().find('td:nth-child(2)').text()},
                            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                            success: function (responseData) {
                                icon.toggleClass('bookmark-btn-active');
                            }
                        });
                    } else {
                        $.ajax({
                            url: '/main/user-bookmark/add',
                            type: 'post',
                            data: {'data': $(this).parent().find('td:nth-child(2)').text()},
                            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                            success: function (responseData) {
                                icon.toggleClass('bookmark-btn-active');
                            }
                        });
                    }
                });
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
//                console.error(responseData);
                $('#admin-history>table>tbody>tr').remove();
                $.each(data, function (i, d) {
                    var tmpEl = $('<tr><td class="user-history-bookmark-td"><img class="bookmark-btn" style="width: 26px;height: 26px;"></td><td>' + d.word + '</td><td class="user-history-remove-td"><label class="btn btn-default btn-sm close-search-option-btn">-</label></td></tr>');
                    if (d.isBookmarked) {
                        tmpEl.find('img').addClass('bookmark-btn-active');
                    }
                    $('#admin-history>table>tbody').prepend(tmpEl);
                    tmpEl.find('.close-search-option-btn').click(function (e) {
                        deleteAdminHistory(this, d.id);
                        $(this).parent().parent().remove();
                    });
                });
                $('#admin-history>table>tbody>tr>td:nth-child(2)').click(function (e) {
                    addSearchInfo(JSON.parse($(this).text()));
                });

                $('#admin-history .user-history-bookmark-td').click(function (e) {
                    var icon = $(this).find('img');
                    if ($(this).find('img').hasClass('bookmark-btn-active')) {
                        $.ajax({
                            url: '/main/admin-bookmark/delete',
                            type: 'post',
                            data: {'data': $(this).parent().find('td:nth-child(2)').text()},
                            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                            success: function (responseData) {
//                                console.error(responseData);
                                icon.toggleClass('bookmark-btn-active');
                            }
                        });
                    } else {
                        $.ajax({
                            url: '/main/admin-bookmark/add',
                            type: 'post',
                            data: {'data': $(this).parent().find('td:nth-child(2)').text()},
                            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                            success: function (responseData) {
//                                console.error(responseData);
                                icon.toggleClass('bookmark-btn-active');
                            }
                        });
                    }
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

            }
        });
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

            }
        });
    }

    function getRelativeWord(json) {
        var data;
        $.ajax({
            url: "/main/relative-word",
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

    function jsonSearchInfo() {
        var typeInfo = $('#search-option-radio-wrapper>.active').text();
        var categoryEls = $('.search-category-option');
        var inputEls = $('.search-input');
        var operatorEls = $('.search-operator-option');
        var data = new Object();
        var list = [];
        var obj;
        inputEls.each(function (i) {
            obj = new Object();
            obj.category = categoryEls.eq(i).text();
            obj.input = inputEls.eq(i).val();
            obj.operator = operatorEls.eq(i).text();
            list.push(obj);
        });
        data.data = list;
        data.typeInfo = typeInfo;
        data.fromDate = $('#datepicker1').val();
        data.toDate = $('#datepicker2').val();
        lastQuery = data;
        return JSON.stringify(data);
    }

    function addSearchInfo(a) {
        $('.search-input-group').remove();
        if (a.typeInfo == '문자포함') {
            $('#option1').parent().click();
        } else if (a.typeInfo == '형태소') {
            $('#option2').parent().click();
        } else {
            $('#option3').parent().click();
        }

        $.each(a.data, function (i) {
            var newDiv = $('<div class="input-group input-group-sm search-input-group"><div class="dropdown input-group-btn"><div class="btn-group"><button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 72px"><span class="search-category-option">내용</span><div style="display: inline-block"><span class="caret"></span><span class="sr-only"></span></div></button><ul class="dropdown-menu search-category-selector" role="menu" aria-labelledby="dropdownMenu1"><li role="presentation"><a role="menuitem" tabindex="-1" href="#">내용</a></li><li role="presentation"><a role="menuitem" tabindex="-1" href="#">저자</a></li><li role="presentation"><a role="menuitem" tabindex="-1" href="#">참조</a></li></ul></div></div><input type="text" class="form-control col-xs-4 search-input" placeholder="검색어를 입력해주세요."><div class="dropdown input-group-btn"><div class="btn-group"><button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 55px"><span class="search-operator-option">SEL</span>\n<div style="display: inline-block"><span class="caret"></span><span class="sr-only"></span></div></button><ul id="operator-selector" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1"><li role="presentation"><a role="menuitem" tabindex="1" href="#">SEL</a></li><li role="presentation"><a role="menuitem" tabindex="2" href="#" onclick="handleOperatorSelect(this);return false;">AND</a></li><li role="presentation"><a role="menuitem" tabindex="3" href="#" onclick="handleOperatorSelect(this);return false;">O R</a></li></ul></div><label class="btn btn-default btn-sm close-search-option-btn">-</label></div></div>');
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

    function setNickname() {

    }

    function addContentTdClickListener(i, contents) {
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

    function addCheckRBtnListener(i) {
        $('.check-r' + i).click(function () {
            var tmpEl = $('<div class="alert bg-white alert-dismissible fade in border-gray relative-table-wrapper" style="position: absolute; z-index: 10; width: 700px; left:' + relStartPos.left + 'px;top:' + relStartPos.top + 'px;" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>' +
                    '<div class="relative-title">' + tableData[i].author + ' - ' + tableData[i].referencedAuthor + '</div>' +
                    '<div style="font-size: 10px;margin-top: 10px;margin-bottom: 10px;position: relative;left: 450px;">' +
                    '<span class="relative-author-from-date">' + lastQuery.fromDate + '</span>' + (lastQuery.fromDate == '' && lastQuery.toDate == '' ? '' : '</span><span> ~ </span><span class="relative-author-to-date">' + lastQuery.toDate + '</span>') +
                    '</div>' +
                    '<div class="draggable-content-container"><div style="overflow: scroll;height: 300px;">' +
                    '<table class="table table-hover table-fixed table-bordered table-striped table-condensed" style="font-size: 11px; margin-bottom: 0;">' +
                    '<thead><tr><th>저장시간</th><th>저자</th><th>참조저자</th><th>내용</th></tr></thead>' +
                    '<tbody></tbody></table></div><div><nav aria-label="..." style="text-align: center; margin-top:10px;">' +
                    '<ul class="pagination pagination-sm" style="margin: 0 auto;">' +
                    '<li><a href="#" aria-label="Previous" class="disabled"><span aria-hidden="true">«</span></a></li>' +
                    '<li><a href="#" class="active">1</a></li>' +
                    '<li><a href="#">2</a></li>' +
                    '<li><a href="#">3</a></li>' +
                    '<li><a href="#">4</a></li>' +
                    '<li><a href="#">5</a></li>' +
                    '<li><a href="#" aria-label="Next"><span aria-hidden="true">»</span></a></li></ul></nav></div>' +
                    '<label class="btn btn-primary btn-export" style="position: absolute;right: 15px;bottom: 15px;font-size: 11px;">export</label></div>');
            setRelTablePos();
            $('body').append(tmpEl);
            for (j = 0; j < 20; j++) {
                var content = $('<tr><td>' +
                        '2014-05-' + j + '</td>' +
                        '<td>저자' + j + '</td>' +
                        '<td>참조저자' + j + '</td>' +
                        '<td class="relative-table-content-td">always work (for bootstrap' + j + '</td></tr>');

                tmpEl.find('tbody').append(content);
                content.find('.relative-table-content-td').popover({
                    html: true,
                    content: function () {
                        return $(this).text();
                    },
                    template: '<div class="popover popover-relative-content-td"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><button type="button" class="close" data-dismiss="popover" aria-label="Close"><span aria-hidden="true">×</span></button><div class="popover-content"></div></div></div>',
                    container: tmpEl.find('.draggable-content-container'),
                    placement: 'auto'
                }).on('show.bs.popover', function () {
                    //remove popover when other popover appeared
                    $('.popover-relative-content-td').popover('hide');
                }).on('shown.bs.popover', function () {
                    $('.popover-relative-content-td .close').click(function () {
                        $('.popover-relative-content-td').popover('hide');
                    });
                });
            }
            tmpEl.draggable({cancel: '.draggable-content-container'});
            var tarEl = $(this);
            tmpEl.find('.btn-export').click(function (e) {
                exportCsv(tmpEl.find('table'));
                $.ajax({
                    url: "/main/e-check",
                    type: "post",
                    data: {"bookId": tarEl.parent().find('td').eq(0).text()},
                    success: function (responseData) {
                        var data = JSON.parse(responseData);

//                    console.error(tarEl);

                        tarEl.parent().find('td').eq(8).find('span').remove();
                        tarEl.parent().find('td').eq(8).append('<span class="glyphicon glyphicon-ok"></span>');
                    }
                });
            });
            $.ajax({
                url: "/main/r-check",
                type: "post",
                data: {"bookId": tarEl.parent().find('td').eq(0).text()},
                success: function (responseData) {
//                                var data = JSON.parse(responseData);

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


    function addCheckEBtnListener() {
        $('.check-e').click(function () {
            var tarEl = $(this);
            $.ajax({
                url: "/main/e-check",
                type: "post",
                data: {"bookId": tarEl.parent().find('td').eq(0).text()},
                success: function (responseData) {
                    var data = JSON.parse(responseData);

//                    console.error(tarEl);

                    tarEl.find('span').remove();
                    tarEl.append('<span class="glyphicon glyphicon-ok"></span>');
//                    console.log(html);
                }
            });
        });
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
            $('.popover-input-author').val(tdata.author);
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
                        $.ajax({
                            url: "/main/nickname/update",
                            type: "post",
                            data: {
                                "nickname": $('.popover-input-nickname').val(),
                                "author": $('.popover-input-author').val(),
//                                "lastModifiedDate": $('.popover-input-modified-time').val(),
                                "priority": $('.popover-input-priority').val(),
                                "note": $('.popover-input-note').val()
                            },
                            success: function (responseData) {
                                if (responseData == 'true') {
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

    function addRelAuthorClickListener(i, tdata) {

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

        $('.rel-author' + i).popover({
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
            $('.popover-input-author').val(tdata.referencedAuthor);
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
                        $.ajax({
                            url: "/main/nickname/update",
                            type: "post",
                            data: {
                                "nickname": $('.popover-input-nickname').val(),
                                "author": $('.popover-input-author').val(),
//                                "lastModifiedDate": $('.popover-input-modified-time').val(),
                                "priority": $('.popover-input-priority').val(),
                                "note": $('.popover-input-note').val()
                            },
                            success: function (responseData) {
                                if (responseData == 'true') {
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
        for (i = 0; i < lastQuery.data.length; i++) {
//            var regex = new RegExp("(" + RegExp.escape(lastQuery.data[i].input) + ")", "gi");
            var regex = lastQuery.data[i].input;
//            var regex = new RegExp("(" + RegExp.escape('tom') + ")", "gi");
            if (lastQuery.data[i].category == '저자') {
                $.each($('.author-td'), function (i, contentTd) {
                    $(contentTd).html($(contentTd).html().replace(regex, '<span class="matched-content">' + regex + '</span>'));
                });
            } else if (lastQuery.data[i].category == '내용') {
                $.each($('.content-td'), function (i, contentTd) {
                    $(contentTd).html($(contentTd).html().replace(regex, '<span class="matched-content">' + regex + '</span>'));
//                    console.error($(contentTd).text());
                });
            } else if (lastQuery.data[i].category == '참조') {
                $.each($('.relation-td'), function (i, contentTd) {
                    $(contentTd).html($(contentTd).html().replace(regex, '<span class="matched-content">' + regex + '</span>'));
                });
            }
        }
    }

    RegExp.escape = function (str) {
        var specials = /[.*+?|()\[\]{}\\$^]/g; // .*+?|()[]{}\$^
        return str.replace(specials, "\\$&");
    };


    function initPagination(current, from, to, lastPage, cssSelector) {
        var pageController = $('.pagination');
//        var pageController = $(cssSelector);
        pageController.children().remove();
        var pageEl = $('<li><a href="#" aria-label="Previous"><span aria-hidden="true">«</span></a></li>')
        if (from == 1) {
            pageEl.addClass('disabled');
        }
        pageController.append(pageEl);

        for (i = from; i <= to; i++) {
            pageEl = $('<li class="page-btn"><a href="#">' + i + '</a></li>');
            if (i == current) {
                pageEl.addClass('active');
            }
            pageController.append(pageEl);
        }
        pageEl = $('<li><a href="#" aria-label="Next"><span aria-hidden="true">»</span></a></li>');
        if (to == lastPage) {
            pageEl.addClass('disabled');
        }
        pageController.append(pageEl);
    }


</script>
</body>
</html>