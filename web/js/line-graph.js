var timePeriodOption = {
    daily: 0,
    weekly: 1,
    monthly: 2,
    yearly: 3
};

var GraphModule = (function () {

    var graph = (function (opt) {
        var defaults = {
            margin: {top: 20, right: 60, bottom: 30, left: 60},
            containerSelector: '#main-graph-container',
            data: [],
            xRange: [],
            timePeriod: timePeriodOption.monthly,
            nameList: [],
            interpolation: "monotone",
            colorSet: [],
            totalData: []
        };

        var option = $.extend(defaults, opt);
        var m;
        var cWidth, cHeight, width, height;
        var x, y, totalY, xAxis, yAxis, totalYAxis;
        var svg;
        var graphContainer;

        option = defaults;

        var setOption = (function (opt) {
            option = $.extend(option, opt);
            m = option.margin;
        });

        var setGraphContainer = (function (selector) {
            if (selector != undefined) {
                option.containerSelector = selector;
            }
            graphContainer = $(option.containerSelector);
        });

        var setWidth = (function () {
            cWidth = graphContainer.innerWidth();
            width = parseInt(cWidth) - m.left - m.right;
        });

        var setHeight = (function () {
            cHeight = graphContainer.innerHeight();
            height = parseInt(cHeight) - m.top - m.bottom;
        });

        var addData = (function (author, d) {
            if (d != undefined) {
                $.each(option.nameList, function (i, name) {
                    if (d[name] == undefined) {
                        d[name] = 0;
                    }
                    option.data.push(d);

                });
                if (svg != undefined) {
                    svg.remove();
                    init();
                }
            }
        });
        var setMargin = (function (margin) {
            m = $.extend(m, margin);
            option.margin = m;
        });

        var setSize = (function () {


        });

        var setSvg = (function () {
            svg = d3.select(option.containerSelector).append("svg");
            svg.attr("width", width + m.left + m.right)
                .attr("height", height + m.top + m.bottom)
                .append("g")
                .attr("transform", "translate(" + m.left + "," + m.top + ")");
        });

        var setXDomain = (function () {
            var domain = [];
            $.each(option.data, function (i, data) {
                domain.push(data['index']);
            });

            x = d3.scale.ordinal()
                .domain(domain)
                .rangePoints([0, width]);
        });

        var setYDomain = (function () {
            var yArr = [];

            y = d3.scale.linear().domain([d3.min(option.data, function (d) {
                $.each(option.nameList, function (i, name) {
                    yArr.push(parseInt(d[name]));
                });
                return Math.min.apply(null, yArr);
            }),
                d3.max(option.data, function (d) {
                    return Math.max.apply(null, yArr) * 1.8;
                })]).range([height, 0]);

            yArr = [];
            totalY = d3.scale.linear().domain([d3.min(option.totalData, function (d) {
                $.each(option.nameList, function (i, name) {
                    yArr.push(parseInt(d[name]));
                });
                return Math.min.apply(null, yArr);
            }),
                d3.max(option.totalData, function (d) {
                    return Math.max.apply(null, yArr) * 1.2;
                })]).range([height, 0]);
        });

        //x,y axis setting
        var setXAxis = (function () {
            xAxis = d3.svg.axis().scale(x).orient("bottom").ticks(option.data.length);
        });

        var setYAxis = (function () {
            yAxis = d3.svg.axis().scale(y).orient("left").ticks(5);

            totalYAxis = d3.svg.axis().scale(totalY).orient("right").ticks(5);
        });

        //draw x,y axis

        var drawGraph = (function () {

            svg.select('g').selectAll("line.y")
                .data(y.ticks(4))
                .enter().append("line")
                .attr("class", "y")
                .attr("x1", 0)
                .attr("x2", width)
                .attr("y1", y)
                .attr("y2", y)
                .style("stroke", "#ccc");

            svg.select('g').append('g')
                .attr('class', 'x axis')
                .attr('transform', 'translate(0, ' + height + ')')
                .call(xAxis);

            svg.select('g').append("g")
                .attr("class", "y axis")
                .call(yAxis);

            svg.select('g').append("g")
                .attr("class", "y axis total-y")
                .attr("transform", "translate(" + width + " ,0)")
                .call(totalYAxis);

            // setColor();

            $.each(option.nameList, function (i, name) {
                var line = d3.svg.line().x(function (d) {
                    return x(d['index']);
                }).y(function (d) {
                    return y(d[name]);
                }).interpolate(option.interpolation);

                svg.select('g').append("path")
                    .datum(option.data)
                    .attr("class", "line")
                    .attr("d", line)
                    .style('stroke', option.colorSet[i]);
            });

            $.each(option.nameList, function (i, name) {
                var line = d3.svg.line().x(function (d) {
                    return x(d['index']);
                }).y(function (d) {
                    return totalY(d[name]);
                }).interpolate(option.interpolation);
                svg.select('g').append("path")
                    .datum(option.totalData)
                    .attr("class", "line total")
                    .attr("d", line)
                    .style('stroke', option.colorSet[i]);
            });

        });

        var init = function () {
            setOption();
            setGraphContainer();
            setWidth();
            setHeight();
            addName();
            setSvg();
            setXDomain();
            setYDomain();
            //x,y axis setting
            setXAxis();
            setYAxis();
            drawGraph();
            graphContainer.find('.graph-overall-container').remove();
            var graphOverall = $('<div class="panel panel-default graph-overall-container" style="position: absolute;width: 130px;top: 15px;left:75px;padding: 5px;margin-bottom: 0;">' +
                '<div class="panel panel-default graph-overall" style="padding: 5px;margin-bottom: 0;"></div></div>');
            graphOverall.draggable({containment: option.containerSelector});
            graphContainer.append(graphOverall);
            setGraphOverall();
        };

        //Draw Circle
//    svg.selectAll("dot")
//            .data(data)
//            .enter()
//            .append("circle")
//            .attr("r", 4)`
//            .attr("cx", function(d) { return x(d.date); })
//            .attr("cy", function(d) { return y(d.count); });
//
//    Input text
//    svg.selectAll("dot")
//            .data(data)
//            .enter()
//            .append("text")
//            .attr('text-anchor', 'middle')
//            .attr("x", function(d) { return x(d.date); })
//            .attr("y", function(d) { return y(d.count); })
//            .attr('dy', '-10')
//            .text(function(d) { return d.count; });


        var setColor = function () {
            $.each(option.data, function (i, d) {
                option.colorSet[i] = pickColor();
            });
        };

        var pickColor = function () {
            return randomColor({
                luminosity: 'dark',
                format: 'rgb' // e.g. 'rgba(9, 1, 107, 0.6482447960879654)'
            });
        };


        var addColor = function () {
            option.colorSet.push(pickColor());
        };

        var addName = (function (name) {
            option.nameList.push()
        });

        var setGraphOverall = function (boolean) {
            var graphOverall = graphContainer.find('.graph-overall');
            graphOverall.children().remove();
            $.each(option.nameList, function (i, name) {
                var tmp = $('<div style="font-size: 11px;margin-left: 5px;"></div>');
                tmp.append(name + '<span style="position: absolute;right: 15px;"><b>────</b></span>');
                tmp.find('span').css('color', option.colorSet[i]);
                graphOverall.append(tmp);
            });
        };


        return {
            drawGraph: drawGraph,
            setMargin: setMargin,
            setOption: setOption,
            setGraphContainer: setGraphContainer,
            setWidth: setWidth,
            setHeight: setHeight,
            setSize: setSize,
            setSvg: setSvg,
            setXDomain: setXDomain,
            setYDomain: setYDomain,
            setXAxis: setXAxis,
            setYAxis: setYAxis,
            setData: function (data) {
                option.data = data;

                option.totalData = option.data.slice(0); //clone
                $.each(option.data, function (i, d) {
                    option.totalData[i] = $.extend({}, option.data[i]);
                    for (j = 0; j < option.nameList.length; j++) {
                        if (i != 0) {
                            option.totalData[i][option.nameList[j]] = parseInt(option.totalData[i][option.nameList[j]]) + parseInt(option.totalData[i - 1][option.nameList[j]]);
                        }
                    }
                });
                setColor();
            },

            addNameList: function (name) {
                var hasName = false;
                $.each(option.nameList, function (i, orgName) {
                    if (orgName == name) {
                        hasName = true;
                    }
                });
                if (!hasName) {
                    option.nameList.push(name);
                }
            },
            addData: function (name, dataSet) {
                // console.error(dataSet);
                $.each(dataSet, function (i, d) {
                    console.error(d[name]);
                    if (option.data[i][name] != undefined) {
                        return;
                    }
                    option.data[i][name] = d[name];

                    if (i != 0) {
                        option.totalData[i][name] = parseInt(option.totalData[i - 1][name]) + parseInt(d[name]);
                    } else {
                        option.totalData[i][name] = parseInt(d[name]);
                    }
                    addColor();
                });
            },
            removeNameList: function () {
                option.nameList = []
            },
            removeData: function () {
                option.data = []
            },
            removeSvg: function () {
                if (svg != undefined) {
                    svg.remove();
                }
            },

            getMargin: m,
            getOption: function () {
                return option;
            },
            getTotalData: function () {
                return option.totalData;
            },
            getSvg: svg,
            getGraphContainer: graphContainer,
            getWidth: width,
            getHeight: height,
            getData: function () {
                return option.data
            }

            ,
            getXAxis: xAxis,
            getYAxis: yAxis,
            refresh: function () {
                if (svg != undefined) {
                    svg.remove();
                    setOption();
                    setGraphContainer();
                    setWidth();
                    setHeight();
                    addName();
                    // addData();
                    setMargin();
                    setSvg();
                    setXDomain();
                    setYDomain();
                    //x,y axis setting
                    setXAxis();
                    setYAxis();
                    drawGraph();
                    setGraphOverall();
                }
            },
            getNameList: function () {
                return option.nameList;
            },
            init: init
        }
    });

    return {
        graph: graph
    }
})();