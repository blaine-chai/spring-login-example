<%--
  Created by IntelliJ IDEA.
  User: blainechai
  Date: 2016. 12. 21.
  Time: 오후 2:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="/js/jquery.min.js"></script>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet"
          href="/css/bootstrap.min.css">

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
</head>
<body>
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
    <button class="btn btn-sm btn-default btn-view-all-nick" style="padding-left: 10px;">닉네임 정보 보기</button>
    <button class="btn btn-sm btn-default btn-view-all-nick" style="position: absolute;right: 510px;">view
    <button class="btn btn-sm btn-default btn-import-all-nick" style="position: absolute;right: 440px;">import
    <button class="btn btn-sm btn-default btn-export-all-nick" style="position: absolute;right: 370px;">export
    <button class="btn btn-sm btn-default btn-delete-all-nick" style="position: absolute;right: 300px;">delete
    </button>
</div>
<div style="padding: 20px 0 0 20px;">
    <input type="text" class="search-data-count count" placeholder="검색 데이터 개수를 입력하세요."
           style="font-size: 12px;height: 30px;width: 200px;padding-left: 10px;">
    <button class="btn btn-sm btn-default btn-search-test" style="padding-left: 10px;">닉네임 검색 시간 비교</button>
</div>
<div class="result-data" style="padding: 20px;">

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
                $('.result-data').text(responseData);
            }
        })
    });

    $('.btn-import-all-nick').click(function () {
        $.ajax({
            url: '/admin/test/nickname/import',
            type: 'post',
            data: { },
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
                $('.result-data').text(responseData);
            }
        })
    });
    $('.btn-export-all-nick').click(function () {
        $.ajax({
            url: '/admin/test/nickname/export',
            type: 'post',
            data: { },
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
            data: { },
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (responseData) {
                $('.result-data').text(responseData);
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
                $('.result-data').text(responseData);
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

</script>
</body>
</html>
