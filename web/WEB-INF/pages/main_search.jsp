<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title>REMOS</title>
    <script
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!-- 부가적인 테마 -->

    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script
            src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <style type="text/css">
        /*@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);*/
    </style>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet"
          href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.0/bootstrap-table.min.css">

    <link href="/css/main-style.css" rel="stylesheet" type="text/css">
    <link href="/css/datepicker.css" rel="stylesheet" type="text/css">
    <link href="/css/bootstrap-select.css" rel="stylesheet" type="text/css">


    <!-- Latest compiled and minified JavaScript -->
    <script
            src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.0/bootstrap-table.min.js"></script>

    <!-- Latest compiled and minified Locales -->

    <script src="/js/colResizable-1.6.js"></script>
    <script src="/js/moment.js"></script>
    <script src="/js/transition.js"></script>
    <script src="/js/bootstrap-datepicker.js"></script>
    <%--<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>

</head>
<body>
<div id="header-wrapper"
     style="align-content: center; text-align: center"><h1
        style="margin: 0 auto; padding: 20px 0 20px 0">Real-Time
    Monitoring System(REMOS)</h1></div>
<div id="nav-wrapper">
    <div id="nav"><a href="/main">
        <div class="header-button btn active">
            <div class="glyphicon glyphicon-bell"
                 style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
            <div>알림</div>
        </div>
    </a> <a href="/main/status">
        <div class="header-button btn">
            <div class="glyphicon glyphicon-off"
                 style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
            <div>시스템 상태</div>
        </div>
    </a> <a href="/main/profile">
        <div class="header-button btn">
            <div class="glyphicon glyphicon-list-alt"
                 style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
            <div>프로파일링</div>
        </div>
    </a> <a href="/main/statistics">
        <div class="header-button btn">
            <div class="glyphicon glyphicon-signal"
                 style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
            <div>통계</div>
        </div>
    </a> <a href="#">
        <div class="header-button btn">
            <div class="glyphicon glyphicon-search"
                 style="text-align: center; font-size: 27px; padding-top: 10px;"></div>
            <div>검색</div>
        </div>
    </a></div>
</div>

<div id="content" style="">
    <div id="content-wrapper">
        <div id="search" class="col-xs-4"
             style="width: 333px;min-width:333px; max-width:333px; background: rgba(239, 239, 239, 1); overflow: scroll;">
            <div id="search-wrapper" style="width:100%;">
                <div id="search-option-radio-wrapper" class="btn-group btn-group-justified" data-toggle="buttons">
                    <label class="btn btn-default btn-sm active">
                        <input type="radio" name="options" id="option1" autocomplete="off" checked>문자 포함</label>
                    <label class="btn btn-default btn-sm">
                        <input type="radio" name="options" id="option2" autocomplete="off">형태소</label>
                    <label class="btn  btn-default btn-sm">
                        <input type="radio" name="options" id="option3" autocomplete="off">문자</label>
                </div>
                <div id="search-input-wrapper" class="">
                    <div class="input-group input-group-sm">
                        <div class="dropdown input-group-btn">
                            <div class="btn-group" style="">
                                <button type="button" class="btn btn-default btn-sm dropdown-toggle"
                                        data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false" style="width: 72px">
                                    <span>저자</span>
                                    <div style="display: inline-block"><span class="caret"></span><span
                                            class="sr-only"></span>
                                    </div>
                                </button>
                                <ul class="dropdown-menu search-content-selector" role="menu"
                                    aria-labelledby="dropdownMenu1">
                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">저자</a></li>
                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">내용</a></li>
                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">참조</a></li>
                                </ul>
                            </div>
                        </div>
                        <input type="text" class="form-control col-xs-4" placeholder="검색어를 입력해주세요.">
                        <div class="dropdown input-group-btn">
                            <div class="btn-group">
                                <button type="button" class="btn btn-default btn-sm dropdown-toggle"
                                        data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false" style="width: 55px"><span>SEL</span>
                                    <div style="display: inline-block"><span class="caret"></span><span
                                            class="sr-only"></span></div>
                                </button>
                                <ul id="" class="dropdown-menu operator-selector" role="menu"
                                    aria-labelledby="dropdownMenu1">
                                    <li role="presentation"><a role="menuitem" tabindex="1" href="#"
                                                               onclick="handleOperatorSelect(this);return false;">SEL</a>
                                    </li>
                                    <li role="presentation"><a role="menuitem" tabindex="2" href="#"
                                                               onclick="handleOperatorSelect(this);return false;">AND</a>
                                    </li>
                                    <li role="presentation"><a role="menuitem" tabindex="3" href="#"
                                                               onclick="handleOperatorSelect(this);return false;">O
                                        R</a>
                                    </li>
                                </ul>
                            </div>
                            <label class="btn btn-default btn-sm close-search-option-btn"
                                   style="visibility: hidden">-</label>
                        </div>
                    </div>
                </div>
                <div style="margin-top: 5px">
                    <div class="col-xs-2"><span class="glyphicon glyphicon-calendar" style="top:5px;"></span></div>
                    <div class="col-xs-4" style="padding: 0;"><input id="datepicker1" data-provide="datepicker"
                                                                     style="width: 100%"></div>
                    <div class="col-xs-2">~</div>
                    <div class="col-xs-4" style="padding:0;"><input id="datepicker2" data-provide="datepicker"
                                                                    style="width: 100%"></div>
                </div>

                <div class="btn-group btn-group-justified" style="padding-top: 5px">
                    <label class="btn btn-default btn-sm btn-primary">검색</label>
                </div>

                <div class="btn-group" style="padding-top: 20px; width: 100%;">
                    <label class="btn btn-default btn-sm extend-btn btn-primary" style="width: 29px;">+</label>
                    <label class="btn btn-default btn-sm" style="width:calc(100% - 29px);">연관 문자</label>
                </div>

                <div class="btn-group" style="padding-top: 5px; width: 100%">
                    <label class="btn btn-default btn-sm extend-btn btn-primary" style="width: 29px;">+</label>
                    <label class="btn btn-default btn-sm" style="width:calc(100% - 29px);">Admin History</label>
                </div>

                <div class="btn-group" style="padding-top: 5px; width: 100%">
                    <label class="btn btn-default btn-sm extend-btn btn-primary" style="width: 29px;">+</label>
                    <label class="btn btn-default btn-sm" style="width:calc(100% - 29px);">User History</label>
                </div>
            </div>
        </div>


        <div id="menu" class="col-xs-8" style="width: calc(100% - 333px)">
            <div id="relative-table-container" style="position: absolute; z-index: 10;"></div>
            <div id="menu-wrapper" style="background: rgba(224, 234, 244, 1);">
                <div class="alert alert-success">총 1000건의 검색 결과가 있습니다</div>
                <div></div>
                <div id="result-table-wrapper" class="panel panel-default"
                     style="margin: 15px; overflow: scroll; height: calc(100% - 200px); font-size: 11px">
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
                <div>
                    <nav aria-label="..." style="text-align: center;">
                        <ul class="pagination pagination-sm" style="margin: 0 auto;">
                            <li><a href="#" aria-label="Previous" class="disabled"><span
                                    aria-hidden="true">«</span></a></li>
                            <li><a href="#" class="active">1</a></li>
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

<script type="text/javascript">
    //    for (i = 0; i < 55; i++) {
    //        $('#book-table tbody').append('<tr><td>' + i + '</td><td>file/path/file' + i + '.txt</td><td>1990-02-17</td><td>1990-02-17</td><td>1990-02-17</td><td>비고</td><td>비고</td><td><span class="glyphicon glyphicon-ok"></span></td><td><span class="glyphicon glyphicon-ok"></span></td><td>비고</td><td>비고</td><td>비고</td></tr>'
    //        )
    //    }
    function newRelativeTable(el) {

    }

    function handleOperatorSelect(element) {
        var list = $(element).parent().parent().parent().parent().parent();
        if ($('#search-input-wrapper>div').length - 1 == $('#search-input-wrapper>div').index(list) && $(element).text() != "none") {
            $('#search-input-wrapper').append('<div class="input-group input-group-sm"><div class="dropdown input-group-btn"><div class="btn-group"><button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 72px"><span>저자</span><div style="display: inline-block"><span class="caret"></span><span class="sr-only"></span></div></button><ul class="dropdown-menu search-content-selector" role="menu" aria-labelledby="dropdownMenu1"><li role="presentation"><a role="menuitem" tabindex="-1" href="#">저자</a></li><li role="presentation"><a role="menuitem" tabindex="-1" href="#">내용</a></li><li role="presentation"><a role="menuitem" tabindex="-1" href="#">저자</a></li></ul></div></div><input type="text" class="form-control col-xs-4" placeholder="검색어를 입력해주세요."><div class="dropdown input-group-btn"><div class="btn-group"><button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 55px"><span>SEL</span><div style="display: inline-block"><span class="caret"></span><span class="sr-only"></span></div></button><ul id="operator-selector" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1"><li role="presentation"><a role="menuitem" tabindex="1" href="#">SEL</a></li><li role="presentation"><a role="menuitem" tabindex="2" href="#" onclick="handleOperatorSelect(this);return false;">AND</a></li><li role="presentation"><a role="menuitem" tabindex="3" href="#" onclick="handleOperatorSelect(this);return false;">O R</a></li></ul></div><label class="btn btn-default btn-sm close-search-option-btn">-</label></div></div>');
            $('.close-search-option-btn').click(function (e) {
                this.parentElement.parentElement.remove();
            });

            $('.search-content-selector li a').click(function (e) {
                $($(this).parent().parent().parent()).find('button span').eq(0).text($(this).text());
            });
            $('.operator-selector li a').click(function (e) {
                $($(this).parent().parent().parent()).find('button span').eq(0).text($(this).text());
            });
        }
        $($(element).parent().parent().parent()).find('button span').eq(0).text($(element).text());
    }

    $(document).ready(function () {
        $(window).resize(
                function () {
                    //            $('#content').height($(window).height());
                    $('#search-wrapper').height(
                            $(window).height() - 210);
                    //            console($(document).width() + 'px');
                    $('#menu-wrapper').height(
                            $(window).height() - 210);
                    //            $('#book-table').attr('data-height', $(window).height() - 194 - 200)
                    //            $('#book-table').height($(window).height() - 194 - 200)
                    $('#result-table-wrapper').height(
                            $(window).height() - 210 - 150);

                });
        $('#search-wrapper').height($(window).height() - 210);
        $('#menu-wrapper').height($(window).height() - 210);
        //        $('#book-table').height($(window).height() - 194 - 200)
        $('#result-table-wrapper').height(
                $(window).height() - 210 - 150);
        //        $('#book-table').width($('#result-table-wrapper').width());

        $('#book-table').colResizable({
            resizeMode: 'flex'
        });

        $('#result-table-wrapper').scroll(function () {
            $('#book-table-header').css("top",
                    252 - $('#book-table').offset().top);
        });

        $('#datepicker1').datepicker({});
        $('#datepicker2').datepicker({});

        $('#add-search-input-btn').click(function (e) {
            $('#search-input-wrapper').append('<div class="input-group input-group-sm"><input type="text"class="form-control" placeholder="검색어를 입력해주세요."><div class="dropdown input-group-btn"><div class="btn-group"><button type="button" class="btn btn-default btn-sm dropdown-toggle"data-toggle="dropdown" aria-haspopup="true"aria-expanded="false">and<span class="caret"></span><span class="sr-only"></span></button><ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1"><li role="presentation"><a role="menuitem" tabindex="-1" href="#">and</a></li><li role="presentation"><a role="menuitem" tabindex="-1" href="#">or</a></li><li role="presentation"><a role="menuitem" tabindex="-1" href="#">and not</a></li></ul></div><label class="btn btn-default btn-sm close-search-option-btn">-</label></div></div>');
            $('.close-search-option-btn').click(function (e, i) {
                this.parentElement.parentElement.remove();
            })
        });

        $('.close-search-option-btn').click(function (e, i) {
            this.parentElement.parentElement.remove();
        })
        $('.extend-btn').click(function (e, i) {
            if ($(this).text() == "+") {
                var new_div = $('<div class="panel" style="display:block;overflow: scroll; max-height:300px;"><table style="font-size:11px;max-height: 300px; overflow: scroll" class="table table-fixed table-bordered table-striped table-condensed"><tbody><tr><td>인천</td></tr><tr><td>서울</td></tr><tr><td>부산</td></tr><tr><td>공학</td></tr><tr><td>학교</td></tr><tr><td>분자</td></tr><tr><td>인천</td></tr><tr><td>서울</td></tr><tr><td>부산</td></tr><tr><td>공학</td></tr><tr><td>학교</td></tr><tr><td>분자</td></tr></tbody></table></div>').hide();
                $(this).parent().append(new_div);
                new_div.show(300);
                $(this).text("-");
            } else {
                $(this).text("+");
                $(this).parent().find('div').hide(300, function () {
                    $(this).parent().find('div').remove();
                });
            }
        });

        $('.search-content-selector li a').click(function (e) {
            $($(this).parent().parent().parent()).find('button span').eq(0).text($(this).text());
        });

//        $('#book-table tr').click(function (e) {
//            var newDiv = '<div class="related-table-wrapper panel panel-default"><div>' + $(this).find('td').eq(0).text() + $(this).find('td').eq(1).text() + ' ' + $(this).find('td').eq(4).text() + '-' + $(this).find('td').eq(5).text() + '<label class="btn btn-default close" aria-label="Close"><span aria-hidden="true">&times;</span></label></div>' +
//                    '<div style="overflow: scroll; width:500px;max-height:500px;">' +
//                    '<table class="table table-bordered table-striped table-condensed" style="font-size:10px;">' +
//                    '<thead><tr><th>번호</th><th>발행일자</th><th>R</th><th>E</th></tr></thead>' +
//                    '<tbody>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '<tr><td>1</td><td>2014-04-07</td><td>check</td><td></td></tr>' +
//                    '</tbody>' +
//                    '</table></div></div>';
//            $('.related-table-wrapper').remove();
//            $('.related-table-wrapper .close span').click(function (e) {
//                $('.related-table-wrapper').remove();
//            });
//            $('#relative-table-container').append(newDiv);
//            $('.related-table-wrapper').draggable();
//            console.error(this);
//        })

    });
</script>
</body>
</html>