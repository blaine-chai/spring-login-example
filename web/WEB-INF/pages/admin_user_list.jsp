<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Server Admin - 사용자 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <link href="/css/styles.css" rel="stylesheet">
    <style type="text/css">
        .list-table td {
            vertical-align: middle !important;
        }

        table td.shrink {
            white-space: nowrap
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
        <%--<div class="navbar-collapse collapse">--%>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/"><i class="glyphicon glyphicon-home"></i> home</a></li>
                <li class="dropdown">
                    <a href="#"><i class="glyphicon glyphicon-user"></i> ${userId}</a>
                </li>
                <li><a href="/admin/logout"><i class="glyphicon glyphicon-lock"></i> Logout</a></li>
            </ul>
        <%--</div>--%>
    </div>
    <!-- /container -->
</div>
<!-- /Header -->

<!-- Main -->
<div class="container-fluid" style="height: calc(100% - 100px);">
    <div class="row" style="height: 100%">
        <div class="col-sm-3">

            <ul class="nav nav-stacked">
                <li class="nav-header"><a href="#"  data-target="#user-menu">메뉴 <i
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
                    </ul>
                </li>
            </ul>
        </div>
        <div class="col-sm-9" style="height:100%;">
            <div class="">
                <h2>User List</h2>
                <!-- Search Bar -->
                <div class="panel panel-info">
                    <div class="panel-heading">Search</div>
                    <div class="panel-body">
                        <%--<form action="/admin/admin-account/search" method="post" class="form-inline" role="form">--%>
                        <div class="input-group" style="width: 100%;">
                            <select name="searchFilter" class="form-control"
                                    style="width: 140px; border-top-right-radius: 0;border-bottom-right-radius: 0;">
                                <option value="userId">사용자 계정</option>
                                <option value="username">사용자 이름</option>
                                <%--<option value="password">비밀번호</option>--%>
                                <%--<option value="date">생성일</option>--%>
                            </select>
                            <input class="form-control" style="width:180px; border-radius: 4px;"
                                   name="searchInput"
                                   type="text">
                            <%--<div class="btn-group btn-group-justified" style="width: 140px;">--%>
                            <button class="btn btn-primary" style="width: 80px;"
                                    onclick="searchUsers();return false;">검색
                            </button>
                            <%--<button class="btn btn-default" style="width: 80px;"--%>
                            <%--onclick="getAdminUsers();return false;">초기화--%>
                            <%--</button>--%>
                            <%--</div>--%>
                        </div>
                        <%--</form>--%>
                    </div>
                </div>

                <div class="table-responsive">
                    <%--<form action="/admin/admin-account/register" method="post" style="width: 100%; position:relative;">--%>
                    <%----%>
                    <%--</form>--%>
                    <table class="table table-condensed table-hover list-table" id="user-list-table">
                        <thead>
                        <tr>
                            <th width="20%" class="text-center">사용자 계정</th>
                            <th width="20%" class="text-center">사용자 이름</th>
                            <th width="20%" class="text-center">비밀번호</th>
                            <th width="20%" class="text-center">생성일</th>
                            <th width="20%" class="text-center">그룹</th>
                            <th class="text-center shrink" style="text-align: left!important;">
                                <button class="btn btn-primary btn-register"
                                        style="width: 100%;" onclick="joinUserClickHandler(this);return false;">생성
                                </button>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <%--<c:forEach items="${adminList}" var="admin">--%>
                        <%--<tr>--%>
                        <%--<td>${admin.userId}</td>--%>
                        <%--<td class="text-center">${admin.username}</td>--%>
                        <%--<td class="text-center">********</td>--%>
                        <%--<td class="text-center">${admin.createDate}</td>--%>
                        <%--<td class="text-center shrink">--%>
                        <%--&lt;%&ndash;<form action="/admin/admin-account/modify" method="post">&ndash;%&gt;--%>
                        <%--<button class="btn btn-primary" name="userId" value="${admin.userId}"--%>
                        <%--onclick="modifyAdminUserClickHandler(this);return false;">수정--%>
                        <%--</button>--%>
                        <%--&lt;%&ndash;</form>&ndash;%&gt;--%>
                        <%--<form action="/admin/admin-account/delete" method="post"--%>
                        <%--onsubmit="return userDeleteCheck();">--%>
                        <%--<button class="btn btn-danger" name="userId" value="${admin.userId}">삭제</button>--%>
                        <%--</form>--%>
                        <%--</td>--%>
                        <%--</tr>--%>
                        <%--</c:forEach>--%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modify-dialogue-container"
     style="width: 100%;height: 100%;position: fixed;top:0;left:0;vertical-align: middle;text-align: center; background: rgba(50,50,50,0.6);display: none;z-index: 1001;">
    <div style="position: relative;width: 300px;top: calc(50% - 300px);left: calc(50% - 150px);padding: 15px;margin: 0;text-align: left;"
         class="panel panel-default">
        <%--<form action="/admin/admin-account/update" method="post" class="form" role="form">--%>
        <label>사용자 아이디</label>
        <input class="form-control" value="" placeholder="사용자 이름"
               name="userId" type="email" readOnly/><br>
        <label>이름</label>
        <input class="form-control" name="username" value="" type="text"/><br>
        <label>비밀번호</label>
        <%--<input class="form-control" value="**********" type="password" readOnly="true"/><br>--%>
        <input class="form-control" value="********" type="password" name="password"/><br>
        <label>가입일</label>
        <input class="form-control" name="createDate" value="" type="text" readOnly/><br>
        <div class="checkbox"></div>
        <br/>
        <br/>
        <div class="btn-container" style="text-align: center;width: 100%;display: flex;">
            <label class="btn btn-primary col-xs-5 btn-modify" style="margin: 0 auto;">
                저장
            </label>
            <label class="btn btn-default col-xs-5 btn-close" style="margin: 0 auto;"
                   onclick="$('.modify-dialogue-container').hide();return false;">취소
            </label>
        </div>
        <%--</form>--%>
    </div>
</div>

<div class="join-dialogue-container"
     style="width: 100%;height: 100%;position: fixed;top:0;left:0;vertical-align: middle;text-align: center; background-color: rgba(50, 50, 50, 0.6);display: none;z-index: 1001;">
    <div style="position: relative;width: 300px;top: calc(50% - 300px);left: calc(50% - 150px);padding: 15px;margin: 0;text-align: left;"
         class="panel panel-default">
        <%--<form action="/admin/admin-account/update" method="post" class="form" role="form">--%>
        <label>사용자 아이디</label>
        <input class="form-control" value="" placeholder="사용자 이름"
               name="userId" type="email"/><br>
        <label>이름</label>
        <input class="form-control" name="username" value="" type="text"/><br>
        <label>비밀번호</label>
        <%--<input class="form-control" value="**********" type="password" readOnly="true"/><br>--%>
        <input class="form-control" value="" type="password" name="password"/><br>
        <div class="checkbox"></div>
        <br/>
        <br/>
        <div class="btn-container" style="text-align: center;width: 100%;display: flex;">
            <label class="btn btn-primary col-xs-5 btn-join" style="margin: 0 auto;">
                저장
            </label>
            <label class="btn btn-default col-xs-5 btn-close" style="margin: 0 auto;"
                   onclick="$('.join-dialogue-container').hide();return false;">취소
            </label>
        </div>
        <%--</form>--%>
    </div>
</div>
<script>
    var userList = [];
    $(document).ready(function () {
        getUsers();
//        setModifyBtnClickListener();
    });

    function userDeleteCheck() {
//        if ($('#admin-user-list-table tbody tr').size() <= 1) {
//            alert('관리자 계정은 모두 삭제할 수 없습니다');
//            return false;
//        } else {
        return confirm('정말로 삭제하시겠습니까?');
//        }
    }
    function submitCheck(userId, username, password) {
        if (userId == '') {
            alert('아이디를 입력하세요.');
            return false;
        } else if (username == '') {
            alert('이름을 입력하세요.');
            return false;
        } else if (password == '') {
            alert('비밀번호를 입력하세요.');
            return false;
        }
        return true;
    }

    function getUsers() {
        initSearchInput();
        $.ajax({
            url: '/admin/user/get',
            type: 'post',
            data: {},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
                console.error(responseData);
                userList = JSON.parse(responseData);
                addListTd(userList);
            }
        });
    }

    function searchUsers() {
        $.ajax({
            url: '/admin/user/get',
            type: 'post',
            data: {
                searchFilter: $('select[name=searchFilter]').val(),
                searchInput: $('input[name=searchInput]').val()
            },
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
                console.error(responseData);
                userList = JSON.parse(responseData);
                addListTd(userList);
            }
        });
    }

    function addListTd(data) {
        var tbody = $('#user-list-table tbody');
        tbody.children().remove();
        $.each(data, function (i, d) {
            var trEl = $('<tr>' +
                    '<td class="user-id-td"></td>' +
                    '<td class="text-center username-td"></td>' +
                    '<td class="text-center password-td">********</td>' +
                    '<td class="text-center create-date-td"></td>' +
                    '<td class="text-center group-td"></td>' +
                    '<td class="text-center shrink">' +
                    '<button class="btn btn-primary" style="margin-right: 5px;" name="userId" value="" onclick="modifyUserClickHandler(this);return false;">수정</button>' +
//                    '<form action="/admin/user/delete" method="post" onsubmit="return userDeleteCheck();">' +
                    '<button class="btn btn-danger" name="userId" onclick="deleteClickListener(this);return false;" value="">삭제</button>' +
//                    '</form>' +
                    '</td></tr>');
            trEl.find('.user-id-td').text(d.userId);
            trEl.find('.username-td').text(d.username);
            trEl.find('.create-date-td').text(d.createDate);
            trEl.find('button[name=userId]').val(d.userId);
            $.each(d.userGroupApis, function (i, g) {
                var tmpEl = $('<span style="padding-right: 5px;"></span>');
                tmpEl.text(g.groupName);
                trEl.find('.group-td').append(tmpEl);
            });
            tbody.append(trEl);
        });
    }

    function deleteClickListener(element) {
        if (userDeleteCheck()) {
            var el = $(element);
            $.ajax({
                url: '/admin/user/delete',
                type: 'post',
                data: {
                    userId: el.val()
                },
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                success: function (responseData) {
                    if (responseData == 'true') {
//                        tarTr.find('.group-name-td').text(groupName);
                        alert('삭제 되었습니다.');
                        getUsers()
                    } else {
                        alert('삭제에 실패하였습니다. 다시 시도해 주세요.');
                    }
                }
            });
        }
    }

    function modifyUserClickHandler(element) {
        var el = $(element);
        var tarTr = el.parent().parent();
        var index = tarTr.index();
        var modifyDialogueContainer = $('.modify-dialogue-container');
        modifyDialogueContainer.find('input[name=userId]').val(tarTr.find('.user-id-td').text());
        modifyDialogueContainer.find('input[name=username]').val(tarTr.find('.username-td').text());
        modifyDialogueContainer.find('input[name=password]').val('********');
        modifyDialogueContainer.find('input[name=createDate]').val(tarTr.find('.create-date-td').text());
        var modifyBtnContainer = modifyDialogueContainer.find('.btn-container');
        modifyBtnContainer.children().remove();
        var tmpBtn = $('<label class="btn btn-primary col-xs-5 btn-modify" style="margin: 0 auto;">저장</label>' +
                '<label class="btn btn-default col-xs-5 btn-close" style="margin: 0 auto;" onclick="$(\'.modify-dialogue-container\').hide();return false;">취소</label>');
        modifyBtnContainer.append(tmpBtn);
        var userId = modifyDialogueContainer.find('input[name=userId]').val();

        var groupCheckbox = modifyDialogueContainer.find('.checkbox');
        groupCheckbox.children().remove();
        console.error("hihi");
        $.ajax({
            url: '/admin/user-group/get',
            type: 'post',
            data: {
                userId: userId
            },
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
                if (responseData == 'false') {
                    alert('정보를 불러오는데 실패하였습니다. 다시 시도해 주세요.');
                } else {
                    var userGroupData = JSON.parse(responseData);
                    $.each(userGroupData, function (i, d) {

                        var tmpEl = $('<label style="margin-right:10px;min-width: 80px;"><input type="checkbox" name="groups" value=""><span></span></label>')
                        console.error(d.isChecked);
                        if (d.isChecked) {
                            tmpEl.find('input').attr('checked', '');
                        }
                        tmpEl.find('input').val(d.groupName);
                        tmpEl.find('span').text(d.groupName);
                        groupCheckbox.append(tmpEl);
                    });
                    console.error(groupCheckbox);

                    modifyBtnContainer.find('.btn-modify').click(function () {
                        var username = modifyDialogueContainer.find('input[name=username]').val();
                        var password = modifyDialogueContainer.find('input[name=password]').val();

                        var a = [];
                        var b = [];
                        var checked = modifyDialogueContainer.find('input[type=checkbox]:checked');
                        $.each(checked, function (i, data) {
                            a.push($(data).val());
                        });
                        var unchecked = modifyDialogueContainer.find('input[type=checkbox]:not(:checked)');

                        $.each(unchecked, function (i, data) {
                            b.push($(data).val());
                        });
                        var checkedJson = JSON.stringify(a);
                        var uncheckedJson = JSON.stringify(b);
                        if (submitCheck(userId, username, password)) {
                            $.ajax({
                                url: '/admin/user/update',
                                type: 'post',
                                data: {
                                    userId: userId,
                                    username: username,
                                    password: password,
                                    groupNames: checkedJson,
                                    uncheckedGroupNames: uncheckedJson
                                },
                                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                                success: function (responseData) {
                                    if (responseData == 'true') {
                                        tarTr.find('.user-id-td').text(userId);
                                        tarTr.find('.username-td').text(username);
                                        alert('저장 되었습니다.');
                                        $('.modify-dialogue-container').hide();
                                        getUsers();
                                    } else {
                                        alert('수정에 실패하였습니다. 다시 시도해 주세요.');
                                    }
                                }
                            });
                        }
                    });
                    modifyDialogueContainer.show();
                    modifyDialogueContainer.find('input[name=username]').focus();
                }
            }
        });


    }

    function joinUserClickHandler(element) {
        var el = $(element);
        var tarTr = el.parent().parent();
        var joinDialogueContainer = $('.join-dialogue-container');
        joinDialogueContainer.find('input[name=userId]').val('');
        joinDialogueContainer.find('input[name=username]').val('');
        joinDialogueContainer.find('input[name=password]').val('');
//        $('.modify-dialogue-container input[name=createDate]').val(tarTr.find('td').eq(3).text());
        var joinBtnContainer = joinDialogueContainer.find('.btn-container');
        joinBtnContainer.children().remove();
        var tmpBtn = $('<label class="btn btn-primary col-xs-5 btn-join" style="margin: 0 auto;">저장</label>' +
                '<label class="btn btn-default col-xs-5 btn-close" style="margin: 0 auto;" onclick="$(\'.join-dialogue-container\').hide();return false;">취소</label>');
        joinBtnContainer.append(tmpBtn);
        var groupCheckbox = joinDialogueContainer.find('.checkbox');
        groupCheckbox.children().remove();
        $.ajax({
            url: '/admin/user-group/get',
            type: 'post',
            data: {},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
                if (responseData == 'false') {
                    alert('정보를 불러오는데 실패하였습니다. 다시 시도해 주세요.');
                } else {
                    var userGroupData = JSON.parse(responseData);
                    $.each(userGroupData, function (i, d) {

                        var tmpEl = $('<label style="margin-right:10px;min-width: 80px;"><input type="checkbox" name="groups" value=""><span></span></label>')
                        console.error(d.isChecked);
                        if (d.isChecked) {
                            tmpEl.find('input').attr('checked', '');
                        }
                        tmpEl.find('input').val(d.groupName);
                        tmpEl.find('span').text(d.groupName);
                        groupCheckbox.append(tmpEl);
                    });
                    console.error(groupCheckbox);
                    joinBtnContainer.find('.btn-join').click(function () {
                        var userId = joinDialogueContainer.find('input[name=userId]').val();
                        var username = joinDialogueContainer.find('input[name=username]').val();
                        var password = joinDialogueContainer.find('input[name=password]').val();

                        var a = [];
                        var b = [];
                        var checked = joinDialogueContainer.find('input[type=checkbox]:checked');
                        $.each(checked, function (i, data) {
                            a.push($(data).val());
                        });
                        var unchecked = joinDialogueContainer.find('input[type=checkbox]:not(:checked)');

                        $.each(unchecked, function (i, data) {
                            b.push($(data).val());
                        });
                        var checkedJson = JSON.stringify(a);
                        var uncheckedJson = JSON.stringify(b);
                        $.ajax({
                            url: '/admin/user/join',
                            type: 'post',
                            data: {
                                userId: userId,
                                username: username,
                                password: password,
                                groupNames: checkedJson,
                                uncheckedGroupNames: uncheckedJson
                            },
                            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                            success: function (responseData) {
                                if (responseData == 'true') {
                                    getUsers();
                                    alert('저장 되었습니다.');
                                    $('.join-dialogue-container').hide();
                                } else {
                                    alert('이미 같은 아이디가 존재합니다.');
                                }
                            }
                        });
                    });
                    console.error(tmpBtn);
                    joinDialogueContainer.show();
                    joinDialogueContainer.find('input[name=userId]').focus();
                }
            }
        });
    }

    function initSearchInput() {
        $('select[name=searchFilter]').val("userId");
        $('input[name=searchInput]').val("");
    }

    function makeCheckboxJson(element) {
        var el = $(el);
        var a = [];
        var b = [];
        var checked = el.find('input[type=checkbox]:checked');
        $.each(checked, function (i, data) {
            a.push($(data).val());
        });
        var unchecked = el.find('input[type=checkbox]:not(:checked)');

        $.each(unchecked, function (i, data) {
            b.push($(data).val());
        });
        var json = JSON.stringify(a);
        console.error(json);
        var input = $('<input name="groupNames">').hide();
        input.val(json);
        $('form').append(input);

        json = JSON.stringify(b);
        input = $('<input name="uncheckedGroupNames">').hide();
        input.val(json);
        $('form').append(input);
    }
</script>
</body>
</html>