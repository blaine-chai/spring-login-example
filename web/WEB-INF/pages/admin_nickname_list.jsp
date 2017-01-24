<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Server Admin - 그룹 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <link href="/css/styles.css" rel="stylesheet">
    <style type="text/css">
        #group-list-table td {
            vertical-align: middle;
        }

        table td.shrink {
            white-space: nowrap
        }

        .table-container {
            position: relative;
        }
    </style>
    <style>
        form {
            /*margin: 5px;*/
            display: inline-block
        }
    </style>
</head>

<body>
<div id="top-nav" class="navbar navbar-inverse navbar-static-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/admin/main">사용자 관리</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/"><i class="glyphicon glyphicon-home"></i> home</a></li>
                <li class="dropdown">
                    <a href="#"><i class="glyphicon glyphicon-user"></i> ${userId}</a>
                </li>
                <li><a href="/admin/logout"><i class="glyphicon glyphicon-lock"></i> Logout</a></li>
            </ul>
        </div>
    </div>
    <!-- /container -->
</div>
<!-- /Header -->

<!-- Main -->
<div class="container-fluid" style="height: calc(100% - 100px);">
    <div class="row" style="height: 100%">
        <div class="col-sm-3">

            <ul class="nav nav-stacked">
                <li class="nav-header"><a href="#" data-target="#user-menu">메뉴 <i
                        class="glyphicon glyphicon-chevron-down"></i></a>
                    <ul class="nav nav-stacked collapse in" id="user-menu">
                        <%--<li><a href="#" content="/admin/admin-account" onclick="setIframe(this);return false;"><i--%>
                        <li><a href="/admin/admin-account" content="/admin/admin-account"><i
                                class="glyphicon glyphicon-user"></i> Admin
                            List</a></li>
                        <%--<li><a href="#" content="/admin/user" onclick="setIframe(this);return false;"><i--%>
                        <li><a href="/admin/user" content="/admin/user"><i
                                class="glyphicon glyphicon-user"></i> User List</a>
                        </li>
                        <li><a href="/admin/group-name" content="/admin/group-name"><i
                                class="glyphicon glyphicon-user"></i> Group List</a>
                        </li>
                        <li><a href="/admin/test" content="/admin/test"><i
                                class="glyphicon glyphicon-chevron-right"></i> Nickname Test</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="col-sm-9" style="height:100%;">
            <div class="" style="position: relative;">
                <%--<button class="btn btn-primary" style="right: 5px;position: absolute;"--%>
                <%--onclick="refreshGroup();return false;">그룹 새로고침--%>
                <%--</button>--%>
                <h2>Nickname Test</h2>
                <div style="border: 2px solid #ddd;padding-bottom: 20px;position: relative;">
                    <div style="padding: 20px 0 0 20px;">
                        <input type="text" class="author-count count" placeholder="생성할 닉네임 개수를 입력하세요."
                               style="font-size: 12px;height: 30px;width: 200px;padding-left: 10px;">
                    </div>
                    <div style="padding: 5px 0 0 20px;">
                        <input type="text" class="string-count count" placeholder="생성할 닉네임 글자수를 입력하세요."
                               style="font-size: 12px;height: 30px;width: 200px;padding-left: 10px;">
                    </div>
                    <div style="padding: 5px 0 0 20px;">
                        <button class="btn btn-sm btn-default btn-add-nick" style="width: 80px;">닉네임 추가</button>
                        <button class="btn btn-sm btn-default btn-view-all-nick" style="padding-left: 10px;">닉네임 정보 보기
                        </button>
                        <div style="position: absolute;top: 20px;right: 20px;">
                            <button class="btn btn-sm btn-default btn-view-all-nick">
                                <%--style="position: absolute;right: 510px;">--%>
                                view
                            </button>
                            <button class="btn btn-sm btn-default btn-import-all-nick">
                                <%--style="position: absolute;right: 440px;">--%>
                                import
                            </button>
                            <button class="btn btn-sm btn-default btn-export-all-nick">
                                <%--style="position: absolute;right: 370px;">--%>
                                export
                            </button>
                            <button class="btn btn-sm btn-default btn-delete-all-nick">
                                <%--style="position: absolute;right: 300px;">--%>
                                delete
                            </button>
                        </div>
                    </div>

                    <div style="padding: 20px 0 0 20px;">
                        <input type="text" class="search-data-count count" placeholder="검색 데이터 개수를 입력하세요."
                               style="font-size: 12px;height: 30px;width: 200px;padding-left: 10px;">
                        <button class="btn btn-sm btn-default btn-search-test" style="padding-left: 10px;">닉네임 검색 시간 비교
                        </button>
                    </div>
                </div>
                <div class="result-data" style="padding-top: 50px;">
                    <%--<div class="table-responsive">--%>
                    <%--<table class="table table-condensed table-hover group-list-table" id="group-list-table">--%>
                    <%--<thead>--%>
                    <%--<tr>--%>
                    <%--<th width="80%" class="text-center">그룹 이름</th>--%>
                    <%--<th width="80%" class="text-center">그룹 아이디</th>--%>
                    <%--<th class="text-center shrink" style="width: 100px;">--%>
                    <%--&lt;%&ndash;<button class="btn btn-primary" style="width: 100px;"&ndash;%&gt;--%>
                    <%--&lt;%&ndash;onclick="joinGroupClickHandler(this);return false;">생성&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</button>&ndash;%&gt;--%>
                    <%--</th>--%>
                    <%--</tr>--%>
                    <%--</thead>--%>
                    <%--<tbody>--%>
                    <%--</tbody>--%>
                    <%--</table>--%>
                    <%--</div>--%>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('.btn-add-nick').click(function () {
        var authorCount = $('.author-count').val();
        var stringCount = $('.string-count').val();

//        console.log(Math.log(parseInt(authorCount))/Math.log(10));

        if (Math.log(parseInt(authorCount)) / Math.log(10) > parseInt(stringCount)) {
            alert('글자수가 더 커야합니다.');
            return false;
        }

        $.ajax({
            url: '/admin/test/nickname/add',
            type: 'post',
            data: {
                "author-count": authorCount,
                "string-count": stringCount
            },
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
//                $('.result-data').text(responseData);
                setResultNicknameTable(JSON.parse(responseData));
            }
        })
    });

    $('.btn-import-all-nick').click(function () {
        $.ajax({
            url: '/admin/test/nickname/import',
            type: 'post',
            data: {},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
//                $('.result-data').text(responseData);
                setResultNicknameTable(JSON.parse(responseData));
            }
        })
    });
    $('.btn-export-all-nick').click(function () {
        $.ajax({
            url: '/admin/test/nickname/export',
            type: 'post',
            data: {},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
                $('.result-data').text(responseData);
            }
        })
    });

    $('.btn-delete-all-nick').click(function () {
        $.ajax({
            url: '/admin/test/nickname/delete',
            type: 'post',
            data: {},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
//                $('.result-data').text(responseData);
                setResultNicknameTable(JSON.parse(responseData));
            }
        })
    });

    $('.btn-view-all-nick').click(function () {
        $.ajax({
            url: '/admin/test/nickname/view',
            type: 'post',
            data: {},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
//                $('.result-data').text(responseData);
                setResultNicknameTable(JSON.parse(responseData));
            }
        })
    });

    $('.btn-search-test').click(function () {
        $.ajax({
            url: '/admin/test/search',
            type: 'post',
            data: {
                'search-data-count': $('.search-data-count').val()
            },
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
                $('.result-data').html(responseData);
            }
        })
    });

    jQuery('.count').keyup(function () {
        $(this).val($(this).val().replace(/[^0-9\.]/g, ''));
    });

    //    jQuery('.string-count').keyup(function () {
    //        $(this).val($(this).val().replace(/[^0-9\.]/g, ''));
    //    });

    var setResultNicknameTable = function (data) {
        $('.result-data').empty();
        var html = $('<div class="table-responsive">' +
                '<table class="table table-condensed table-hover">' +
                '<thead>' +
                '<tr>' +
                //'<th class="text-center">id</th>' +
                '<th class="text-center">저자명</th>' +
                '<th class="text-center">별명</th>' +
                '<th class="text-center">수정일자</th>' +
                '<th class="text-center">우선순위</th>' +
                '<th class="text-center">메모</th>' +
                '</tr>' +
                '</thead>' +
                '<tbody>' +
                '</tbody>' +
                '</table></div>');
        var $tbody = html.find('tbody');
        $.each(data, function (i, d) {
            var tmpEl = $('<tr>' +
                    //'<td class="text-center">' + d.id + '</td>' +
                    '<td class="text-center">' + d.author + '</td>' +
                    '<td class="text-center">' + d.nickname + '</td>' +
                    '<td class="text-center">' + d.lastModifiedDate + '</td>' +
                    '<td class="text-center">' + d.priority + '</td>' +
                    '<td class="text-center">' + d.note + '</td>' +
                    '</tr>');
            $tbody.append(tmpEl);
        });
        $('.result-data').append(html);
    };

</script>
</body>