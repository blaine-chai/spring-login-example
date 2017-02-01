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
    <script src="/js/cytoscape.js"></script>
    <%--<script src="/js/jquery-qtip.js"></script>--%>
    <%--<script src="/js/cytoscape-qtip.js"></script>--%>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.2.0/jquery.qtip.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/qtip2/2.2.0/jquery.qtip.min.css" rel="stylesheet"
          type="text/css"/>
    <script src="https://cdn.rawgit.com/cytoscape/cytoscape.js-qtip/2.2.5/cytoscape-qtip.js"></script>

</head>
<body>
<div id="header-wrapper">
    <img src="/imgs/logo.png" style="margin: 0 auto;">
    <div id="user-info-container" class=""
         style="position: absolute;top:50%;right: 20px;padding-right: 5px;color:#646464;"><span
            style="padding-right: 15px; padding-left:5px;">${userId}</span><c:if test="${userType.equals(\"admin\")}"><a
            href="/admin" style="margin-right: 5px;" class="btn badge logout-btn">admin<span
            class="glyphicon glyphicon-cog" style="padding-left: 10px;"></span></a></c:if><a
            href="/logout" class="btn badge logout-btn">로그아웃<span class="glyphicon glyphicon-log-out"
                                                                  style="padding-left: 10px;"></span></a>
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
        <a href="#">
            <div class="header-button btn active">
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
                <%--<div id="nickname-search-option-radio-wrapper" class="btn-group btn-group-justified"--%>
                <%--data-toggle="buttons">--%>
                <%--<label class="btn btn-default btn-sm active"><input type="radio" name="options" id="option1"--%>
                <%--autocomplete="off" checked>저자</label>--%>
                <%--<label class="btn btn-default btn-sm"><input type="radio" name="options" id="option2"--%>
                <%--autocomplete="off">별명</label>--%>
                <%--</div>--%>
                <div id="nickname-search-option-radio-wrapper">
                    <div id="search-option-radio-wrapper" class="btn-group btn-group-justified" data-toggle="buttons">
                        <label class="btn btn-default btn-sm active"><input type="radio" name="options" id="option1"
                                                                            autocomplete="off" checked>일반 모드</label>
                        <label class="btn btn-default btn-sm show-graph-btn"><input type="radio" name="options"
                                                                                    id="option2"
                                                                                    autocomplete="off">그래프 모드</label>
                    </div>
                </div>
                <div>
                    <div class="author-datepicker-container" style="height: 25px;margin-top: 10px;">
                        <div id="search-date-option-container" class="btn-group btn-group-justified">
                            <label class="btn btn-default btn-sm" name="dateOption" style="padding: 4px;">ALL</label>
                        </div>
                        <div style="float: left;margin-top: 3px;display: flex;width: calc(100% - 55px);">
                            <div class="" style="padding: 0; margin:0 auto; float: left;"><input id="datepicker1"
                                                                                                 data-provide="datepicker"
                                                                                                 style="width: 111px; text-align:center; font-size:12px; float:left;">
                            </div>
                            <div style="float:left; width: 14px; font-size:11px;text-align: center; padding:0;vertical-align: middle;line-height: 23px;">
                                ~
                            </div>
                            <div style="padding:0;margin:0 auto;float: left;"><input id="datepicker2"
                                                                                     data-provide="datepicker"
                                                                                     style="width: 111px; text-align:center; font-size:12px; float:left;">
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
                    <div class="input-group input-group-sm" style="width: 100%; margin-top:10px;">
                        <input id="nickname-search-input" type="text" class="form-control"
                               placeholder="검색어를 입력해주세요."
                               onkeypress="if(event.keyCode==13) {$('#nickname-search-btn').click(); return false;}">
                        <div class="input-group-btn"><label style="width:70px;" id="nickname-search-btn"
                                                            class="btn btn-default btn-primary">검색</label></div>
                    </div>
                    <%--<div class="input-group input-group-sm" style="width: 100%; margin-top:10px;">--%>
                    <%--<input id="nickname-search-input" type="text" class="form-control"--%>
                    <%--placeholder="검색어를 입력해주세요."--%>
                    <%--onkeypress="if(event.keyCode==13) {$('#nickname-search-btn').click(); return false;}">--%>
                    <%--<div class="input-group-btn"><label style="width:70px;" id="nickname-search-btn"--%>
                    <%--class="btn btn-default btn-primary">검색</label></div>--%>
                    <%--</div>--%>
                    <div id="nickname-result-container" class="panel panel-default"
                         style=" max-height:400px; margin-left: 2px; margin-right: 2px; display: none;border-top-left-radius: 0;border-top-right-radius: 0;">
                        <div class="nickname-result-table-container" style="max-height:366px;overflow: auto;">
                            <table id="nickname-result-table" style="font-size:11px; overflow: auto;position:relative;"
                                   class="table table-fixed table-condensed table-hover">
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
                        <div class="component-pager" style="height: 24px;margin: 5px 0 5px 0;">
                            <div style="width: 297px;position: absolute;text-align: center;line-height: 24px;"><span
                                    class="component-pager-page" style="">1</span></div>
                            <label class="btn btn-default btn-default-left"
                                   style="position: absolute;height: 20px;width: 20px;font-size: 14px;margin: 2px;left: 35px;">
                                <span style="position: absolute;top: -2px;right: 8px;">«</span></label>
                            <label class="btn btn-default btn-default-right"
                                   style="height: 20px;width: 20px;font-size: 14px;margin: 2px;position: absolute;right: 35px;"><span
                                    style="position: absolute;top: -2px;right: 8px;">»</span></label></div>
                    </div>
                </div>

                <div class="btn-group" style="margin-top: 10px; width:100%;">
                    <%--<label id="add-nickname-btn" class="btn btn-default btn-sm btn-primary">별명 등록</label>--%>
                    <%--<label id="modify-nickname-btn" class="btn btn-default btn-sm">수정하기</label>--%>
                    <label id="modify-nickname-btn" class="btn btn-default btn-sm"
                           style="width:70%; margin-left:15%;">수정</label>
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
                                class="nickname-form-input nickname-form-input-priority"><option>0</option><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select></span>
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
            <div id="menu-wrapper"
                 style="background: rgba(224, 234, 244, 1); height: calc(100% - 210px); padding-top: 10px;">
                <div id="result-table-wrapper" class="panel panel-default"
                     style="margin: 0px 15px 15px; height: 764px;font-size: 11px;overflow-x: auto;">
                    <div id="profile-result-container" style="height: auto;">
                    </div>
                    <div class="profiling-graph-container" style="background: #fff;visibility: hidden;"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--<div class="cover"--%>
<%--style="width: 100%;height: 100%;background:rgba(51,51,51,0.5); z-index: 10;position: absolute;top:0;padding: 20px;visibility: hidden;">--%>
<%--<div class="close-btn" style="position: absolute;cursor: pointer;font-size: 18px;right: 40px;z-index: 10;top:40px;">--%>
<%--x--%>
<%--</div>--%>
<%--<div class="profiling-graph-container" style="background: #fff;position: absolute;top: 20px;"></div>--%>
<%--</div>--%>
<%--<script type="text/javascript" charset="UTF-8" src="/js/alarm-update.js"></script>--%>
<script type="text/javascript" charset="UTF-8" src="/js/auto-logout.js"></script>
<script type="text/javascript" charset="UTF-8" src="/js/common.js"></script>
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
    var nicNameDB;
    var isProfileSearch = true;
    var dataEx;

    var loadingRing = $('<img class="loading-ring" src="/imgs/ajax-loader.gif" style="position: absolute;right: 50px;">');
    var loadingRing2 = $('<img class="loading-ring" src="/imgs/ajax-loader.gif" style="position: absolute;left: 8px;">');
    var loadingRing3 = $('<img class="loading-ring" src="/imgs/ajax-loader.gif" style="position: absolute;right: 150px;">');

    var searchResultPager = $('#nickname-result-container .component-pager');

    var isGraphMode = false;

    $(document).ready(function () {
        $(document).ajaxComplete(function (e, xhr, settings) {
            if (xhr.status === 403) {
                window.location.replace('/')
            }
        });

        $(window).resize(function () {
            //            $('#content').height($(window).height());
            $('#search-wrapper').height(
                    $(window).height() - 197);
            //            console($(document).width() + 'px');
            $('#menu-wrapper').height(
                    $(window).height() - 207);
            //            $('#book-table').attr('data-height', $(window).height() - 194 - 200)
            //            $('#book-table').height($(window).height() - 194 - 200)
            $('#result-table-wrapper').height($(window).height() - 222);
//                    $('#profile-result-container>div').height($('#result-table-wrapper').height());
            setProfileResultTableSize();
            var results = $('#profile-result-container>div');
            for (i = 0; i < results.length; i++) {
//                console.error(results.eq(i).height() - 1);
                if (results.eq(i).height() > $('#result-table-wrapper').height() - 1) {
                    results.eq(i).height($('#result-table-wrapper').height() - 1);
                }
            }

//            $('.profiling-graph').width($(window).width() - 45);
            $('.profiling-graph').height($(window).height() - 222);
//            $('.profiling-graph>div').width($(window).width() - 45);
            $('.profiling-graph>div').height($(window).height() - 222);
//            $('.profiling-graph-container').width($(window).width() - 45);
            $('.profiling-graph-container').height($(window).height() - 222);
        });

//        $('.profiling-graph-container').width($(window).width() - 45);
        $('.profiling-graph-container').height($(window).height() - 222);
        $('#search-wrapper').height($(window).height() - 197);
        $('#menu-wrapper').height($(window).height() - 207);
        //        $('#book-table').height($(window).height() - 194 - 200)
        $('#result-table-wrapper').height($(window).height() - 222);
//        $('#profile-result-container>div').height($('#result-table-wrapper').height());
        setProfileResultTableSize();

        $("input:radio[name='groups']").eq(0).prop("checked", true);
//        $("input:radio[name='groups']:radio[value='전부']").prop("checked", true);

//            $('#result-table-wrapper').scroll(function () {
//                $('#book-table-header').css("top",
//                        252 - $('#book-table').offset().top);
//            });
        $(document).on('click', '.profile-result-relative-author-td', onRelativeTdClickHandler);
//        $('.profile-result-relative-author-td').on('click', onRelativeTdClickHandler);

        $('#datepicker1').val("").attr("disabled", true);
        $('#datepicker2').val("").attr("disabled", true);

        $('label[name=dateOption]').click(function () {
            if ($(this).text() == 'ALL') {
                $(this).text('MSG');
                var timestamp = fetch_unix_timestamp();
                timestamp = timeConverter(timestamp - 3600 * 24 * 50);

                $('#datepicker1').datetimepicker({format: 'Y/m/d', value: timestamp}).removeAttr('disabled');
                $('#datepicker2').datetimepicker({format: 'Y/m/d', value: new Date()}).removeAttr('disabled');
            }
            else if ($(this).text() == 'MSG') {
                var timestamp = fetch_unix_timestamp();
                timestamp = timeConverter(timestamp - 3600 * 24 * 50);

                $('#datepicker1').datetimepicker({format: 'Y/m/d', value: timestamp}).removeAttr('disabled');
                $('#datepicker2').datetimepicker({format: 'Y/m/d', value: new Date()}).removeAttr('disabled');
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

        //nicNameUpdate();

        $('#nickname-search-btn').click(function (e) {
            if (isProfileSearch) {
                isProfileSearch = false;
                $('#nickname-result-table>tbody').children().remove();
                $('#nickname-result-container').hide();
                var keyword = $('#nickname-search-input').val() + ">" + $('input[name="groups"]:checked').val();

                console.log(keyword);
                if (keyword == "") {
                    alert("검색어를 입력해주세요.");
                    isProfileSearch = true;
                }
                else {
                	nicknameClose();
                	if($('#nickname-search-input').val() != "*") {
                        $(this).append(loadingRing3);
                        callAjax("CprofileSearch", keyword, "", 16, 0, keyword, "");
                    } else
                        callAjax("CprofileSearch", keyword, "", 17, 0, keyword, "");
                }
            }
        });

        setNicknameModifyHandler();

        $('.btn-default-left').click(function () {
            setNicknameResultTable(parseInt($(this).attr('index')));
        });

        $('.btn-default-right').click(function () {
            setNicknameResultTable(parseInt($(this).attr('index')));
        });
    });


    function setAuthorResultClickHandler() {
        $('#nickname-result-table .nickname-search-td').click(function (e) {
            if (isProfileSearch) {
                isProfileSearch = false;
                var tmpAuthor = $(this).parent().find('td').eq(1).text() + $(this).parent().find('td').eq(2).text();
                console.log(tmpAuthor);
                idCNT++;

                $('#profile-result-container').children().hide();
                $('#profile-result-container').children().remove();

                $(this).append(loadingRing);

                stop = false;
                if (setTime != 0) clearTimeout(setTime);
                var from = $('#datepicker1').val();
                var to = $('#datepicker2').val();
                if ($('#datepicker1').val() != '') from += " 00:00:00";
                if ($('#datepicker2').val() != '') to += " 23:59:59";

                isGraphMode = $('.show-graph-btn').is('.active');

                var period = tmpAuthor + '>' + from + "-" + to + ">" + $('label[name=dateOption]').text() + ">" + $('input[name="groups"]:checked').val();
                callAjax("Cprofile" + idCNT, period, "", 9, 0, "", "");
                $('.profiling-graph').remove();
            }
        });
        $('#nickname-result-container').show(300);
    }

    function callAjax(id, tmpAuthor, period, sel, page, msg, data) {
        console.log(id + " : " + tmpAuthor + " : " + period + " : " + sel + " : " + page + " : " + msg);
        $.ajax({
            url: "/main/profile/search-rel-author",
            type: "post",
            data: {
                "id": id,
                "author": tmpAuthor,
                "period": period,
                "sel": sel,
                "page": page,
                "msg": msg,
                "data": data
            },
            success: searchRelAuthorSuccess
        });
    }

    var stop = true;
    var setTime;
    var resultAuthor;
    function searchRelAuthorSuccess(responseData) {
        var data = JSON.parse(responseData);
        if ((data.sel == 10) && (!stop)) return;
        console.log(stop + " : " + data.id + " : " + data.author + " : " + data.period + " : " + data.sel + " : " + data.page + " : " + data.contents);

        if (data.contents == "NotOK") {
            if (stop) {
                setTime = setTimeout(function () {
                    callAjax(data.id, data.author, data.period, data.sel, data.page, data.contents, "");
                }, 1000);
            }
        }
        else if (data.contents == "NoData") {
            alert("처리시간을 조정하여 다시 한번 검색해 주세요.동일한 결과가 반복될 경우에는 데이터베이스에 저장된 자료가 없을 수 있습니다!!!");
            $('.loading-ring').remove();
            isProfileSearch = true;
        }
        else if (data.contents == "NotConnect") {
            alert("네크워크 연결실패!!! 동일한 결과가 반복될 경우에는 서버가 실행중인지 확인이 필요합니다.");
        }
        else {
            if (data.sel == 1) {
                //var result = JSON.parse(data.bookInfoList);
                callAjax(data.id, data.author, data.period, 4, data.page, "", "");
                //nicNameUpdate();
            }
            else if (data.sel == 2) {
                $('.loading-ring').remove();
                setRelBadgeShow(responseData);
                //setTime = setTimeout(function() {callAjaxLoop(tdata.id, data.author, data.period, 4, 0, "", ""); }, 1000);
            }
            else if (data.sel == 12) {
                $('.loading-ring').remove();
                setRelBadgeShow2(data.bookInfoList, data.job, data.contents, data.id, data.page);
            }

            else if (data.sel == 4) {
                console.log(data.contents);
                var sel2 = data.contents.split("!@#$");
                //lastPageMain = ((sel2[0]-1) - (sel2[0]-1)%50) / 50 + 1;
                console.log(sel2[0] + " : " + sel2[1]);

                callAjax(data.id, data.author, data.period, 2, 0, sel2[0], "");
            }
            else if (data.sel == 9) {
                stop = true;
                var result = JSON.parse(data.bookInfoList);
                callAjax(data.id, data.author, data.period, 10, data.page, "", "");
                //nicNameUpdate();
            }
            else if (data.sel == 10) {
                var author = data.author.split('>');
                var result = JSON.parse(data.bookInfoList);
                if (result.length > 0) {
                    console.log("AAAAAAAA");
                    if (data.page == 0) {
                        if (isGraphMode) {
                            $('.profiling-graph-container').css("visibility", "hidden");
                            initGraph();
                            dataEx = data;
                            addNode(author[0], function () {
                            });
                            addGraphData(author[0], result);
//                            $('.cover').css("visibility", "visible");
                        } else {
                            $('.profiling-graph-container').css("visibility", "hidden");
                            ProfileResultModule.ExpandComponent().newExpandComponent({
                                data: result,
                                parentClassId: data.period,
                                title: author[0]
                                //parentContainer: $(element).parent().parent().parent().parent().parent().parent()
                            });
                            var exBTN = $('#profile-result-container .expand-btn');

                            //console.log(exBTN.parent().html());
                            exBTN.parent().parent().find('.table-expanded-container').hide(300);
                            exBTN.parent().parent().find('.component-pager').hide(300);
                            exBTN.parent().find('.table-expanded-container').show(300);
                            exBTN.parent().find('.component-pager').show(300);
                            exBTN.parent().parent().find('.expand-btn').text('+');
                            exBTN.text("-");
                            $('#profile-result-container').width('260');
                        }
                    }
                    else {
                        if (isGraphMode) {
                            $('.profiling-graph-container').css("visibility", "hidden");
                            addGraphData(author[0], result);
//                            $('.profiling-graph-container').css("visibility", "visible");
                        } else {
                            ProfileResultModule.ExpandComponent().newExpandComponent({
                                data: result,
                                parentClassId: data.period,
                                title: author[0],
                                parentContainer: parentContainer
                            });
                            $('.loading-ring').remove();
                            setProfileResultTableSize();
                            parentContainer = "";
                        }
                    }
                } else alert("검색결과가 없습니다.");
                $('.loading-ring').remove();

                isProfileSearch = true;
            }
            else if (data.sel == 16) {
                stop = true;
                callAjax(data.id, data.author, data.period, 15, data.page, "", "");
                //nicNameUpdate();
            }
            else if (data.sel == 15) {
                var result = JSON.parse(data.bookInfoList);
                resultAuthor = result;

//                var tmpEl = "";
                var key = data.author.split(">")[0];
                var group = data.author.split(">")[1];
                if (result.length != 0) {
                    setNicknameResultTable(1);
                }
                else alert("검색결과가 없습니다.");

                $('.loading-ring').remove();

                isProfileSearch = true;
            }
            else if (data.sel == 17) {
                var result = JSON.parse(data.bookInfoList);
                resultAuthor = result;

//                var tmpEl = "";
                var key = data.author.split(">")[0];
                var group = data.author.split(">")[1];
                //console.log("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa : " + result.length);
                if (result.length != 0) {
                    //console.log("AAAAA");
                    setNicknameResultTable(1);
                }
                else {
                    //console.log("BBBBB");
                    alert("검색결과가 없습니다.");
                }

                isProfileSearch = true;
            }
        }
    }

    // 이전페이지의 첫번째 번호와 다음 페이지의 첫번째 번호가 들어감 from은 표시할 내용의 첫번째 번호
    function setNicknameResultTable(from) {
        var next;
        var prev;
//        var end = from + 49
        if (from <= 0) {
            return;
        } else if (from > resultAuthor.length) {
            return;
        }
        if (from + 50 < resultAuthor.length) {
            next = from + 50;
        } else if (from + 50 > resultAuthor.length) {
            next = resultAuthor.length + 1;
        }

        if (from < 1) {
            return;
        } else if (from < 51) {
            prev = -1;
        } else {
            prev = from - 50;
        }

        $('#nickname-result-table>tbody').empty();
        var tmpEl = "";
//        else if(from+50 == resultAuthor.size())
        for (i = from - 1; i < next - 1; i++) {
            //console.log("ZZZZZZZZ" + resultAuthor[i]);
            var tmp = resultAuthor[i].split(">");
            var nic = '';
            if (tmp.length > 1) nic = tmp[1];

            tmpEl += '<tr>' +
                    '<td style="text-align: center;"><input type="radio" class="nickname-radio" name="nickname-radio"></td>' +
                    '<td class="nickname-search-td">' + tmp[0] + '</td>' +
                    '<td class="nickname-search-td">' + (nic != '' ? '(' + nic + ')' : '') + '</td>' +
                    '</tr>';
//            cnt++;
        }
        // }
        //}

        if (from == 0) alert("검색결과가 없습니다.");
        else {
            $('#nickname-result-table>tbody').append($(tmpEl));
            if (resultAuthor.length > 50) {
                $('#nickname-result-table').parent().parent().find('.component-pager-page').text(from + '-' + (next - 1) + '(' + resultAuthor.length + ')');
                $('.btn-default-left').attr('index', prev);
                $('.btn-default-right').attr('index', next);

            }
            else {
                $('#nickname-result-table').parent().parent().find('.component-pager-page').text('1-' + resultAuthor.length + '(' + resultAuthor.length + ')');
                $('.btn-default-left').attr('index', -1);
                $('.btn-default-right').attr('index', 1);
           }
            setAuthorResultClickHandler();
        }
    }

    function searchRelAuthorSuccess2(responseData) {
        var result = JSON.parse(responseData);

        ProfileResultModule.ExpandComponent().newExpandComponent({
            data: result,
            parentClassId: classId,
            title: tmpAuthor,
            parentContainer: $(element).parent().parent().parent().parent().parent().parent()
        });
        setProfileResultTableSize();
    }

    var idCNT = 0;

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

    //        $('#highlight-checkbox').click(function () {
    //            $('.matched-content').toggleClass('highlight-background');
    //        });

    var parentContainer = "";
    function onRelativeTdClickHandler(element) {
        if (parentContainer != "") return;
        parentContainer = $(element).parent().parent().parent().parent().parent().parent();
        $(element).append(loadingRing);
        var tmpAuthor = $(element).parent().find('td').eq(1).text();
        var classId = $(element).parent().attr('class-id');

        idCNT++;
        var from = $('#datepicker1').val();
        var to = $('#datepicker2').val();
        if ($('#datepicker1').val() != '') from += " 00:00:00";
        if ($('#datepicker2').val() != '') to += " 23:59:59";

        var period = tmpAuthor + '>' + from + "-" + to + ">" + $('label[name=dateOption]').text() + ">" + $('input[name="groups"]:checked').val();
        callAjax("Cprofile" + idCNT, period, classId, 9, 1, "", "");
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
                    '<span class="input-group-addon" style="width: 70px;" disabled >생성시간</span>' +
                    '<input type="text" class="form-control nickname-form-input-created-time" disabled>' +
                    '</div>' +
                    '<div class="input-group input-group-sm" style="width:100%">' +
                    '<span class="input-group-addon" style="width: 70px;" disabled>수정시간</span>' +
                    '<input type="text" class="form-control nickname-form-input-modified-time" disabled></div>' +
                    '<div class="input-group input-group-sm" style=" width:100%">' +
                    '<span class="input-group-addon" style="width: 70px">우선순위</span>' +
                    '<span class="input-group-addon" style="width:calc(100% - 70px);">' +
                    '<select class="nickname-form-input nickname-form-input-priority"><option>0</option><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select></span></div>' +
                    '<div class="input-group input-group-sm" style="width:100%; height: 60px;">' +
                    '<span class="input-group-addon" style="width: 70px">메모</span>' +
                    '<textarea class="form-control nickname-form-input nickname-form-input-note" style="height: 60px;resize: none;"></textarea></div>' +
                    '<div style="padding-top: 15px; position:relative">' +
                    '<label class="btn btn-default btn-sm btn-primary btn-modify-nickname " style="width:70px;">저장</label>' +
                    '<label class="btn btn-default btn-sm btn-delete-nickname " style="width:70px; margin-left: 5px;">삭제</label>' +
                    '<label class="btn btn-default btn-sm btn-nickname-form-close" style="width:70px;position: absolute;right: 0; ">취소</label></div>');
            nicknameForm.append(tmpEl);
            //update nickname
            $('#nickname-form .btn-modify-nickname').click(function (e) {
                if ($('.btn-identity-check').attr('disabled') != undefined) {
                    $.ajax({
                        url: "/main/nickname/update",
                        type: "post",
                        data: {
                            "nickname": $('.nickname-form-input-nickname').val(),
//                                "author": $('.nickname-form-input-author').val(),
                            "author": nicNameOff($('.nickname-form-input-author').val()),
//                                "lastModifiedDate": $('.popover-input-modified-time').val(),
                            "priority": $('.nickname-form-input-priority').val(),
                            "note": $('.nickname-form-input-note').val()
                        },
                        success: function (responseData) {
                            if (responseData == 'true') {
                            	var tmpHml = $('#nickname-result-table>tbody');
                            	console.log(tmpHml.find('td').length);

                                for (var k = 1; k < tmpHml.find('td').length-1; k++) {
                                    var nicTmp = tmpHml.find('td').eq(k).text();
                                	console.log(k + " : " + nicTmp);
                                	if(nicTmp == nicNameOff($('.nickname-form-input-author').val()))
                                	tmpHml.find('td').eq(k+1).text('(' + $('.nickname-form-input-nickname').val() + ')');
                                	k++;
                                	k++;

                                    //console.log("BBBBBB : " + $('#book-table tbody').find('tr').eq(k).find('td').eq(5).text());
                                }

                                nicknameForm.children().remove();
                                nicknameForm.hide();
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

            $('#nickname-form .btn-delete-nickname').click(function () {
                $.ajax({
                    url: "/main/nickname/delete",
                    type: "post",
                    data: {
                        "author": nicNameOff($('.nickname-form-input-author').val())
                    },
                    success: function (responseData) {
                        if (responseData == 'true') {
                            nicknameForm.hide();
                            alert('삭제 완료되었습니다.');
                        } else {
                            //when nickname not checked
                            alert('에러가 발생했습니다. 다시 시도해 주세요.');
                        }
                    }
                });
            });

            //when popover opened get nickname info from server
            $.ajax({
                url: "/main/nickname/get",
                type: "post",
                data: {
                    "author": nicNameOff($('input[name=nickname-radio]:checked').parent().parent().find('td').eq(1).text())
                },
                success: function (responseData) {
                    var result = JSON.parse(responseData);
//                    console.error(responseData);
                    $('.nickname-form-input-author').val($('input[name=nickname-radio]:checked').parent().parent().find('td').eq(1).text());
                    $('.nickname-form-input-nickname').val(result.nickname);
                    if (result.lastModifiedDate != undefined) {
	                    var inputTime = result.lastModifiedDate.split('<br>');
	                    if(inputTime.length < 2) {
		                    $('.nickname-form-input-created-time').val(result.lastModifiedDate);
		                    $('.nickname-form-input-modified-time').val(result.lastModifiedDate);
	                    }else {
		                    $('.nickname-form-input-created-time').val(inputTime[1]);
		                    $('.nickname-form-input-modified-time').val(inputTime[0]);
	                    }
                    }
                    //$('.nickname-form-input-modified-time').val(result.lastModifiedDate);
                    if (result.priority == undefined) {
                        $('.nickname-form-input-priority').val('9');
                    } else {
                        $('.nickname-form-input-priority').val(result.priority);
                    }
                    $('.nickname-form-input-note').val(result.note);
                }
            });

            $('#nickname-form .btn-identity-check').click(function (e) {
                if (!stringCheck($('.nickname-form-input-nickname').val())) {
                    alert('별명을 입력 후 다시 시도해주세요.');
                    return;
                }
                $.ajax({
                    url: "/main/nickname/check",
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
                    '<select class="nickname-form-input nickname-form-input-priority"><option>0</option><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option></select></span></div>' +
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
                        url: "/main/nickname/update",
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
                    url: "/main/nickname/check",
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
            	nicknameClose();
            });
            nicknameForm.show(300);
        });
    }

    function nicknameClose() {
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
    }

    function setRelBadgeClickHandler(element) {
        $(element).find('.relative-badge-td').click(function (e) {
            idCNT++;
            var author = nicNameOff($(element).parent().parent().parent().parent().find('.table-expanded-title').text());
            var relAuthor = nicNameOff($(element).find('td').eq(1).text());

            var fromTime = $('#datepicker1').val();
            if (fromTime != "") fromTime += " 00:00:00";
            var toTime = $('#datepicker2').val();
            if (toTime != "") toTime += " 23:59:59";

            var period = fromTime + "-" + toTime + ">" + $('label[name=dateOption]').text() + ">" + $('input[name="groups"]:checked').val();

            var id = "profile" + idCNT;
//console.log(">"+ $('input[name="groups"]:checked').val());
            $(element).append(loadingRing2);
            callAjax(id, author + '>' + period, relAuthor, 1, 0, "", "");
        });
    }

    function setRelBadgeShow(responseData) {
        var tmpadta = JSON.parse(responseData);

        var s = tmpadta.author.split(">");
        var author = s[0];
        var groupName = s[3];
        var relAuthor = tmpadta.period;
        var period = s[1];
        var id = tmpadta.id;
        var count = tmpadta.contents;

        var result = JSON.parse(tmpadta.bookInfoList);

        var tHtml = '<ul class="pagination pagination-sm pagination-' + id + '" style="margin: 0 auto;">';
        tHtml += '<li><a href="#" aria-label="Previous" class="disabled"><span aria-hidden="true">«</span></a></li>';
        for (var j = 0; j * 50 < count; j++) {
            tHtml += '<li><a href="#">' + (j + 1) + '</a></li>';
            if (j == 4) break;
        }
        tHtml += '<li><a href="#" aria-label="Next"><span aria-hidden="true">»</span></a></li></ul></nav></div>' +
                '<label class="btn btn-primary btn-export" style="position: absolute;right: 15px;bottom: 15px;font-size: 11px;">export</label></div>';

        var tmpEl = $('<div class="alert bg-white alert-dismissible fade in border-gray relative-table-wrapper" style="position: absolute; z-index: 10; width: 700px; left:' + relStartPos.left + 'px;top:' + relStartPos.top + 'px;" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>' +
                '<div class="relative-title">' + author + ' - ' + relAuthor + '<span>  : ' + count + ' 건</span></div>' +
                '<div style="font-size: 10px;margin-top: 10px;margin-bottom: 10px;position: relative;left: 450px;">' +
                '<span class="relative-author-from-date">' + period + '(' + $('label[name=dateOption]').text() + ')</span>' +
                '</div>' +
                '<div class="draggable-content-container"><div style="overflow: scroll;height: 300px;">' +
                '<table class="table table-hover table-fixed table-bordered table-striped table-condensed" style="font-size: 11px; margin-bottom: 0;">' +
                '<thead><tr><th width="120px">저장시간</th><th width="50px">저자</th><th width="50px">참조</th><th>내용</th></tr></thead>' +
                '<tbody></tbody></table></div><div><nav aria-label="..." style="text-align: center; margin-top:10px;">' +
                tHtml +
                '</div>');

        setRelTablePos();
        console.log(result);
        $.each(result, function (i, tdata) {
            var authorColor = "background: #d3f3d3;";
            var relAuthorColor = "background: #f3d3f3;";
            if (tdata.author != author) {
                authorColor = "background: #f3d3f3;";
                relAuthorColor = "background: #d3f3d3;";
            }
            var hml = '<tr>' + '<td>' + tdata.publishedDate + '</td>';
            hml += '<td style="' + authorColor + '" class="author-td author' + i + '" title="' + tdata.author + '" href="#">' + tdata.author +
                    '<span>' + (tdata.authNickname != undefined ? '(' + tdata.authNickname + ')' : '') + '</span>' + '</td>';
            hml += '<td style="' + relAuthorColor + '" class="relation-td relation' + i + '" title="' + tdata.referencedAuthor + '" href="#">' + tdata.referencedAuthor
                    + '<span>' + (tdata.refNickname != undefined ? '(' + tdata.refNickname + ')' : '') + '</span>' + '</td>';
            hml += '<td style="word-break: break-all">' + tdata.contents + '</td>' + '</tr>';
            tmpEl.find('tbody').append(hml);
        });

        $('body').append(tmpEl);
        tmpEl.draggable({cancel: '.draggable-content-container'});
        var tarEl = $(this);

        $('.pagination-' + id + ' .active').css("background-color", "#4682B4").css("color", "white");
        $('.pagination-' + id + ' li').eq(1).addClass('active');

        tmpEl.find('.pagination-' + id + ' li').click(function (e) {

            var col = $(this).parent().children().index($(this));
            console.log($(this).parent().children().length);

            $(this).append(loadingRing2);
            var textPage = $('.pagination-' + id).find('li').eq(col).text();
            var prePage = $('.pagination-' + id + ' .active').text();

            if (textPage == prePage) {
                $('.loading-ring').remove();
                return;
            }

            if ((col > 0) && (col < ($(this).parent().children().length) - 1)) {
                repeatCnt = 0;
                //stop = false;
                $(this).addClass('active').siblings().removeClass('active');
                callAjax(id, 2, 3, 12, textPage - 1, count + ">" + author, "");
                console.log(col + " :111: " + textPage);
            }
            else {
                textPage = parseInt($('.pagination-' + id).find('li').eq(1).text());

                if (col == 0) {
                    textPage = textPage - 5;
                    if (textPage < 1) textPage = 1;

                    if (textPage == prePage) {
                        $('.loading-ring').remove();
                        return;
                    }
                    $('.pagination-' + id).find('li').eq(1).addClass('active').siblings().removeClass('active');
                    repeatCnt = 0;
                    //stop = false;
                    callAjax(id, 2, 3, 12, textPage - 1, count + ">" + author, "");
                }
                else {
                    textPage = textPage + 5;
                    var lastp = ((count - 1) - (count - 1) % 50) / 50 + 1;
                    if (textPage > lastp) textPage = lastp;

                    if (textPage == prePage) {
                        $('.loading-ring').remove();
                        return;
                    }
                    $('.pagination-' + id).find('li').eq($(this).parent().children().length - 2).addClass('active').siblings().removeClass('active');
                    repeatCnt = 0;
                    //stop = false;
                    callAjax(id, 2, 3, 12, textPage - 1, count + ">" + author, "");
                }
                console.log(col + " :222: " + textPage);
            }
        });

        tmpEl.find('.btn-export').click(function (e) {
            //exportCsv(tmpEl.find('table'));
            repeatCnt = 0;
            stop = false;
            /*
             if (!$('#book-table tbody').find('tr').eq(row).find('td').eq(8).find('span').hasClass( "glyphicon-ok"))
             callAjaxLoop("author"+authorNUM, 8, row, 8, 8, tableData[row].eventNo+">t", "");
             else
             callAjaxLoop("author"+authorNUM, 8, row, 8, 8, tableData[row].eventNo+">f", "");
             */
            var from = $('#datepicker1').val();
            var to = $('#datepicker2').val();
            if ($('#datepicker1').val() != '') from += " 00:00:00";
            if ($('#datepicker2').val() != '') to += " 23:59:59";

			var period = from + "-" + to + ">" + $('label[name=dateOption]').text();
            callAjax(id, "}}}}}}}>indexB^" + author + " & " + "indexB^" + relAuthor + ">완전일치>" + period + ">" + groupName + ">N", "", 8, 0, "", "");
        });

    }

    function setRelBadgeShow2(responseData, row, count, id, page) {
        var data = JSON.parse(responseData);
        console.log(row + " : " + count + " : " + id + " : " + page);

        var s = count.split(">");
        count = s[0];
        var author = s[1];
        //authInfoJson = data;

        $('.pagination-' + id).parent().parent().parent().find('tbody').children().remove();
        $.each(data, function (i, tdata) {
            var authorColor = "background: #d3f3d3;";
            var relAuthorColor = "background: #f3d3f3;";
            if (tdata.author != author) {
                authorColor = "background: #f3d3f3;";
                relAuthorColor = "background: #d3f3d3;";
            }
            var hml = '<tr>' + '<td>' + tdata.publishedDate + '</td>';
            hml += '<td style="' + authorColor + '" class="author-td author' + i + '" title="' + tdata.author + '" href="#">' + tdata.author +
                    '<span>' + (tdata.authNickname != undefined ? '(' + tdata.authNickname + ')' : '') + '</span>' + '</td>';
            hml += '<td style="' + relAuthorColor + '" class="relation-td relation' + i + '" title="' + tdata.referencedAuthor + '" href="#">' + tdata.referencedAuthor
                    + '<span>' + (tdata.refNickname != undefined ? '(' + tdata.refNickname + ')' : '') + '</span>' + '</td>';
            hml += '<td style="word-break: break-all">' + tdata.contents + '</td>' + '</tr>';
            $('.pagination-' + id).parent().parent().parent().find('tbody').append(hml);
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

    function onProfileResultCloseBtnClick(element) {
        $(element).parent().hide(100, function () {
            $(element).parent().remove();
            $('#profile-result-container').width($('#profile-result-container').width() - 260);
        });
    }


    //    function deleteExpandByClassId(classId) {
    //        $('.' + classId).remove();
    //    }


    //        function expandTable(element) {
    //            $(element).parent().find('.expand-btn').click();
    //        }
    //        var hi;
    var ProfileResultModule = (function () {
        var CLASS_NUM = 1;
        var CLASS_NAME_PREFIX = 'expand-table-';
        var topContainer = $('#profile-result-container');
        var ExpandComponent = function () {
            var defaults = {
                html: '<div class="btn-group" style="padding-top: 5px; width: 100%;margin:0;">' +
                '<label class="btn btn-default btn-sm expand-btn btn-primary"' +
                'style="width: 29px; margin:0;">+</label>' +
//                '<label class="btn btn-default btn-sm table-expanded-title" style="width:calc(100% - 59px); margin:0;" onclick="expandTable(this);return false;">User History</label>' +
                '<label class="btn btn-default btn-sm table-expanded-title" style="width:calc(100% - 59px); margin:0;" onclick="$(this).parent().find(\'.expand-btn\').click();return false;">User History</label>' +
                '<label class="btn btn-default expand-component-close" style="width: 30px;height: 30px;right: 0;margin: 0;padding: 0;border-left: 0;border-top-right-radius: 4px;border-bottom-right-radius: 4px;"><span aria-hidden="true" style="font-size: 15px;margin: 0;padding: 0;line-height: 25px;">×</span></label>' +
                '<div class="panel table-expanded-container" style="overflow: auto; max-height:300px; margin-left: 2px; margin-right: 2px; display: none;border-bottom: 1px solid #ccc;border-left: 1px solid #ccc;border-right: 1px solid #ccc;border-top-right-radius: 0;border-top-left-radius: 0;margin-bottom: 5px;">' +
                '<table style="font-size:11px; word-break: break-all; " ' +
                'class="table table-fixed table-bordered table-striped table-condensed table-hover"><tbody></tbody></table></div>' +
                '<div class="component-pager" style="display: none; height: 24px;">' +
                '<div style="width: 100%;position: absolute;text-align: center;line-height: 24px;"><span class="component-pager-page" style="">1</span></div>' +
                '<label class="btn btn-default btn-default-left" style="position: absolute;height: 20px;width: 20px;font-size: 14px;margin: 2px;left: 35px;">' +
                '<span style="position: absolute;top: -2px;right: 8px;">«</span></label>' +
                '<label class="btn btn-default btn-default-right" style="height: 20px;width: 20px;font-size: 14px;margin: 2px;position: absolute;right: 35px;"><span style="position: absolute;top: -2px;right: 8px;">»</span></label></div></div>',
                paddingTop: '5px',
                btnWidth: '29px',
                tableHeight: '500px',
                display: 'none',
                onDelete: null,
                onResize: null,
                parentContainer: $('body'),
                onExpand: null,
                data: [{from: 1, relAuthor: 2}, {from: 3, relAuthor: 4}, {from: 5, relAuthor: 6}],
                firstTd: '<input type="checkbox">',
                title: '',
                parentClassId: ''
            };

            var init = function (options) {
                var opt = $.extend(defaults, options);
                var pContainer = opt.parentContainer;
                var tmpEl = $(opt.html);
                tmpEl.find('.expand-btn').css('width', opt.btnWidth);
                //tmpEl.find('.table-expanded-title').text(nicNameFind(opt.title));
                tmpEl.find('.table-expanded-title').text(opt.title);
                tmpEl.find('.table-expanded-container').css('max-height', opt.tableHeight);
                tmpEl.css('padding-top', opt.paddingTop);

                var data = opt.data;
                var from = 0;
                var to = 50;
                var count = 50;

                console.log(pContainer);
                var addExpandComponent = function () {
                    hi = pContainer;
                    if (topContainer.children().length == 0 || parentContainer.index() >= parentContainer.parent().children().size() - 1) {
                        var container = $('<div class="panel profile-result-content" style="width:260px; float: left; border-bottom-right-radius: 0;border-top-right-radius: 0;background-color: #fafafa;overflow:auto; border-right: 1px solid #ddd;margin-bottom: 0;padding-left: 5px;padding-right: 5px;"></div>');
                        container.append(tmpEl);
                        topContainer.append(container);
                        topContainer.width(topContainer.width() + 260);
                    } else {
                        pContainer.parent().children().eq(pContainer.index() + 1).append(tmpEl);
                    }
                };

                var setPageLeftClickListener = function (e) {
                    $(e).find('.btn-default-left').click(function () {
                        //console.log(data.length + " :: ");
                        tmpEl.find('tbody').children().remove();
                        from = from - count;
                        if (parseInt(from) < 0) from = 0;
                        to = from + count;
                        if (parseInt(to) > data.length) to = data.length;
                        setContent(data, from, to);
                        tmpEl.find('.component-pager-page').text((from + 1) + "-" + to + "(" + data.length + ")");
                        //console.log(from + " :: " + to);
                    });
                }(tmpEl);

                var setPageRightClickListener = function (e) {
                    $(e).find('.btn-default-right').click(function () {
                        tmpEl.find('tbody').children().remove();

                        to = to + count;
                        if (parseInt(to) > data.length) to = data.length;
                        from = (to - 1) - (to - 1) % count;
                        if (parseInt(to) < 0) from = 0;
                        setContent(data, from, to);
                        tmpEl.find('.component-pager-page').text((from + 1) + "-" + to + "(" + data.length + ")");
                    });
                }(tmpEl);

                var setExpandBtnClickListener = function (e) {
                    $(e).find('.expand-btn').click(function () {
                        if ($(this).text() == "+" && $(this).parent().find('div>table>tbody>tr').length > 0) {
//                            $(this).parent().parent().find('.table-expanded-container').hide(300);
//                            $(this).parent().parent().find('.component-pager').hide(300);
                            $(this).parent().find('.table-expanded-container').show(300);
                            $(this).parent().find('.component-pager').show(300);
//                            $(this).parent().parent().find('.expand-btn').text('+');
                            $(this).text("-");
                        } else {
                            $(this).text("+");
                            $(this).parent().find('.table-expanded-container').hide(300);
                            $(this).parent().find('.component-pager').hide(300);
                        }
                    });
                }(tmpEl);

                var setCloseBtnClickListener = function (e) {
                    $(e).find('.expand-component-close').click(function () {
                        $.each($(this).parent().find('[class-id]'), function (i, tableTr) {
                            deleteExpandComponentsByClassId($(tableTr).attr('class-id'));
                        });
                        if ($(e).parent().children().length <= 1) {
                            $(e).parent().remove();
                            topContainer.width(topContainer.width() - 260);
                            return;
                        }
                        $(e).remove();
                    });
                }(tmpEl);


                if (parseInt(to) > data.length) {
                    to = data.length + "";
                    //console.log("AAAAA : " + to);
                }
                tmpEl.find('.component-pager-page').text((from + 1) + "-" + to + "(" + data.length + ")");

                var setContent = function (data, from, to) {
                    console.log(from + " : " + to);
                    $.each(data, function (i, data) {
                        if ((i >= parseInt(from)) && (i < parseInt(to))) {
                            var tmpTr = $('<tr>' +
                                    //                            '<td class="relative-badge-td"><span class="badge" style="background-color: #453d77;">' + parseInt(Math.random() * 30) + '</span></td>' +
                                    '<td class="relative-badge-td" style="cursor: pointer; width:30px;">' + data.from + '</td>' +
                                    //                            '<td class="relative-badge-td"><span class="badge" style="background-color: #770c35;">' + parseInt(Math.random() * 30) + '</span></td>' +
                                    //                        '<td class="relative-badge-td" style="width:30px;">' + data.to + '</td>' +
                                    //'<td class="profile-relative-author-td" style="cursor:pointer; border-right:0;">' + nicNameFind(data.relAuthor) + '</td>' +
                                    '<td class="profile-relative-author-td" style="cursor:pointer; border-right:0;">' + data.relAuthor + '</td>' +
                                    '<td style="vertical-align: middle; margin: 0; padding: 0; border-left:0; width: 15px;"><label class="btn btn-default btn-sm remove-btn" style="padding: 3px 10px; line-height: 1; margin: 0 5px 0 0;">-</label></td></tr>');
                            tmpTr.attr('class-id', CLASS_NAME_PREFIX + data.to);
                            tmpTr.attr('parent-class-id', opt.parentClassId);
                            tmpEl.find('tbody').append(tmpTr);
                            setRelBadgeClickHandler(tmpTr);
                        }
                    });
                    tmpEl.find('.profile-relative-author-td').click(function (e) {
                        var classId = $(this).parent().attr('class-id');
                        //console.log(classId);
                        var hasChildren = false;
                        $('tr[parent-class-id=' + classId + ']').each(function () {
                            hasChildren = true;
                        });
                        if (hasChildren) {
                            alert("중복된 ID 입니다");
                        } else {
                            onRelativeTdClickHandler(this);
                        }
                    });
                    tmpEl.find('.remove-btn').click(function (e) {
                        var row = $(this).parent().parent().parent().children().index($(this).parent().parent());
                        deleteExpandComponentsByClassId(CLASS_NAME_PREFIX + data[from + row].to);

                        //console.log(data.length + " :: " + row);
                        //$(this).parent().parent().remove();
                        data.splice(from + row, 1);
                        tmpEl.find('tbody').children().remove();
                        if (to > data.length) to = data.length;
                        console.log(from + " :ww " + data.length);
                        if (from == data.length) {
                            from = from - 50;
                            if (parseInt(from) < 0) from = 0;
                            to = from + 50;
                            if (parseInt(to) > data.length) to = data.length;
                        }
                        if (parseInt(to) == 0) {
                            console.log("aaaaaaaaaaaaaaaaaa");
                        }
                        setContent(data, from, to);
                        tmpEl.find('.component-pager-page').text((from + 1) + "-" + to + "(" + data.length + ")");
                    });
                };

                setContent(data, from, to);
                addExpandComponent();

                var getClassId = function () {
                    return tmpEl.attr('class-id');
                };

                var deleteExpandComponentsByClassId = function (classId) {
                    $('tr[parent-class-id=' + classId + ']').each(function () {
                        deleteExpandComponentsByClassId($(this).attr('class-id'));
                        if ($(this).parent().children().length <= 1) {
                            var component = $(this).parent().parent().parent().parent();
                            if (component.parent().children().length <= 1) {
                                component.parent().remove();
                                topContainer.width(topContainer.width() - 260);
                                return;
                            } else {
                                component.remove();
                                return;
                            }
                        }
                        $(this).remove();
                    });
                };


                jQuery.fn.deleteExpandComponentsByClassId = deleteExpandComponentsByClassId;
                jQuery.fn.getComponent = getClassId;
                jQuery.fn.getContainer = function () {
                    return container;
                };
                jQuery.fn.getComponentByClassId = function (classId) {
                    return $('tr[class-id=' + classId + ']');
                };
                return {
                    getContainer: function () {
                        return tmpEl.getContainer();
                    },
                    deleteExpandComponentsByClassId: function () {
                        deleteExpandComponentsByClassId(tmpEl.attr('class-id'));
                    },
                    getClassId: function () {
                        return getClassId();
                    }
                }
            };

            return {
                newExpandComponent: function (options) {
                    return init(options);
                }
            }
        };

        return {
            ExpandComponent: ExpandComponent
        }

    })(ProfileResultModule);
    /*
     var nicNameDB = [];
     function nicNameFind(author) {
     var Nic = author;
     $.each(nicNameDB, function (i, nicDB) {
     if (nicDB.author == author) {
     console.log("aAAAAA");
     //if(nicDB.author.indexOf(keyword) != -1) {  //if(str1.indexOf(str2) != -1){
     Nic = author + "(" + nicNameDB[i].nickname + ")";
     }
     });

     //        console.log(Nic + " : " + author);
     return Nic;
     }
     */

    function nicNameOff(author) {
        var s = author.split("(");

        return s[0];
    }
    /*
     function nicNameUpdate() {
     $.ajax({
     url: "/main/profile/search-author",
     type: "post",
     data: {
     "keyword": $('#nickname-search-input').val()
     },
     success: function (responseData) {
     var result = JSON.parse(responseData);
     nicNameDB = result;
     }
     });
     }
     */
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
        var month = a.getMonth() + 1;
        var date = a.getDate();
        var hour = a.getHours();
        var min = a.getMinutes();
        var sec = a.getSeconds();

        if (month < 10) month = "0" + month;
        if (date < 10) date = "0" + date;
        if (hour < 10) hour = "0" + hour;
        if (min < 10) min = "0" + min;
        if (sec < 10) sec = "0" + sec;

        //var time = a.getFullYear() + '/' + month + '/' + date + ' ' + hour + ':' + min + ':' + sec ;
        var time = a.getFullYear() + '/' + month + '/' + date;
        return time;
    }

    fetch_unix_timestamp = function () {     	//return parseInt(new Date().getTime().toString().substring(0, 10));
        return Math.floor(new Date().getTime() / 1000);
    };

    var graph;

    var initGraph = function () {
        $('#profiling-graph').remove();
        graphCount = 0;

        var cyEl = $('<div id="profiling-graph" class="profiling-graph" style=""></div>');
//        var canvas = $('<canvas class="profiling-graph" width="1000px" height="500px" style="margin-top: 20px;"></canvas>');
        $('.profiling-graph-container').append(cyEl);
        console.log($('.profiling-graph-container'));

        initCy();

//        cy.on('mouseover', 'node', function(event) {
//            var node = event.cyTarget;
//            node.qtip({
//                content: 'hello',
//                show: {
//                    event: event.type,
//                    ready: true
//                },
//                hide: {
//                    event: 'mouseout unfocus'
//                }
//            }, event);
//        });

//        layout = cy.makeLayout(layoutOption);
//
//        layout.on('layoutstop', function(){
//            cy.resize();
//            $('.profiling-graph-container').css("visibility", "visible");
//        });

//        $('.profiling-graph').width($(window).width() - 50);
        $('.profiling-graph').height($(window).height() - 222);

//        $('.profiling-graph>div').width($(window).width() - 50);
        $('.profiling-graph>div').height($(window).height() - 222);
//        canvas.springy({
//            graph: graph,
//            nodeSelected: function (node) {
//                console.log('Node selected: ' + JSON.stringify(node.data));
//            }
//        });
//        cy.resize();
    };
    colorSet = [
        '#3333FF',
        '#669933',
        '#FF3333',
        '#33CCFF',
        '#33FF33',
        '#FF33CC',
        '#CCFF33',
        '#CC33FF',
        '#663366',
        '#336699',
        '#CC33CC',
        '#336666',
        '#CCCC33',
        '#330066',
        '#993366',
        '#666633',
        '#006633',
        '#33CCCC',
        '#CC3333',
        '#663300',
        '#3333CC',
        '#336666',
        '#33CC33',
        '#000000'];
    var graphCount = 0;
    var addData = function (author, bookInfoList) {
        graph.newNode({label: author});

        $.each(bookInfoList, function (i, b) {
            graph.newNode({label: b.relAuthor});
            graph.newEdge(author, b.relAuthor, {
                label: b.from,
                color: colorSet[graphCount % 23],
                weight: b.from / 20
            });
        });
        graphCount++;

    };

    var nodeCount = 0;
    var addNode = function (author, click) {
//        graph.newNode({
//            label: author,
//            ondoubleclick: doubleclick
//        });

        var nodeList = cy.nodes();
        var hasNode = false;
        for (var iii = 0; iii < nodeList.size(); iii++) {
            if (nodeList[iii].attr().id == author) {
                hasNode = true;
                return;
            }
        }
//        $.each(nodeList, function (i, node) {
//            if (node.attr().id == author) {
//                hasNode = true;
//            }
//        });
        if (!hasNode) {
            nodeCount++;
            var count = nodeCount;
            cy.add({
                "data": {
                    "id": author,
//                        "idInt": 1,
                    "name": author,
//                        "score": 0.006769776522008331,
//                    "query": true,
//                    "gene": true
                    "queried": false
                },
//                    "position": {"x": 481, "y": 384},
                "group": "nodes",
                "removed": false,
                "selected": false,
                "selectable": true,
                "locked": false,
                "grabbed": false,
                "grabbable": true
//                "classes": "hi"
            });

            var curNode = cy.nodes().last();
//            curNode.on('click', function () {
//                curNode.qtip(
//
//                )
//            });
            cy.nodes().last().qtip({
                content: '<div id="show-more-btn-' + count + '" class="show-more-btn">더 보기</div><div id="delete-node-btn-' + count + '" class="delete-node-btn">삭제</div>',
                position: {
                    my: 'left center',
                    at: 'right center'
//                    target:'mouse'
                },
                style: {
                    classes: 'qtip-bootstrap',
                    tip: {
                        width: 16,
                        height: 8
                    }
                }, events: {
                    show: function (event, api) {
                        var $qtip = $(this);
//                        console.error("hi");
                        $('#show-more-btn-' + count).click(click).click(function () {
                            $qtip.qtip('hide');
                        });
                        $('#delete-node-btn-' + count).click(function () {
                            cy.remove(curNode);
                            $.each(cy.nodes(), function (i, n) {
                                if (n.neighborhood().length <= 0) {
                                    cy.remove(n);
                                }
                            });
                            $(this).parent().parent().attr('aria-hidden', 'true');
                            $qtip.qtip('hide');
                        });
                    }
//                    , hide: function (event, api) {
//                        $(this).qtip('destroy');
//                    }
                }
            });

            curNode.on('mouseover', function () {
                this.addClass('hover');
            }).on('mouseout', function () {
                this.removeClass('hover');
            }).addClass('latest');
        }
    };
    var addEdge = function (author, relAuthor, from, click) {
//        $.each(bookInfoList, function (i, b) {
//            graph.newEdge(author, b.relAuthor, {
//                label: b.from,
//                color: colorSet[graphCount % 23],
//                weight: b.from / 20
//            });
//        });
        var edgeList = cy.edges();
        var hasEdge = false;
        for (var iii = 0; iii < edgeList.size(); iii++) {
            var source = edgeList[iii].attr().source;
            var target = edgeList[iii].attr().target;
            if ((source == author && target == relAuthor) || (source == relAuthor && target == author)) {
                hasEdge = true;
                return;
            }
        }
        if (!hasEdge) {
            cy.add({
                group: "edges",
                data: {
                    source: author,
                    target: relAuthor,
                    label: from,
                    weight: parseInt(from) / 10,
                    color: colorSet[graphCount % 23]
                }
            });
            cy.edges().last()
                    .on('click', click)
                    .on('mouseover', function () {
                        this.addClass('hover');
                    })
                    .on('mouseout', function () {
                        this.removeClass('hover');
                    }).addClass('latest');
        }
    };

    $('.close-btn').click(function () {
        $(this).parent().css("visibility", "hidden");
    });
    $('.show-graph-btn').click(function () {
//        $('.cover').css("visibility", "visible");
        $(this).toggleClass('active');
    });

    var layoutOption = {
        name: 'cose',
        animate: true,
        nodeSpacing: 5,
        edgeLengthVal: 45,
        randomize: true,
        idealEdgeLength: 100,
        nodeOverlap: 20,
        maxSimulationTime: 3000,
        stop: function () {
            cy.resize();
            $('.profiling-graph-container').css("visibility", "visible");
        }
    };

    var layout;


    function initCy() {
        $(function () {

            var cy = window.cy = cytoscape({
                container: document.getElementById('profiling-graph'),

                layout: {
                    name: 'cose',
                    animate: true,
                    nodeSpacing: 5,
                    edgeLengthVal: 45,
                    randomize: true,
                    idealEdgeLength: 100,
                    nodeOverlap: 20,
                    maxSimulationTime: 1500,
                    stop: function () {
                        cy.resize();
                        $('.profiling-graph-container').css("visibility", "visible");
                    }
                },

                style: [{
                    "selector": "core",
                    "style": {
                        "selection-box-color": "#f00",
                        "selection-box-border-color": "#f00",
                        "selection-box-opacity": "0.5"
                    }
                }, {
                    "selector": ":active",
                    "style": {
                        "overlay-color": "#f30",
                        "overlay-padding": 10,
                        "overlay-opacity": 0.25
                    }
                }, {
                    "selector": ".hover",
                    "style": {
                        "overlay-color": "#f30",
                        "overlay-padding": 10,
                        "overlay-opacity": 0.25
                    }
                }, {
                    "selector": ".latest.before",
                    "style": {
                        "overlay-color": "#FF6F35",
                        "overlay-padding": 10,
                        "overlay-opacity": 0.25
                    }
                }, {
                    "selector": ".latest.before",
                    "style": {
                        "overlay-color": "#FF6F35",
                        "overlay-padding": 10,
                        "overlay-opacity": 0.25
                    }
                },
                    {
                        "selector": "node",
                        "style": {
                            "width": "mapData(score, 0, 0.006769776522008331, 20, 60)",
                            "height": "mapData(score, 0, 0.006769776522008331, 20, 60)",
                            "content": "data(name)",
                            "font-size": "12px",
                            "text-valign": "center",
                            "text-halign": "center",
                            "background-color": "#555",
                            "text-outline-color": "#555",
                            "text-outline-width": "2px",
                            "color": "#fff",
                            "overlay-padding": "6px",
                            "z-index": "10",
                            "cursor": "pointer"
                        }
                    }, {
                        "selector": "node[?attr]",
                        "style": {
                            "shape": "rectangle",
                            "background-color": "#aaa",
                            "text-outline-color": "#aaa",
                            "width": "16px",
                            "height": "16px",
                            "font-size": "6px",
                            "z-index": "1"
                        }
                    }, {
                        "selector": "node[?query]",
                        "style": {"background-clip": "none", "background-fit": "contain"}
                    }, {
                        "selector": "node:selected",
                        "style": {
                            "border-width": "6px",
                            "border-color": "#AAD8FF",
                            "border-opacity": "0.5",
                            "background-color": "#f00",
                            "text-outline-color": "#77828C"
                        }
                    }, {
                        "selector": "edge",
                        "style": {
                            "curve-style": "haystack",
                            "haystack-radius": "0.5",
                            "opacity": "0.4",
                            "line-color": "data(color)",
                            "width": "mapData(weight, 0, 100, 0, 50)",
                            "overlay-padding": "3px",
                            "label": "data(label)"
                        }
                    }, {"selector": "node.unhighlighted", "style": {"opacity": "0.2"}}, {
                        "selector": "edge.unhighlighted",
                        "style": {"opacity": "0.05"}
                    }, {"selector": ".highlighted", "style": {"z-index": "999999"}}, {
                        "selector": "node.highlighted",
                        "style": {
                            "border-width": "6px",
                            "border-color": "#AAD8FF",
                            "border-opacity": "0.5",
                            "background-color": "#394855",
                            "text-outline-color": "#394855",
                            "shadow-blur": "12px",
                            "shadow-color": "#000",
                            "shadow-opacity": "0.8",
                            "shadow-offset-x": "0px",
                            "shadow-offset-y": "4px"
                        }
                    }, {"selector": "edge.filtered", "style": {"opacity": "0"}}]
            });
        });
    }

    function addGraphData(author, data) {
        var CLASS_NAME_PREFIX = 'expand-table-';
        var tmpTrList = [];
        cy.$('.latest').removeClass('latest');
        $.each(data, function (i, data) {
            addNode(data.relAuthor, function () {
                var tmpAuthor = data.relAuthor;
                var classId = CLASS_NAME_PREFIX + data.to;
                //console.log(classId);
//                var hasChildren = false;
//                $('tr[parent-class-id=' + classId + ']').each(function () {
//                    hasChildren = true;
//                });
//                if (hasChildren) {
//                    alert("중복된 ID 입니다");
//                } else {
//                    console.log(parentContainer);
//                    console.log(opt.parentContainer);
//                    console.log(pContainer);
//                    if (parentContainer != "") return;
//                    parentContainer = opt.parentContainer;

                idCNT++;
                var from = $('#datepicker1').val();
                var to = $('#datepicker2').val();
                if ($('#datepicker1').val() != '') from += " 00:00:00";
                if ($('#datepicker2').val() != '') to += " 23:59:59";

                var period = tmpAuthor + '>' + from + "-" + to + ">" + $('label[name=dateOption]').text() + ">" + $('input[name="groups"]:checked').val();
                callAjax("Cprofile" + idCNT, period, classId, 9, 1, "", "");
//                }
                return false;
            });

//            console.error(author);
            tmpTrList.push(function () {
                idCNT++;
//                var author = author;
//                console.error(author);
                var relAuthor = data.relAuthor;

                var fromTime = $('#datepicker1').val();
                if (fromTime != "") fromTime += " 00:00:00";
                var toTime = $('#datepicker2').val();
                if (toTime != "") toTime += " 23:59:59";


                var period = fromTime + "-" + toTime + ">" + $('label[name=dateOption]').text() + ">" + $('input[name="groups"]:checked').val();

                var id = "profile" + idCNT;
//console.log(">"+ $('input[name="groups"]:checked').val());
                callAjax(id, author + '>' + period, relAuthor, 1, 0, "", "");
            });
        });
//        cy.nodes().layout(layout);
//        cy.layout(layout);

        $.each(data, function (i, data) {
            addEdge(author, data.relAuthor, data.from, tmpTrList[i]);
//                    cy.layout(layout);
        });

//        layout.run();
        cy.layout(layoutOption);
        graphCount++;
    }

</script>
</body>
</html>