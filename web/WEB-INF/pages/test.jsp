<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        .table-column {
            box-sizing: border-box;
            float: left;
            display: table-column;
        }

        .table-row {
            display: table-row;
        }
    </style>

    <link href="/css/main-style.css" rel="stylesheet" type="text/css">
    <link href="/css/datepicker.css" rel="stylesheet" type="text/css">
    <script src="/js/colResizable-1.6.js"></script>
    <script src="/js/moment.js"></script>
    <script src="/js/bootstrap-datepicker.js"></script>
</head>
<body>
<div class="popover_table_content_wrapper" style="display:none">
    <div>
        <span class="relative-author-from-date"></span>
        <span>~</span>
        <span class="relative-author-to-date"></span>
    </div>
    <div>
        <div>
            <table class="table table-hover table-fixed table-bordered table-striped table-condensed">
                <thead>
                <tr>
                    <th>저장시간</th>
                    <th>저자</th>
                    <th>참조저자</th>
                    <th>내용</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div>
            <nav aria-label="..." style="text-align: center; margin-top:10px;">
                <ul class="pagination pagination-sm" style="margin: 0 auto;">
                    <li><a href="#" aria-label="Previous" class="disabled"><span aria-hidden="true">«</span></a></li>
                    <li><a href="#" class="active">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li><a href="#" aria-label="Next"><span aria-hidden="true">»</span></a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>