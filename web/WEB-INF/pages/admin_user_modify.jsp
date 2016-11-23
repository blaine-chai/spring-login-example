<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Server Admin - admin 사용자 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <form action="/admin/user/update" method="post" class="form" role="form">
        <label>사용자 아이디</label>
        <input class="form-control" value="${adminInfo.userId}" placeholder="사용자 이름"
               name="userId" type="email" readOnly="true"/><br>
        <label>이름</label>
        <input class="form-control" name="username" value="${adminInfo.username}" type="text"/><br>
        <label>비밀번호</label>
        <%--<input class="form-control" value="**********" type="password" readOnly="true"/><br>--%>
        <input class="form-control" value="**********" type="password"/><br>
        <label>가입일</label>
        <input class="form-control" name="number" value="${adminInfo.createDate}" type="text"/><br>
        <div class="checkbox">
            <c:forEach items="${groupNames}" var="groupName">
                <c:choose>
                    <c:when test="${adminInfo.hasGroupName(groupName.groupName)}">
                        <label>
                            <input type="checkbox" name="groups" value="${groupName.groupName}"
                                   checked="checked">${groupName.groupName}</label>
                    </c:when>
                    <c:otherwise>
                        <label>
                            <input type="checkbox" name="groups" value="${groupName.groupName}">${groupName.groupName}
                        </label>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <br/>
        <br/>
        <a href="/admin/user" class="btn btn-lg btn-danger btn-block">취소</a>
        <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="makeCheckboxJson();">
            저장
        </button>
        <%--checked="checked"--%>
    </form>
</div>

<script>
    function makeCheckboxJson() {
        var a = [];
        var b = [];
        var checked = $('input[type=checkbox]:checked');
        $.each(checked, function (i, data) {
            a.push($(data).val());
        });
        var unchecked = $('input[type=checkbox]:not(:checked)');

        $.each(unchecked, function (i, data) {
            b.push($(data).val());
        });
        var json = JSON.stringify(a);
        console.error(json);
        var input=$('<input name="groupNames">');
        input.val(json);
        $('form').append(input);

        json = JSON.stringify(b);
         input=$('<input name="uncheckedGroupNames">');
        input.val(json);
        $('form').append(input);
    }
</script>
</body>
</html>