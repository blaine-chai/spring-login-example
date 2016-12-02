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
            <a class="navbar-brand" href="/admin/main">관리자 페이지</a>
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
                <li class="nav-header"><a href="#" data-toggle="collapse" data-target="#user-menu">Settings <i
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
                <h2>Group List</h2>
                <div class="table-responsive">
                    <form action="/admin/group-name/register" method="post" style="width: 100%; position:relative;">

                    </form>
                    <table class="table table-condensed table-hover group-list-table" id="group-list-table">
                        <thead>
                        <tr>
                            <th width="80%" class="text-center">그룹 이름</th>
                            <th class="text-center shrink" style="width: 100px;">
                                <button class="btn btn-primary" style="width: 100px;"
                                        onclick="joinGroupClickHandler(this);return false;">생성
                                </button>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="join-dialogue-container"
     style="width: 100%;height: 100%;position: fixed;top:0;left:0;vertical-align: middle;text-align: center; background-color: rgba(50, 50, 50, 0.6);display: none;z-index: 1001;">
    <div style="position: relative;width: 300px;top: calc(50% - 300px);left: calc(50% - 150px);padding: 15px;margin: 0;text-align: left;"
         class="panel panel-default">
        <%--<form action="/admin/admin-account/update" method="post" class="form" role="form">--%>
        <label>그룹</label>
        <input class="form-control" value="" placeholder="그룹"
               name="groupName" type="text"/><br>
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

<div class="modify-dialogue-container"
     style="width: 100%;height: 100%;position: fixed;top:0;left:0;vertical-align: middle;text-align: center; background-color: rgba(50, 50, 50, 0.6);display: none;z-index: 1001;">
    <div style="position: relative;width: 300px;top: calc(50% - 300px);left: calc(50% - 150px);padding: 15px;margin: 0;text-align: left;"
         class="panel panel-default">
        <%--<form action="/admin/admin-account/update" method="post" class="form" role="form">--%>
        <label>그룹</label>
        <input class="form-control" value="" placeholder="그룹"
               name="groupName" type="text"/><br>
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

<script>
    $(document).ready(function () {
        getGroupNames();
    });

    function groupDeleteCheck() {
        return confirm('정말로 삭제하시겠습니까?');
    }

    function getGroupNames() {
        $.ajax({
            url: '/admin/group-name/get',
            type: 'post',
            data: {},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
                if (responseData == 'false') {
                    alert('다시 시도해 주세요.');
                } else {
                    console.error(responseData);
                    var groupNames = JSON.parse(responseData);
//                    console.error(groupNames);
                    addListTd(groupNames);
                }
            }
        });
    }

    function addListTd(data) {
        var tbody = $('#group-list-table tbody');
        tbody.children().remove();
        $.each(data, function (i, d) {
            var trEl = $('<tr>' +
                    '<td class="group-name-td"></td>' +
                    '<td class="text-center shrink">' +
                    '<button class="btn btn-primary" style="width:calc(50% - 2px);margin-right: 5px;" name="groupName" value="" onclick="modifyGroupClickHandler(this);return false;">수정</button>' +
//                    '<form style="width:calc(50% - 2px);" action="/admin/group-name/delete" method="post">' +
                    '<button class="btn btn-danger" style="width:calc(50% - 2px);" name="groupName" value="groupName" onclick="deleteClickListener(this);return false;">삭제</button>' +
//                    '</form>' +
                    '</td></tr>');
//            console.error(d);
            trEl.find('.group-name-td').text(d.groupName);
            trEl.find('button[name=groupName]').val(d.groupName);
            tbody.append(trEl);
        });
    }

    function deleteClickListener(element) {
        if (groupDeleteCheck()) {
            var el = $(element);
            $.ajax({
                url: '/admin/group-name/delete',
                type: 'post',
                data: {
                    groupName: el.val()
                },
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                success: function (responseData) {
                    if (responseData == 'true') {
//                        tarTr.find('.group-name-td').text(groupName);
                        alert('삭제 되었습니다.');
                        getGroupNames()
                    } else {
                        alert('삭제에 실패하였습니다. 다시 시도해 주세요.');
                    }
                }
            });
        }
    }

    function joinGroupClickHandler(element) {
        var el = $(element);
        var tarTr = el.parent().parent();
        var joinDialogueContainer = $('.join-dialogue-container');
        joinDialogueContainer.find('input[name=groupName]').val('');
        var joinBtnContainer = joinDialogueContainer.find('.btn-container');
        joinBtnContainer.children().remove();
        var tmpBtn = $('<label class="btn btn-primary col-xs-5 btn-join" style="margin: 0 auto;">저장</label>' +
                '<label class="btn btn-default col-xs-5 btn-close" style="margin: 0 auto;" onclick="$(\'.join-dialogue-container\').hide();return false;">취소</label>');
        joinBtnContainer.append(tmpBtn);

//        var userGroupData = JSON.parse(responseData);
//        $.each(userGroupData, function (i, d) {
//
//            var tmpEl = $('<label style="margin-right:10px;min-width: 80px;"><input type="checkbox" name="groups" value=""><span></span></label>')
//            console.error(d.isChecked);
//            if (d.isChecked) {
//                tmpEl.find('input').attr('checked', '');
//            }
//            tmpEl.find('input').val(d.groupName);
//            tmpEl.find('span').text(d.groupName);
//            groupCheckbox.append(tmpEl);
//        });
//        console.error(groupCheckbox);
        joinDialogueContainer.show();
        joinDialogueContainer.find('input[name=groupName]').focus();
        joinBtnContainer.find('.btn-join').click(function () {
            var groupName = joinDialogueContainer.find('input[name=groupName]').val();
            if (submitCheck(groupName)) {
                $.ajax({
                    url: '/admin/group-name/add',
                    type: 'post',
                    data: {
                        groupName: groupName
//                        orgGroupName: tarTr.find('.group-name-td').text()
                    },
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    success: function (responseData) {
                        if (responseData == 'true') {
//                            tarTr.find('.group-name-td').text(groupName);
                            alert('저장 되었습니다.');
                            $('.join-dialogue-container').hide();
                            getGroupNames();
                        } else {
                            alert('같은 그룹명이 존재합니다.');
                        }
                    }
                });
            }
        });
    }


    function modifyGroupClickHandler(element) {
        var el = $(element);
        var tarTr = el.parent().parent();
        var modifyDialogueContainer = $('.modify-dialogue-container');
        modifyDialogueContainer.find('input[name=groupName]').val(tarTr.find('.group-name-td').text());
        var modifyBtnContainer = modifyDialogueContainer.find('.btn-container');
        modifyBtnContainer.children().remove();
        var tmpBtn = $('<label class="btn btn-primary col-xs-5 btn-modify" style="margin: 0 auto;">저장</label>' +
                '<label class="btn btn-default col-xs-5 btn-close" style="margin: 0 auto;" onclick="$(\'.modify-dialogue-container\').hide();return false;">취소</label>');
        modifyBtnContainer.append(tmpBtn);

//        var userGroupData = JSON.parse(responseData);
//        $.each(userGroupData, function (i, d) {
//
//            var tmpEl = $('<label style="margin-right:10px;min-width: 80px;"><input type="checkbox" name="groups" value=""><span></span></label>')
//            console.error(d.isChecked);
//            if (d.isChecked) {
//                tmpEl.find('input').attr('checked', '');
//            }
//            tmpEl.find('input').val(d.groupName);
//            tmpEl.find('span').text(d.groupName);
//            groupCheckbox.append(tmpEl);
//        });
//        console.error(groupCheckbox);

        modifyBtnContainer.find('.btn-modify').click(function () {
            var groupName = modifyDialogueContainer.find('input[name=groupName]').val();
            if (submitCheck(groupName)) {
                $.ajax({
                    url: '/admin/group-name/update',
                    type: 'post',
                    data: {
                        groupName: groupName,
                        orgGroupName: tarTr.find('.group-name-td').text()
                    },
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    success: function (responseData) {
                        if (responseData == 'true') {
                            tarTr.find('.group-name-td').text(groupName);
                            alert('저장 되었습니다.');
                            $('.modify-dialogue-container').hide();
                            getGroupNames();
                        } else {
                            alert('같은 그룹명이 존재합니다.');
                        }
                    }
                });
            }
        });
        modifyDialogueContainer.show();
        modifyDialogueContainer.find('input[name=groupName]').focus();
    }

    function submitCheck(groupName) {
        if (groupName == '') {
            alert('그룹명을 입력하세요.');
            return false;
        }
        return true;
    }
</script>
</body>