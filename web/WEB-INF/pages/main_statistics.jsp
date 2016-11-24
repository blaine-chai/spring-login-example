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
    <script src="/js/d3.v3.min.js"></script>
    <script src="/js/randomColor.js"></script>

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
                <div class="glyphicon glyphicon-bell"></div>
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

<div id="content" class="col-xs-12" style="background: #efefef;">
    <div id="content-wrapper" style="margin-top: 15px; height: 100%;">
        <%--<div id="total-graph-container" class="col-md-6" style="margin-top: 15px; height: 100%;">--%>
        <div id="total-graph-group" class="col-xs-5" style="height: 100%;">
            <div class="panel panel-default"
                 style="position: relative;height: calc(50% - 68px);background: #f8f8f8;margin: 30px;margin-bottom: 46px;">
                <div class="panel panel-default"
                     style="position: relative;height: 50px;margin-bottom: 0;margin-left: 20px;margin-right: 20px;margin-top: 20px;">
                    <div class="graph-title-text"
                         style="height: 50px;line-height: 50px;vertical-align: middle;margin-left: 20px;">events
                    </div>
                    <div class="btn-group" style="position:absolute;right:10px;bottom:10px;">
                        <button type="button" class="btn btn-default btn-sm dropdown-toggle total-book-dropdown"
                                data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false" style="width: 60px">
                            <span class="search-category-option">월별</span>
                            <div style="display: inline-block"><span class="caret"></span><span
                                    class="sr-only"></span>
                            </div>
                        </button>
                        <ul class="dropdown-menu search-category-selector">
                            <li><a role="total-book-dropdown" onclick="getSearchTotalData(this);return false;"
                                   period="0" href="#">일별</a></li>
                            <li><a role="total-book-dropdown" onclick="getSearchTotalData(this);return false;"
                                   period="1" tabindex="-1" href="#">주별</a></li>
                            <li><a role="total-book-dropdown" onclick="getSearchTotalData(this);return false;"
                                   period="2" tabindex="-1" href="#">월별</a></li>
                            <li><a role="total-book-dropdown" onclick="getSearchTotalData(this);return false;"
                                   period="3" tabindex="-1" href="#">년도별</a></li>
                        </ul>
                    </div>
                </div>
                <div id="total-book-graph-container" class="panel panel-default"
                     style="margin-top: 20px;width: calc(100% - 40px);height: calc(100% - 111px);margin-left: 20px;margin-right: 20px;margin-bottom: 20px;position:relative;">
                </div>
            </div>
            <div class="panel panel-default"
                 style="position: relative;height: calc(50% - 68px);background: #f8f8f8;margin: 30px;">
                <div class="panel panel-default"
                     style="position: relative;height: 50px;margin-bottom: 0;margin-left: 20px;margin-right: 20px;margin-top: 20px;">
                    <div class="graph-title-text"
                         style="height: 50px;line-height: 50px;vertical-align: middle;margin-left: 20px;">events
                    </div>
                    <div class="btn-group" style="position:absolute;right:10px;bottom:10px;">
                        <button type="button" class="btn btn-default btn-sm dropdown-toggle total-author-dropdown"
                                data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false" style="width: 60px">
                            <span class="search-category-option">월별</span>
                            <div style="display: inline-block"><span class="caret"></span><span
                                    class="sr-only"></span>
                            </div>
                        </button>
                        <ul class="dropdown-menu search-category-selector" role="menu"
                            aria-labelledby="dropdownMenu1">
                            <li><a role="total-author-dropdown" onclick="getAuthorTotalGraphData(this);return false;"
                                   period="0" tabindex="-1" href="#">일별</a></li>
                            <li><a role="total-author-dropdown" onclick="getAuthorTotalGraphData(this);return false;"
                                   period="1" tabindex="-1" href="#">주별</a></li>
                            <li><a role="total-author-dropdown" onclick="getAuthorTotalGraphData(this);return false;"
                                   period="2" tabindex="-1" href="#">월별</a></li>
                            <li><a role="total-author-dropdown" onclick="getAuthorTotalGraphData(this);return false;"
                                   period="3" tabindex="-1" href="#">년도별</a></li>
                        </ul>
                    </div>
                </div>
                <div id="total-author-graph-container" class="panel panel-default"
                     style="margin-top: 20px;width: calc(100% - 40px);height: calc(100% - 111px);margin-left: 20px;margin-right: 20px;margin-bottom: 20px;position:relative;">
                </div>
            </div>
        </div>
        <div class="col-xs-7" style="height: 100%;padding: 30px;padding-left: 0px;">
            <div id="author-component-container" class="panel panel-default"
                 style="float: left; width:100%;height: calc(100% - 30px);position: relative;background: #f8f8f8;">
                <div style="width: calc(100% - 40px);margin-top: 20px;padding: 20px;margin-left: 20px;margin-bottom: 20px;position: relative;height: 140px;"
                     class="panel panel-default">
                    <div id="statistic-author-input-container">
                        <div class="input-group input-group-sm" style="width: 300px;margin-bottom: 10px;">
                            <input id="author-search-input" type="text" class="form-control" placeholder="검색어를 입력해주세요."
                            <%--onkeypress="if(event.keyCode==13) {$('#nickname-search-btn').click(); return false;}">--%>
                            >
                            <div class="input-group-btn"><label style="width:55px;" id="author-graph-add-btn"
                                                                class="btn btn-default">추가</label>
                                <label style="width:55px;" id="author-graph-new-btn"
                                       class="btn btn-default btn-primary">신규</label></div>
                        </div>
                        <div class="btn-group" style="height: 25px;position: absolute;bottom: 20px;right: 23px;">
                            <button type="button" class="btn btn-default btn-sm dropdown-toggle author-dropdown"
                                    data-toggle="dropdown" aria-haspopup="true"
                                    aria-expanded="false" style="width: 60px">
                                <span class="search-category-option">월별</span>
                                <div style="display: inline-block"><span class="caret"></span><span
                                        class="sr-only"></span>
                                </div>
                            </button>
                            <ul class="dropdown-menu search-category-selector" role="menu"
                                aria-labelledby="dropdownMenu1">
                                <li><a role="author-dropdown" period="0"
                                       onclick="getAuthorGraphDataByPeriod(this);return false;" tabindex="-1" href="#">일별</a>
                                </li>
                                <li><a role="author-dropdown" period="1"
                                       onclick="getAuthorGraphDataByPeriod(this);return false;" tabindex="-1" href="#">주별</a>
                                </li>
                                <li><a role="author-dropdown" period="2"
                                       onclick="getAuthorGraphDataByPeriod(this);return false;" tabindex="-1" href="#">월별</a>
                                </li>
                                <li><a role="author-dropdown" period="3"
                                       onclick="getAuthorGraphDataByPeriod(this);return false;" tabindex="-1" href="#">년도별</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="author-datepicker-container" style="height: 25px;margin-top: 10px;">
                        <div style="float:left; margin:0 auto;"><span class="glyphicon glyphicon-calendar"
                                                                      style="left:2px; top:5px; width:20px;"></span>
                        </div>
                        <div class="" style="padding: 0;  margin:0 auto;"><input id="datepicker1"
                                                                                 data-provide="datepicker"
                                                                                 style="width: 123px; text-align:center; font-size:12px; float:left;">
                        </div>
                        <div class="" style="float:left; width: 20px; font-size:11px;text-align: center; padding:0;">~
                        </div>
                        <div class="" style="padding:0;  margin:0 auto;"><input id="datepicker2"
                                                                                data-provide="datepicker"
                                                                                style="width: 123px; text-align:center; font-size:12px; float:left;">
                        </div>
                    </div>
                </div>

                <div id="author-graph-container" class="panel panel-default"
                     style="margin-top: 10px;height: calc(100% - 210px);float: left;width: calc(100% - 40px);background: #fff;margin-left: 20px;margin-right: 20px; position:relative;">

                    <%--<div id="author-graph-container" class="col-md-6" style="margin-top: 15px; height: 100%;">--%>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/js/line-graph.js"></script>

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


    $(document).ready(function () {
        authorTotalGraph = GraphModule.graph();
        totalGraph = GraphModule.graph();
        getSearchTotalData();
        getAuthorTotalGraphData();

        $('.graph-overall').draggable({
            containment: '#author-graph-container'
        });

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


        $('#author-graph-add-btn').click(function (e) {
            authorGraph.removeSvg();
            addAuthorGraphData();
        });
        $('#author-graph-new-btn').click(function (e) {
            if (authorGraph != undefined) {
                authorGraph.removeNameList();
                authorGraph.removeData();
                authorGraph.removeSvg();
            }
            getNewAuthorGraphData();
        });

        $('#datepicker1').datetimepicker({
            format: 'YYYY/MM/DD HH:mm:a'
        });
        $('#datepicker2').datetimepicker({
            format: 'YYYY/MM/DD HH:mm:a'
        });
    });


    var getNewAuthorGraphData = (function () {
        var authorList = [];
        authorList.push($('#author-search-input').val());
        $.ajax({
            url: "/main/statistics/search-author-data",
            type: "post",
            data: {
                author: JSON.stringify(authorList),
                searchPeriod: timePeriodOption.monthly
            },
            success: function (responseData) {
                var resultData = JSON.parse(responseData);
//                console.error(resultData);
                authorGraph = GraphModule.graph();
                authorGraph.setMargin({top: 70, right: 60, bottom: 80, left: 60});
                authorGraph.setGraphContainer('#author-graph-container');
                authorGraph.removeNameList();
                authorGraph.removeData();
                $.each(authorList, function (i, author) {
                    authorGraph.addNameList(author);
                });
                authorGraph.setData(resultData);
                authorGraph.init();
            }
        })
    });


    var getAuthorGraphDataByPeriod = (function (element) {
        var authorList = authorGraph.getNameList();
//        console.error(authorList[0]);
        $.ajax({
            url: "/main/statistics/search-author-data",
            type: "post",
            data: {
                author: JSON.stringify(authorList),
                searchPeriod: $(element).attr('period')
            },
            success: function (responseData) {
                var resultData = JSON.parse(responseData);
//                console.error(resultData);
                authorGraph.setMargin({top: 70, right: 60, bottom: 80, left: 60});
                authorGraph.setGraphContainer('#author-graph-container');
                authorGraph.setOption({timePeriod: parseInt($(element).attr('period'))});
                authorGraph.removeSvg();
                authorGraph.removeData();
                authorGraph.setData(resultData);
                authorGraph.init();
            }
        })
    });

    var addAuthorGraphData = (function () {
        var author = [];
        author.push($('#author-search-input').val());
//        console.error(authorGraph.getOption().timePeriod);
        $.ajax({
            url: "/main/statistics/search-author-data",
            type: "post",
            data: {
                author: JSON.stringify(author),
                searchPeriod: authorGraph.getOption().timePeriod
            },
            success: function (responseData) {
                var resultData = JSON.parse(responseData);
                authorGraph.removeSvg();
                authorGraph.setGraphContainer('#author-graph-container');
                authorGraph.setMargin({top: 70, right: 60, bottom: 80, left: 60});
                authorGraph.addNameList($('#author-search-input').val());
                authorGraph.addData(author[0], resultData);
                authorGraph.refresh();
            }
        })
    });

    var getAuthorTotalGraphData = (function (element) {
        var timePeriod;
        if (element == undefined) {
            timePeriod = timePeriodOption.monthly;
        } else {
            timePeriod = $(element).attr('period');
        }
        $.ajax({
            url: "/main/statistics/search-author-total-data",
            type: "post",
            data: {
//                author: author,
                searchPeriod: timePeriod
            },
            success: function (responseData) {
                var resultData = JSON.parse(responseData);
//                console.error(resultData);
                authorTotalGraph.setGraphContainer('#total-author-graph-container');
                authorTotalGraph.setOption({timePeriod: parseInt(timePeriod)});
                authorTotalGraph.removeSvg();
                authorTotalGraph.removeData();
                authorTotalGraph.addNameList('total');
                authorTotalGraph.setData(resultData);
                authorTotalGraph.init();
            }
        })
    });

    var getSearchTotalData = (function (element) {
        var timePeriod;
        if (element == undefined) {
            timePeriod = timePeriodOption.monthly;
        } else {
            timePeriod = $(element).attr('period');
        }
//        console.error(timePeriod);

        $.ajax({
            url: "/main/statistics/search-total-data",
            type: "post",
            data: {
                "searchPeriod": timePeriod
            },
            success: function (responseData) {
                var resultData = JSON.parse(responseData);
//                console.error(resultData);

                totalGraph.setGraphContainer('#total-book-graph-container');
                totalGraph.setOption({timePeriod: parseInt(timePeriod)});
                totalGraph.removeSvg();
                totalGraph.removeData();
                totalGraph.addNameList('total');
                totalGraph.setData(resultData);
                totalGraph.init();
            }
        });
    });

    function handleOperatorSelect() {
        $('.search-category-selector li a').click(function (e) {
            $($(this).parent().parent().parent()).find('button span').eq(0).text($(this).text());
        });
    }
</script>
</body>
</html>