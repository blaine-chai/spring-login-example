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
    <h1>Real-TimeMonitoring System(REMOS)</h1>
</div>
<div id="nav-wrapper">
    <div id="nav"><a href="/main">
        <div class="header-button btn">
            <div class="glyphicon glyphicon-bell"></div>
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
            <div class="header-button btn active">
                <div class="glyphicon glyphicon-signal"
                     style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
                <div>통계</div>
            </div>
        </a>
        <a href="/main/search">
            <div class="header-button btn ">
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
                <%--<div id="nickname-search-option-radio-wrapper" class="btn-group btn-group-justified"--%>
                <%--data-toggle="buttons">--%>
                <%--<label class="btn btn-default btn-sm active"><input type="radio" name="options" id="option1"--%>
                <%--autocomplete="off" checked>저자</label>--%>
                <%--<label class="btn btn-default btn-sm"><input type="radio" name="options" id="option2"--%>
                <%--autocomplete="off">별명</label>--%>
                <%--</div>--%>
                <div id="nickname-search-option-radio-wrapper">
                    <div class="panel panel-default"
                         style="height: 30px; text-align: center; line-height: 30px; margin-bottom: 10px;">저자 검색
                    </div>
                </div>
                <div>
                    <div class="input-group input-group-sm" style="width: 100%; margin-top:10px;">
                        <input id="nickname-search-input" type="text" class="form-control" placeholder="검색어를 입력해주세요."
                               onkeypress="if(event.keyCode==13) {$('#nickname-search-btn').click(); return false;}">
                        <div class="input-group-btn"><label style="width:70px;" id="nickname-search-btn"
                                                            class="btn btn-default btn-primary">검색</label></div>
                    </div>
                    <div id="nickname-result-container" class="panel"
                         style="overflow: auto; max-height:400px; margin-left: 2px; margin-right: 2px; display: none;">
                        <table id="nickname-result-table" style="font-size:11px; overflow: auto"
                               class="table table-fixed table-bordered table-striped table-condensed table-hover">
                            <%--<thead>--%>
                            <%--<tr style="text-align: center;">--%>
                            <%--<th style="width: 30px"></th>--%>
                            <%--<th>저자</th>--%>
                            <%--<th>별명</th>--%>
                            <%--</tr>--%>
                            <%--</thead>--%>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="btn-group" style="margin-top: 10px; width:100%;">
                    <%--<label id="add-nickname-btn" class="btn btn-default btn-sm btn-primary">별명 등록</label>--%>
                    <%--<label id="modify-nickname-btn" class="btn btn-default btn-sm">수정하기</label>--%>
                    <label id="modify-nickname-btn" class="btn btn-default btn-sm" style="width:70%; margin-left:15%;">수정</label>
                </div>

                <div id="nickname-form" class="panel" style="display: none; padding: 10px;">
                    <div class="input-group input-group-sm" style=" width:100%">
                        <span class="input-group-addon" style="width: 70px">저자</span>
                        <input type="text" class="form-control nickname-form-input-author" disabled>
                    </div>
                    <div class="input-group input-group-sm" style="width:100%">
                        <span class="input-group-addon" style="width: 70px">별명</span>
                        <input type="text" class="form-control nickname-form-input nickname-form-input-nickname">
                        <span class="input-group-btn">
                    <label class="btn btn-default btn-sm btn-identity-check nickname-form-input"
                           style="width:70px;">중복 확인</label></span>
                    </div>
                    <div class="input-group input-group-sm" style="width:100%">
                        <span class="input-group-addon" style="width: 70px;" disabled>수정시간</span>
                        <input type="text" class="form-control nickname-form-input-modified-time" disabled>
                    </div>
                    <div class="input-group input-group-sm" style=" width:100%">
                        <span class="input-group-addon" style="width: 70px">우선순위</span>
                        <span class="input-group-addon" style="width:calc(100% - 70px);"><select
                                class="nickname-form-input nickname-form-input-priority"><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select></span>
                    </div>
                    <div class="input-group input-group-sm" style="width:100%; height: 60px;">
                        <span class="input-group-addon" style="width: 70px">메모</span>
                        <textarea class="form-control nickname-form-input nickname-form-input-note"
                                  style="height: 60px;resize: none;"></textarea>
                    </div>
                    <div style="padding-top: 15px; position:relative">
                        <label class="btn btn-default btn-sm btn-modify-nickname" style="width:70px;">편집</label>
                        <label class="btn btn-default btn-sm btn-nickname-form-close"
                               style="width:70px;position: absolute;right: 0; ">취소</label>
                    </div>
                </div>
            </div>
        </div>


        <div id="menu" class="col-xs-8" style="width: calc(100% - 333px)">
            <div id="relative-table-container" style="position: absolute; z-index: 10;"></div>
            <div id="menu-wrapper" style="background: rgba(224, 234, 244, 1); height: calc(100% - 200px);">
                <div class="alert alert-info">
                    <div id="search-result-number">검색결과 :</div>
                    <div id="search-progress" class="progress">
                        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="45"
                             aria-valuemin="0" aria-valuemax="100" style="width: 45%;">
                            45%
                        </div>
                    </div>
                </div>
                <div id="result-table-wrapper" class="panel panel-default"
                     style="margin: 15px; height: calc(100% - 200px); font-size: 11px;overflow-x: auto;">
                    <div id="profile-result-container" style="height: auto">
                    </div>
                </div>
                <div id="page-counter-wrapper">
                    <nav aria-label="..." style="text-align: center; display: none;">
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
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" charset="UTF-8">
    var userHistory = [];
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

    $(document).ready(function () {

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
                    $('#result-table-wrapper').height($(window).height() - 197 - 130);
//                    $('#profile-result-container>div').height($('#result-table-wrapper').height());
                    setProfileResultTableSize();
                    var results = $('#profile-result-container>div');
                    for (i = 0; i < results.length; i++) {
//                console.error(results.eq(i).height() - 1);
                        if (results.eq(i).height() > $('#result-table-wrapper').height() - 1) {
                            results.eq(i).height($('#result-table-wrapper').height() - 1);
                        }
                    }
                });
        $('#search-wrapper').height($(window).height() - 197);
        $('#menu-wrapper').height($(window).height() - 197);
        //        $('#book-table').height($(window).height() - 194 - 200)
        $('#result-table-wrapper').height($(window).height() - 197 - 130);
//        $('#profile-result-container>div').height($('#result-table-wrapper').height());
        setProfileResultTableSize();

//            $('#result-table-wrapper').scroll(function () {
//                $('#book-table-header').css("top",
//                        252 - $('#book-table').offset().top);
//            });


        $('#nickname-search-btn').click(function (e) {
            $('#nickname-result-table>tbody').children().remove();
            $('#nickname-result-container').hide();

            $.ajax({
                url: "/main/profile/search-author",
                type: "post",
                data: {
                    "keyword": $('#nickname-search-input').val()
                },
                success: function (responseData) {
                    var result = JSON.parse(responseData);
                    $.each(result, function (i, authorNickname) {
                        var tmpEl = $('<tr>' +
                                '<td style="text-align: center;"><input type="radio" class="nickname-radio" name="nickname-radio"></td>' +
                                '<td class="nickname-search-td">' + authorNickname.author + '</td>' +
                                '<td class="nickname-search-td">' + authorNickname.nickname + '</td>' +
                                '</tr>');
                        $('#nickname-result-table').append(tmpEl);

                    });
                    setAuthorResultClickHandler();
                }
            });
        });
        setNicknameModifyHandler();

    });


    function exportCsv(table) {
        var rows = table.find('tbody>tr');
        table.tableToCSV();

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

    function onRelativeTdClickHandler(element) {
        var tmpAuthor = $(element).parent().find('td').eq(2).text();
        $.ajax({
            url: "/main/profile/search-rel-author",
            type: "post",
            data: {
                "author": tmpAuthor
            },
            success: function (responseData) {
                var result = JSON.parse(responseData);
                var resultTable = $('<div style="width:260px; float: left; border-bottom-right-radius: 0;border-top-right-radius: 0;background-color: #fafafa;overflow:auto; border-right: 1px solid #ddd;margin-bottom: 0;"' +
                        'class="panel profile-result-content">' +
                        '<div class="panel-heading author-search-result-author" style="width: 250px;border-right: 1px solid #ddd;border-bottom-right-radius: 0;border-top-right-radius: 0;" >' + tmpAuthor + '</div>' +
                        '<table class="table table-hover table-fixed table-bordered table-striped table-condensed" ' +
                        'style="width:250px;float: left;border-right: 1px solid #ddd;"><thead>' +
                        '<tr><th style="width: 50px;">from</th>' +
                        '<th style="width: 50px;">to</th>' +
                        '<th>참조저자</th>' +
                        '</tr>' +
                        '</thead>' +
                        '<tbody>' +
                        '</tbody></table></div>');

                $.each(result, function (i, mResult) {
                    var tmpTr = $('<tr>' +
//                            '<td class="relative-badge-td"><span class="badge" style="background-color: #453d77;">' + parseInt(Math.random() * 30) + '</span></td>' +
                            '<td class="relative-badge-td">' + mResult.from + '</td>' +
//                            '<td class="relative-badge-td"><span class="badge" style="background-color: #770c35;">' + parseInt(Math.random() * 30) + '</span></td>' +
                            '<td class="relative-badge-td">' + mResult.to + '</td>' +
                            '<td onclick="onRelativeTdClickHandler(this);return false;">' + mResult.relAuthor + '</td></tr>');
                    resultTable.find('tbody').append(tmpTr);
                    setRelBadgeClickHandler(tmpTr);
                });
                resultTable.hide();
                $('#profile-result-container').append(resultTable);
//                $('#profile-result-container>div').height($('#result-table-wrapper').height());
                $('#profile-result-container').width($('#profile-result-container').width() + 260);
                resultTable.show(300, function () {
                    setProfileResultTableSize();
                });
            }
        });
    }

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


    function setAuthorResultClickHandler() {
        $('#nickname-result-table .nickname-search-td').click(function (e) {
            var tmpAuthor = $(this).parent().find('td').eq(1).text();
            $('#profile-result-container').children().hide();
            $('#profile-result-container').children().remove();

            $.ajax({
                url: "/main/profile/search-rel-author",
                type: "post",
                data: {
                    "author": tmpAuthor
                },
                success: function (responseData) {
                    var result = JSON.parse(responseData);
                    var resultTable = $('<div style="width:260px; float: left; border-bottom-right-radius: 0;border-top-right-radius: 0;background-color: #fafafa;overflow:auto; border-right: 1px solid #ddd;margin-bottom: 0;"' +
                            'class="panel profile-result-content">' +
                            '<div class="panel-heading author-search-result-author" style="width: 250px;border-right: 1px solid #ddd;border-bottom-right-radius: 0;border-top-right-radius: 0;" >' + tmpAuthor + '</div>' +
                            '<table class="table table-hover table-fixed table-bordered table-striped table-condensed" ' +
                            'style="width:250px;float: left;border-right: 1px solid #ddd;"><thead>' +
                            '<tr><th style="width: 50px;">from</th>' +
                            '<th style="width: 50px;">to</th>' +
                            '<th>참조저자</th>' +
                            '</tr>' +
                            '</thead>' +
                            '<tbody>' +
                            '</tbody></table></div>');

                    $.each(result, function (i, mResult) {
                        var tmpTr = $('<tr>' +
//                            '<td class="relative-badge-td"><span class="badge" style="background-color: #453d77;">' + parseInt(Math.random() * 30) + '</span></td>' +
                                '<td class="relative-badge-td">' + mResult.from + '</td>' +
//                            '<td class="relative-badge-td"><span class="badge" style="background-color: #770c35;">' + parseInt(Math.random() * 30) + '</span></td>' +
                                '<td class="relative-badge-td">' + mResult.to + '</td>' +
                                '<td onclick="onRelativeTdClickHandler(this);return false;">' + mResult.relAuthor + '</td></tr>');
                        resultTable.find('tbody').append(tmpTr);
                        setRelBadgeClickHandler(tmpTr);
                    });
                    resultTable.hide();
                    $('#profile-result-container').append(resultTable);
//                    $('#profile-result-container>div').height($('#result-table-wrapper').height());
                    $('#profile-result-container').width('260');
                    resultTable.show(300, function () {
                        setProfileResultTableSize();
                    });
                }
            });
        });
        $('#nickname-result-container').show(300);
    }

    function setNicknameModifyHandler() {
        $('#modify-nickname-btn').click(function (e) {
            var nicknameForm = $('#nickname-form');
            if ($('input[name=nickname-radio]:checked').length <= 0) {
                return;
            }
            if (nicknameForm.is(':visible')) {
                nicknameForm.hide();
            }
            nicknameForm.children().remove();
            var tmpEl = $('<div class="input-group input-group-sm" style=" width:100%">' +
                    '<span class="input-group-addon" style="width: 70px">저자</span>' +
                    '<input type="text" class="form-control nickname-form-input-author" disabled></div>' +
                    '<div class="input-group input-group-sm" style="width:100%">' +
                    '<span class="input-group-addon" style="width: 70px">별명</span>' +
                    '<input type="text" class="form-control nickname-form-input nickname-form-input-nickname">' +
                    '<span class="input-group-btn">' +
                    '<label class="btn btn-default btn-sm btn-identity-check nickname-form-input" style="width:70px;">중복 확인</label></span></div>' +
                    '<div class="input-group input-group-sm" style="width:100%">' +
                    '<span class="input-group-addon" style="width: 70px;" disabled>수정시간</span>' +
                    '<input type="text" class="form-control nickname-form-input-modified-time" disabled></div>' +
                    '<div class="input-group input-group-sm" style=" width:100%">' +
                    '<span class="input-group-addon" style="width: 70px">우선순위</span>' +
                    '<span class="input-group-addon" style="width:calc(100% - 70px);">' +
                    '<select class="nickname-form-input nickname-form-input-priority"><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select></span></div>' +
                    '<div class="input-group input-group-sm" style="width:100%; height: 60px;">' +
                    '<span class="input-group-addon" style="width: 70px">메모</span>' +
                    '<textarea class="form-control nickname-form-input nickname-form-input-note" style="height: 60px;resize: none;"></textarea></div>' +
                    '<div style="padding-top: 15px; position:relative">' +
                    '<label class="btn btn-default btn-sm btn-primary btn-modify-nickname " style="width:70px;">저장</label>' +
                    '<label class="btn btn-default btn-sm btn-danger btn-delete-nickname " style="width:70px; margin-left: 5px;">삭제</label>' +
                    '<label class="btn btn-default btn-sm btn-nickname-form-close" style="width:70px;position: absolute;right: 0; ">취소</label></div>');
            nicknameForm.append(tmpEl);
            //update nickname
            $('#nickname-form .btn-modify-nickname').click(function (e) {
                if ($('.btn-identity-check').attr('disabled') != undefined) {
                    $.ajax({
                        url: "/nickname/update",
                        type: "post",
                        data: {
                            "nickname": $('.nickname-form-input-nickname').val(),
                            "author": $('.nickname-form-input-author').val(),
//                                "lastModifiedDate": $('.popover-input-modified-time').val(),
                            "priority": $('.nickname-form-input-priority').val(),
                            "note": $('.nickname-form-input-note').val()
                        },
                        success: function (responseData) {
                            if (responseData == 'true') {
                                $('#nickname-form .btn-identity-check').attr('disabled', '');
//                                $('#nickname-form .btn-modify-nickname').toggleClass('btn-primary').text('편집');
//                                    clickedTd.find('.nickname-td').text('(' + $('.popover-input-nickname').val() + ')');
//                                    $('nickname-form').remove();
                                $('.nickname-input').attr('disabled', '');
                                alert('저장이 완료되었습니다.');
                            } else {
                                //when nickname not checked
                                alert('에러가 발생했습니다. 다시 시도해 주세요.');
                            }
                        }
                    });
                } else {
                    alert('중복 확인을 해 주세요.');
                }
            });

            //when popover opened get nickname info from server
            $.ajax({
                url: "/nickname/get",
                type: "post",
                data: {
                    "author": $('input[name=nickname-radio]:checked').parent().parent().find('td').eq(1).text()
                },
                success: function (responseData) {
                    var result = JSON.parse(responseData);
//                    console.error(responseData);
                    $('.nickname-form-input-author').val($('input[name=nickname-radio]:checked').parent().parent().find('td').eq(1).text());
                    $('.nickname-form-input-nickname').val(result.nickname);
                    $('.nickname-form-input-modified-time').val(result.lastModifiedDate);
                    $('.nickname-form-input-priority').val(result.priority);
                    $('.nickname-form-input-note').val(result.note);
                }
            });

            $('#nickname-form .btn-identity-check').click(function (e) {
                $.ajax({
                    url: "/nickname/check",
                    type: "post",
                    data: {
                        "nickname": $('.nickname-form-input-nickname').val(),
                        "author": $('.nickname-form-input-author').val()
                    },
                    success: function (responseData) {
                        if (responseData == 'true') {
                            $('#nickname-form .btn-identity-check').attr('disabled', '');
                            $('#nickname-form .btn-identity-check').append('<span class="glyphicon glyphicon-ok" style="color:#3ce63d;"></span>');
                            $('#nickname-form .nickname-form-input-nickname').on('input', function () {
                                $('#nickname-form .btn-identity-check span').remove();
                                $('#nickname-form .btn-identity-check').removeAttr('disabled');
                            });
                        } else {
                            alert('이미 같은 별명이 존재합니다.');
                        }
                    }
                });
            });

            $('.btn-nickname-form-close').click(function (e) {
                $('#nickname-form').hide();
                $('.nickname-form-input-nickname').val('').removeAttr('disabled');
                $('.nickname-form-input-author').val('').removeAttr('disabled');
                $('.nickname-form-input-modified-time').val('').removeAttr('disabled');
                $('.nickname-form-input-priority').val('5').removeAttr('disabled');
                $('.nickname-form-input-note').val('').removeAttr('disabled');
                $('#nickname-form .nickname-form-input-nickname').on('input', function () {
                    $('#nickname-form .btn-identity-check span').remove();
                    $('#nickname-form .btn-identity-check').removeAttr('disabled');
                });
            });


            nicknameForm.show(300);
        });


        $('#add-nickname-btn').click(function (e) {
            var nicknameForm = $('#nickname-form');
            if (nicknameForm.is(':visible')) {
                nicknameForm.hide();
            }
            nicknameForm.children().remove();
            var tmpEl = $('<div class="input-group input-group-sm" style=" width:100%">' +
                    '<span class="input-group-addon" style="width: 70px">저자</span>' +
                    '<input type="text" class="form-control nickname-form-input-author" disabled></div>' +
                    '<div class="input-group input-group-sm" style="width:100%">' +
                    '<span class="input-group-addon" style="width: 70px">별명</span>' +
                    '<input type="text" class="form-control nickname-form-input nickname-form-input-nickname">' +
                    '<span class="input-group-btn">' +
                    '<label class="btn btn-default btn-sm btn-identity-check nickname-form-input" style="width:70px;">중복 확인</label></span></div>' +
                    '<div class="input-group input-group-sm" style="width:100%">' +
                    '<span class="input-group-addon" style="width: 70px;" disabled>수정시간</span>' +
                    '<input type="text" class="form-control nickname-form-input-modified-time" disabled></div>' +
                    '<div class="input-group input-group-sm" style=" width:100%">' +
                    '<span class="input-group-addon" style="width: 70px">우선순위</span>' +
                    '<span class="input-group-addon" style="width:calc(100% - 70px);">' +
                    '<select class="nickname-form-input nickname-form-input-priority"><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select></span></div>' +
                    '<div class="input-group input-group-sm" style="width:100%; height: 60px;">' +
                    '<span class="input-group-addon" style="width: 70px">메모</span>' +
                    '<textarea class="form-control nickname-form-input nickname-form-input-note" style="height: 60px;resize: none;"></textarea></div>' +
                    '<div style="padding-top: 15px; position:relative">' +
                    '<label class="btn btn-default btn-sm btn-primary btn-modify-nickname " style="width:70px;">저장</label>' +
                    '<label class="btn btn-default btn-sm btn-nickname-form-close" style="width:70px;position: absolute;right: 0; ">취소</label></div>');
            nicknameForm.append(tmpEl);
            $('.nickname-form-input-nickname').val('').removeAttr('disabled');
            $('.nickname-form-input-author').val('').removeAttr('disabled');
            $('.nickname-form-input-priority').val('5').removeAttr('disabled');
            $('.nickname-form-input-note').val('').removeAttr('disabled');
            $('#nickname-form .nickname-form-input-nickname').on('input', function () {
                $('#nickname-form .btn-identity-check span').remove();
                $('#nickname-form .btn-identity-check').removeAttr('disabled');
            });

            $('#nickname-form .btn-modify-nickname').click(function (e) {
                if ($('.btn-identity-check').attr('disabled') != undefined) {
                    $.ajax({
                        url: "/nickname/update",
                        type: "post",
                        data: {
                            "nickname": $('.nickname-form-input-nickname').val(),
                            "author": $('.nickname-form-input-author').val(),
//                                "lastModifiedDate": $('.popover-input-modified-time').val(),
                            "priority": $('.nickname-form-input-priority').val(),
                            "note": $('.nickname-form-input-note').val()
                        },
                        success: function (responseData) {
                            if (responseData == 'true') {
                                $('#nickname-form .btn-identity-check').attr('disabled', '');
                                alert('저장이 완료되었습니다.');
//                                    clickedTd.find('.nickname-td').text('(' + $('.popover-input-nickname').val() + ')');
//                                    $('nickname-form').remove();
                                $('.nickname-input').attr('disabled', '');
                            } else {
                                //when nickname not checked
                                alert('에러가 발생했습니다. 다시 시도해 주세요.');
                            }
                        }
                    });
                } else {
                    alert('중복 확인을 해 주세요.');
                }
            });

            $('#nickname-form .btn-identity-check').click(function (e) {
                $.ajax({
                    url: "/nickname/check",
                    type: "post",
                    data: {
                        "nickname": $('.nickname-form-input-nickname').val(),
                        "author": $('.nickname-form-input-author').val()
                    },
                    success: function (responseData) {
                        if (responseData == 'true') {
                            $('#nickname-form .btn-identity-check').attr('disabled', '');
                            $('#nickname-form .btn-identity-check').append('<span class="glyphicon glyphicon-ok" style="color:#3ce63d;"></span>');
                            $('#nickname-form .nickname-form-input-nickname').on('input', function () {
                                $('#nickname-form .btn-identity-check span').remove();
                                $('#nickname-form .btn-identity-check').removeAttr('disabled');
                            });
                        } else {
                            alert('이미 같은 별명이 존재합니다.');
                        }
                    }
                });
            });

            $('.btn-nickname-form-close').click(function (e) {
                $('#nickname-form').hide();
                $('.nickname-form-input-nickname').val('').removeAttr('disabled');
                $('.nickname-form-input-author').val('').removeAttr('disabled');
                $('.nickname-form-input-modified-time').val('').removeAttr('disabled');
                $('.nickname-form-input-priority').val('5').removeAttr('disabled');
                $('.nickname-form-input-note').val('').removeAttr('disabled');
                $('#nickname-form .nickname-form-input-nickname').on('input', function () {
                    $('#nickname-form .btn-identity-check span').remove();
                    $('#nickname-form .btn-identity-check').removeAttr('disabled');
                });
            });
            nicknameForm.show(300);
        });
    }

    function setRelBadgeClickHandler(element) {
        $(element).find('.relative-badge-td').click(function (e) {
            $.ajax({
                url: "/main/profile/search-rel-author-content",
                type: "post",
                data: {
                    "author": $(element).parent().parent().parent().find('.author-search-result-author').text(),
                    "rel-author": $(element).find('td').eq(2).text()
                },
                success: function (responseData) {
                    var result = JSON.parse(responseData);
                    var tmpHtml = $('<div class="alert bg-white alert-dismissible fade in border-gray relative-table-wrapper" style="position: absolute; z-index: 10; width: 700px; left:' + relStartPos.left + 'px;top:' + relStartPos.top + 'px;" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>' +
                            '<div class="relative-title">' + $(element).parent().parent().parent().find('.author-search-result-author').text() + ' - ' + $(element).find('td').eq(2).text() + '</div>' +
                            '<div style="font-size: 10px;margin-top: 10px;margin-bottom: 10px;position: relative;left: 450px;">' +
//                            '<span class="relative-author-from-date">' + lastQuery.fromDate + '</span>' + (lastQuery.fromDate == '' && lastQuery.toDate == '' ? '' : '</span><span> ~ </span><span class="relative-author-to-date">' + lastQuery.toDate + '</span>') +
                            '</div>' +
                            '<div><div style="overflow: scroll;height: 300px;">' +
                            '<table class="table table-hover table-fixed table-bordered table-striped table-condensed" style="font-size: 11px; height: 300px; margin-bottom: 0;">' +
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

                    $.each(result, function (i, mResult) {
                        var tmpEl = $('<tr><td>' + mResult.savedDate + '</td>' +
                                '<td>' + mResult.author + '</td>' +
                                '<td>' + mResult.relAuthor + '</td>' +
                                '<td class="relative-table-content-td">' + mResult.content + '</td></tr>');
                        tmpHtml.find('tbody').append(tmpEl);
                        tmpEl.find('.relative-table-content-td').popover({
                            html: true,
                            content: function () {
                                return $(this).text();
                            },
                            template: '<div class="popover popover-relative-content-td"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>',
                            container: tmpHtml,
                            placement: 'auto'
                        }).on('show.bs.popover', function () {
                            //remove popover when other popover appeared
                            $('.popover-relative-content-td').popover('hide');
                        });

                    });

                    $('body').append(tmpHtml);
                    tmpHtml.draggable();
                    var tarEl = $(this);
                }
            });
        });
    }

    function setProfileResultTableSize() {
        var results = $('#profile-result-container>div');
        if (results != undefined) {
            for (i = 0; i < results.length; i++) {
////                console.error(results.eq(i).height() - 1);
//                if (results.eq(i).height() > $('#result-table-wrapper').height() - 1) {
                results.eq(i).height($('#result-table-wrapper').height() - 3);
            }
//            }
        }
    }
</script>
</body>
</html>