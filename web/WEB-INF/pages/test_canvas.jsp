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
    <script src="/js/cytoscape.js"></script>
    <%--<script src="/js/code.js"></script>--%>

    <style>
        body {
            font-family: helvetica;
            font-size: 14px;
        }

        #cy {
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            z-index: 999;
        }

        h1 {
            opacity: 0.5;
            font-size: 1em;
        }
    </style>

    <script>
        $(function () {

            var cy = window.cy = cytoscape({
                container: document.getElementById('cy'),

                layout: {
                    name: 'cose',
                    animate: true,
                    nodeSpacing: 5,
                    edgeLengthVal: 45,
                    randomize: true,
                    idealEdgeLength: 100,
                    nodeOverlap: 20,
                    maxSimulationTime: 1500
                },

                style: [{
                    "selector": "core",
                    "style": {
                        "selection-box-color": "#f00",
                        "selection-box-border-color": "#f00",
                        "selection-box-opacity": "0.5"
                    }
                },{
                    "selector": ":active",
                    "style": {
                        "overlay-color": "#f00",
                        "overlay-padding": 10,
                        "overlay-opacity": 0.25
                    }
                },{
                    "selector": ".hover",
                    "style": {
                        "overlay-color": "#f00",
                        "overlay-padding": 10,
                        "overlay-opacity": 0.25
                    }
                }, {
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
                        "z-index": "10"
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
                        "background-color": "#77828C",
                        "text-outline-color": "#77828C"
                    }
                }, {
                    "selector": "edge",
                    "style": {
                        "curve-style": "haystack",
                        "haystack-radius": "0.5",
                        "opacity": "0.4",
                        "line-color": "#bbb",
                        "width": "mapData(weight, 0, 1, 1, 8)",
                        "overlay-padding": "3px"
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
                }, {"selector": "edge.filtered", "style": {"opacity": "0"}}, {
                    "selector": "edge[group=\"coexp\"]",
                    "style": {"line-color": "#d0b7d5"}
                }, {
                    "selector": "edge[group=\"coloc\"]",
                    "style": {"line-color": "#a0b3dc"}
                }, {
                    "selector": "edge[group=\"gi\"]",
                    "style": {"line-color": "#90e190"}
                }, {
                    "selector": "edge[group=\"path\"]",
                    "style": {"line-color": "#9bd8de"}
                }, {
                    "selector": "edge[group=\"pi\"]",
                    "style": {"line-color": "#eaa2a2"}
                }, {
                    "selector": "edge[group=\"predict\"]",
                    "style": {"line-color": "#f6c384"}
                }, {
                    "selector": "edge[group=\"spd\"]",
                    "style": {"line-color": "#dad4a2"}
                }, {
                    "selector": "edge[group=\"spd_attr\"]",
                    "style": {"line-color": "#D0D0D0"}
                }, {
                    "selector": "edge[group=\"reg\"]",
                    "style": {"line-color": "#D0D0D0"}
                }, {
                    "selector": "edge[group=\"reg_attr\"]",
                    "style": {"line-color": "#D0D0D0"}
                }, {"selector": "edge[group=\"user\"]", "style": {"line-color": "#f0ec86"}}],

                elements: [{
                    "data": {
                        "id": "1",
//                        "idInt": 1,
                        "name": "승목",
//                        "score": 0.006769776522008331,
                        "query": true,
                        "gene": true,
                    },
//                    "position": {"x": 481, "y": 384},
                    "group": "nodes",
                    "removed": false,
                    "selected": false,
                    "selectable": true,
                    "locked": false,
                    "grabbed": false,
                    "grabbable": true,
                    "classes": "hi"
                }, {
                    "data": {
                        "id": "2",
//                        "idInt": 611408,
                        "name": "채승목",
//                        "score": 0.006769776522008331,
                        "query": false,
                        "gene": true
                    },
//                    "position": {"x": 531.9740635094307, "y": 464.8210898234145},
                    "group": "nodes",
                    "removed": false,
                    "selected": false,
                    "selectable": true,
                    "locked": false,
                    "grabbed": false,
                    "grabbable": true,
                    "classes": ""
                }, {
                    "data": {
                        "id": "3",
//                        "idInt": 611408,
                        "name": "3",
//                        "score": 0.006769776522008331,
                        "query": false,
                        "gene": true
                    },
//                    "position": {"x": 531.9740635094307, "y": 464.8210898234145},
                    "group": "nodes",
                    "removed": false,
                    "selected": false,
                    "selectable": true,
                    "locked": false,
                    "grabbed": false,
                    "grabbable": true,
                    "classes": ""
                }, {
                    "data": {
                        "id": "4",
//                        "idInt": 611408,
                        "name": "4",
//                        "score": 0.006769776522008331,
                        "query": false,
                        "gene": true
                    },
//                    "position": {"x": 531.9740635094307, "y": 464.8210898234145},
                    "group": "nodes",
                    "removed": false,
                    "selected": false,
                    "selectable": true,
                    "locked": false,
                    "grabbed": false,
                    "grabbable": true,
                    "classes": ""
                }, {
                    "data": {
                        "id": "5",
//                        "idInt": 611408,
                        "name": "5",
//                        "score": 0.006769776522008331,
                        "query": false,
                        "gene": true
                    },
//                    "position": {"x": 531.9740635094307, "y": 464.8210898234145},
                    "group": "nodes",
                    "removed": false,
                    "selected": false,
                    "selectable": true,
                    "locked": false,
                    "grabbed": false,
                    "grabbable": true,
                    "classes": ""
                }, {
                    group: "edges",
                    data: {source: "1", target: "2"}
                }, {
                    group: "edges",
                    data: {source: "1", target: "3"}
                }]

            });
        });
    </script>
</head>
<body>
<div id="cy"></div>

</body>
</html>
