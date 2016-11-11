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
    <style>
        svg {
            background-color: #eeeeee;
            fill: gray;
        }
        svg g path.line {
            stroke: #1db34f;
            stroke-width: 2px;
            stroke-opacity: 1;
            fill: none;
        }
        svg g circle {
            fill: #1db34f;
            stroke: #16873c;
            stroke-width: 2px;
        }
    </style>

    <link href="/css/main-style.css" rel="stylesheet" type="text/css">
    <link href="/css/datepicker.css" rel="stylesheet" type="text/css">
    <script src="/js/colResizable-1.6.js"></script>
    <script src="/js/moment.js"></script>
    <script src="/js/bootstrap-datepicker.js"></script>
    <script src="/js/d3.v3.min.js"></script>
</head>
<body>
<div class="main-graph">
    <h1>Line Chart</h1>
    <div id="main-graph-container">
    </div>
</div>
<script>
    var margin = {top: 20, right: 20, bottom: 30, left: 40};
    var width = parseInt($('#main-graph-container').innerWidth())- margin.left - margin.right;
    var height = 200 - margin.top - margin.bottom;

    var svg = d3.select("#main-graph-container").append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var data = [
        {"date":new Date("2014-02-20T00:00:00"), "count":1},
        {"date":new Date("2014-02-20T02:00:00"), "count":2},
        {"date":new Date("2014-02-20T04:00:00"), "count":3},
        {"date":new Date("2014-02-20T06:00:00"), "count":4},
        {"date":new Date("2014-02-20T08:00:00"), "count":5},
        {"date":new Date("2014-02-20T10:00:00"), "count":6},
        {"date":new Date("2014-02-20T12:00:00"), "count":7},
        {"date":new Date("2014-02-20T14:00:00"), "count":6},
        {"date":new Date("2014-02-20T16:00:00"), "count":5},
        {"date":new Date("2014-02-20T18:00:00"), "count":4},
        {"date":new Date("2014-02-20T20:00:00"), "count":3},
        {"date":new Date("2014-02-20T22:00:00"), "count":2},
        {"date":new Date("2014-02-20T23:59:59"), "count":1}
    ];

    //x,y axis setting
    var x = d3.time.scale().domain([data[0].date, data[data.length-1].date]).rangeRound([0, width], 1);
    var y = d3.scale.linear().domain([0, 10]).range([height, 0]);

    var xAxis = d3.svg.axis().scale(x).orient("bottom").ticks(d3.time.hour, 1).tickFormat(d3.time.format('%H'));
    var yAxis = d3.svg.axis().scale(y).orient("left").ticks(5);

    //draw x,y axis
    svg.selectAll("line.y")
            .data(y.ticks(4))
            .enter().append("line")
            .attr("class", "y")
            .attr("x1", 0)
            .attr("x2", width)
            .attr("y1", y)
            .attr("y2", y)
            .style("stroke", "#ccc");

    svg.append('g')
            .attr('class', 'x axis')
            .attr('transform', 'translate(0, '+height+')')
            .call(xAxis);

    svg.append("g")
            .attr("class", "y axis")
            .call(yAxis);

    var line = d3.svg.line().x(function(d) {return x(d.date); }).y(function(d) { return y(d.count); }).interpolate("linear");

    //Input Line
    svg.append("path")
            .datum(data)
            .attr("class", "line")
            .attr("d", line);
    svg.append("path")
            .datum(data)
            .attr("class", "line2")
            .attr("d", line);
    svg.append("path")
            .datum(data)
            .attr("class", "line")
            .attr("d", line);
    svg.append("path")
            .datum(data)
            .attr("class", "line")
            .attr("d", line);
    svg.append("path")
            .datum(data)
            .attr("class", "line")
            .attr("d", line);


    //Draw Circle
    svg.selectAll("dot")
            .data(data)
            .enter()
            .append("circle")
            .attr("r", 4)
            .attr("cx", function(d) { return x(d.date); })
            .attr("cy", function(d) { return y(d.count); });

    //Input text
    svg.selectAll("dot")
            .data(data)
            .enter()
            .append("text")
            .attr('text-anchor', 'middle')
            .attr("x", function(d) { return x(d.date); })
            .attr("y", function(d) { return y(d.count); })
            .attr('dy', '-10')
//            .text(function(d) { return d.count; });
</script>
</body>
</html>