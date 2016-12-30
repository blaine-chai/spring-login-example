var timePeriodOption = {
    daily: 0,
    weekly: 1,
    monthly: 2,
    yearly: 3
};

var GraphModule = (function () {

    var relStartPos = new Object();
    relStartPos.left = 100;
    relStartPos.top = 200;
    relStartPos.iLeft = 100;
    relStartPos.iTop = 200;
    relStartPos.maxLeft = 300;
    relStartPos.maxTop = 300;
    relStartPos.count = 0;

    function setRelTablePos() {
        if (relStartPos.top < relStartPos.maxTop) {
            relStartPos.left += 15;
            relStartPos.top += 15;
        } else {
            relStartPos.count++;
            relStartPos.left = relStartPos.iLeft + (relStartPos.count * 15);
            relStartPos.top = relStartPos.iTop;
        }
    }

    // function exportTableToCSV($table, filename) {
    //
    //     var $rows = $table.find('tr:has(td),tr:has(th)'),
    //
    //         // Temporary delimiter characters unlikely to be typed by keyboard
    //         // This is to avoid accidentally splitting the actual contents
    //         tmpColDelim = String.fromCharCode(11), // vertical tab character
    //         tmpRowDelim = String.fromCharCode(0), // null character
    //
    //         // actual delimiter characters for CSV format
    //         colDelim = '","',
    //         rowDelim = '"\r\n"',
    //
    //         // Grab text from table into CSV formatted string
    //         csv = '"' + $rows.map(function (i, row) {
    //                 var $row = $(row), $cols = $row.find('td,th');
    //
    //                 return $cols.map(function (j, col) {
    //                     var $col = $(col), text = $col.text();
    //
    //                     return text.replace(/"/g, '""'); // escape double quotes
    //
    //                 }).get().join(tmpColDelim);
    //
    //             }).get().join(tmpRowDelim)
    //                 .split(tmpRowDelim).join(rowDelim)
    //                 .split(tmpColDelim).join(colDelim) + '"',
    //
    //
    //         // Data URI
    //         csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);
    //
    //     console.log(csv);
    //
    //     if (window.navigator.msSaveBlob) { // IE 10+
    //         //alert('IE' + csv);
    //         window.navigator.msSaveOrOpenBlob(new Blob([csv], {type: "text/plain;charset=utf-8;"}), filename)
    //     }
    //     else {
    //         $(this).attr({'download': filename, 'href': csvData, 'target': '_blank'});
    //     }
    // }

    Number.prototype.format = function () {
        if (this == 0) return 0;

        var reg = /(^[+-]?\d+)(\d{3})/;
        var n = (this + '');

        while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');

        return n;
    };

    String.prototype.format = function () {
        var num = parseFloat(this);
        if (isNaN(num)) return "0";

        return num.format();
    };


    var graph = (function (opt) {
        var defaults = {
            margin: {top: 20, right: 60, bottom: 30, left: 60},
            containerSelector: '#main-graph-container',
            data: [],
            // xRange: [],
            timePeriod: timePeriodOption.monthly,
            nameList: [],
            interpolation: "monotone",
            colorSet: [
                '#3333FF',
                '#669933',
                '#FF3333',
                '#33CCFF',
                '#33FF33',
                '#FF33CC',
                '#CCFF33',
                '#CC33FF',
                '#663366',
                '#336699',
                '#CC33CC',
                '#336666',
                '#CCCC33',
                '#330066',
                '#993366',
                '#666633',
                '#006633',
                '#33CCCC',
                '#CC3333',
                '#663300',
                '#3333CC',
                '#336666',
                '#33CC33',
                '#000000'],
            totalData: [],
            graphOverall: true
        };

        var option = $.extend(defaults, opt);
        var m;
        var cWidth, cHeight, width, height;
        var x, y, totalY, xAxis, yAxis, totalYAxis, totalX, totalXAxis;
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
                .style("background-color", "#fff")
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

            var n = parseInt(domain.length / 6);
            if (domain.length <= 6) {
                n = 1;
            }

            var newDomain = [];
            var last;
            for (i = 0; i < domain.length; i += n) {
                newDomain.push(domain[i]);
                last = i;
            }
            totalX = d3.scale.ordinal()
                .domain(newDomain).rangePoints([0, x(domain[last])]);
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
            // xAxis = d3.svg.axis().scale(x).orient("bottom").ticks(3);
            totalXAxis = d3.svg.axis().scale(totalX).orient("bottom");
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

            // svg.select('g').append('g')
            //     .attr('class', 'x axis')
            //     .attr('transform', 'translate(0, ' + height + ')')
            //     .call(xAxis);

            // svg.select('g').append('g')
            //     .attr('class', 'x axis')
            //     .attr('transform', 'translate(0, ' + height + ')')

            svg.select('g').append('g')
                .attr('class', 'x axis total-x')
                .attr('transform', 'translate(0, ' + height + ')')
                .call(totalXAxis);

            svg.selectAll('.x.axis text')
                .style('font-size', '10px');

            svg.select('g').append("g")
                .attr("class", "y axis")
                .call(yAxis);


            svg.select('g').append("g")
                .attr("class", "y axis total-y")
                .attr("transform", "translate(" + width + " ,0)")
                .call(totalYAxis);

            svg.selectAll('.y.axis text')
                .style('font-size', '10px');

            // setColor();

            svg.selectAll('.axis path, .axis line')
                .style('fill', 'none')
                .style('stroke', 'grey')
                .style('stroke-width', '1')
                .style('shape-rendering', 'crispEdges');

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
                    .style('stroke-width', '2px')
                    .style('stroke-opacity', '0.5')
                    .style('fill', 'none')
                    .style('stroke', option.colorSet[i])
                    .style('fill', 'none');
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
                    .style('stroke-dasharray', '3')
                    .style('stroke-width', '2px')
                    .style('stroke-opacity', '0.7')
                    .style('stroke', option.colorSet[i])
                    .style('fill', 'none');

                svg.select('.total-y')
                    .append('g')
                    .attr('class', 'sum')
                    // .style('')
                    .attr('transform', 'translate(0,' + totalY(option.totalData[option.totalData.length - 1][name]) + ')')
                    .append('text')
                    .text(option.totalData[option.totalData.length - 1][name].format());


                var text = graphContainer.find('.sum text').eq(i);
                text.css('stroke', option.colorSet[i]);
                text.css('opacity', 0.8);
                text.css('font-size', '12px');
                text.attr('x', -80);
                text.attr('y', -10);
                // text.attr('x', (-text.width()) * 1.1);
                // text.attr('y', -text.height());
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
            if (option.graphOverall) {
                setGraphOverall();
            }
            console.error(svg);
            svg.on('click', function(){
                openWithNewWindow();
            });
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
                // option.colorSet[i] = pickColor();
            });
        };

        var pickColor = function () {
            return randomColor({
                luminosity: 'dark',
                format: 'rgb' // e.g. 'rgba(9, 1, 107, 0.6482447960879654)'
            });
        };


        // var addColor = function () {
        //     option.colorSet.push(pickColor());
        // };

        var addName = (function (name) {
            option.nameList.push()
        });

        var setGraphOverall = function (boolean) {
            if (option.graphOverall) {
                graphContainer.find('.graph-overall-container').remove();

                var graphOverallContainer = $('<div class="panel panel-default graph-overall-container" style="position: absolute;top: 15px;left:75px;padding: 5px;margin-bottom: 0;">' +
                    // var graphOverallContainer = $('<div class="panel panel-default graph-overall-container" style="position: absolute;width: 130px;top: 15px;left:75px;padding: 5px;margin-bottom: 0;">' +
                    '<div class="panel panel-default graph-overall" style="padding: 5px;margin-bottom: 0;"></div></div>');
                graphOverallContainer.draggable({containment: option.containerSelector});
                graphContainer.append(graphOverallContainer);

                var graphOverall = graphContainer.find('.graph-overall');

                $.each(option.nameList, function (i, name) {
                    var tmp = $('<div class="graph-overall-item" style="font-size: 11px;padding-left: 5px;padding-right: 40px;"></div>');
                    tmp.append(name + '<span style="position: absolute;right: 15px;height: 3px;width: 30px;vertical-align: middle;margin-top: 6px;"></span>');
                    tmp.find('span').css('background-color', option.colorSet[i]);
                    graphOverall.append(tmp);

                    tmp.click(function () {
                        var relativeTitle = name;
                        var tmpHtml = $('<div class="alert bg-white alert-dismissible fade in border-gray relative-table-wrapper" style="position: absolute; z-index: 10; width: 250px;' +
                            ' left:' + relStartPos.left + 'px;top:' + relStartPos.top + 'px;" role="alert">' +
                            '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">×</span>' +
                            '</button>' +
                            '<div class="relative-title">' + relativeTitle + '</div>' +
                            '<div class="draggable-content-container" style="margin-top: 5px;">' +
                            '<div id="search-result-export-container" style="position: relative;height: 35px;">' +
                            '<div class="total-number" style="position:absolute; text-align: right;font-size: 12px;line-height: 30px;vertical-align: middle;">Total : ' + option.totalData[option.totalData.length - 1][name].format() + '</div>' +
                            '<a class="btn btn-default btn-sm btn-export" style="right: 0;position: absolute;">내보내기</a></div>' +
                            '<div style="overflow: scroll;height: 300px;">' +
                            '<table class="table table-hover table-fixed table-bordered table-striped table-condensed" style="font-size: 11px; margin-bottom: 0;">' +
                            '<thead></thead>' +
                            '<tbody></tbody></table></div>' +
                            '</div>');
                        setRelTablePos();

                        var thEl = $('<tr>' +
                            '<th>날짜</th>' +
                            '<th>개수</th>' +
                            '</tr>');
                        tmpHtml.find('thead').append(thEl);

                        // $.each(result, function (i, mResult) {
                        //     var tmpEl = $('<tr><td>' + mResult.index + '</td>' +
                        //         '<td>' + mResult.total + '</td>' +
                        //         '</tr>');
                        //     tmpHtml.find('tbody').append(tmpEl);
                        // });

                        $.each(option.data, function (i, d) {
                            var tmpEl = $('<tr><td>' + d.index + '</td>' +
                                '<td style="text-align: right; font-size: 12px;padding-right: 10px;">' + d[name].format() + '</td>' +
                                '</tr>');
                            tmpHtml.find('tbody').append(tmpEl);
                        });

                        $('body').append(tmpHtml);

                        tmpHtml.draggable({cancel: '.draggable-content-container'});

                        tmpHtml.find('.btn-export').click(function (event) {

                            exportTableToCSVInStatistics.apply(this, [$(tmpHtml.find('table')), 'export.csv', option.totalData[option.totalData.length - 1][name].format()]);
                        });
                    });
                });
            }
        };


        function openWithNewWindow() {
            var w = 800, // or whatever your svg width is
                h = 500;

            var tmpGraphContainer = $('<div class="tmp-graph-container" style="display:none;"></div>');

            var width = w - m.left - m.right;
            var height = h - m.top - m.bottom;

            $('body').append(tmpGraphContainer);

            var svg = d3.select('.tmp-graph-container').append('svg');

            svg.attr("width", width + m.left + m.right)
                .attr("height", height + m.top + m.bottom)
                .style("background-color", "#fff")
                .append("g")
                .attr("transform", "translate(" + m.left + "," + m.top + ")");

            var domain = [];
            $.each(option.data, function (i, data) {
                domain.push(data['index']);
            });

            var x = d3.scale.ordinal()
                .domain(domain)
                .rangePoints([0, width]);

            var n = parseInt(domain.length / 6);
            if (domain.length <= 6) {
                n = 1;
            }

            var newDomain = [];
            var last;
            for (i = 0; i < domain.length; i += n) {
                newDomain.push(domain[i]);
                last = i;
            }
            var totalX = d3.scale.ordinal()
                .domain(newDomain).rangePoints([0, x(domain[last])]);

            var yArr = [];

            var y = d3.scale.linear().domain([d3.min(option.data, function (d) {
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

            var xAxis = d3.svg.axis().scale(x).orient("bottom").ticks(option.data.length);
            // xAxis = d3.svg.axis().scale(x).orient("bottom").ticks(3);
            var totalXAxis = d3.svg.axis().scale(totalX).orient("bottom");

            var yAxis = d3.svg.axis().scale(y).orient("left").ticks(5);

            var totalYAxis = d3.svg.axis().scale(totalY).orient("right").ticks(5);

            svg.select('g').selectAll("line.y")
                .data(y.ticks(4))
                .enter().append("line")
                .attr("class", "y")
                .attr("x1", 0)
                .attr("x2", width)
                .attr("y1", y)
                .attr("y2", y)
                .style("stroke", "#ccc");

            // svg.select('g').append('g')
            //     .attr('class', 'x axis')
            //     .attr('transform', 'translate(0, ' + height + ')')
            //     .call(xAxis);

            // svg.select('g').append('g')
            //     .attr('class', 'x axis')
            //     .attr('transform', 'translate(0, ' + height + ')')

            svg.select('g').append('g')
                .attr('class', 'x axis total-x')
                .attr('transform', 'translate(0, ' + height + ')')
                .call(totalXAxis);

            svg.selectAll('.x.axis text')
                .style('font-size', '10px');

            svg.select('g').append("g")
                .attr("class", "y axis")
                .call(yAxis);


            svg.select('g').append("g")
                .attr("class", "y axis total-y")
                .attr("transform", "translate(" + width + " ,0)")
                .call(totalYAxis);

            svg.selectAll('.y.axis text')
                .style('font-size', '10px');

            // setColor();

            svg.selectAll('.axis path, .axis line')
                .style('fill', 'none')
                .style('stroke', 'grey')
                .style('stroke-width', '1')
                .style('shape-rendering', 'crispEdges');

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
                    .style('stroke-width', '2px')
                    .style('stroke-opacity', '0.5')
                    .style('fill', 'none')
                    .style('stroke', option.colorSet[i])
                    .style('fill', 'none');
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
                    .style('stroke-dasharray', '3')
                    .style('stroke-width', '2px')
                    .style('stroke-opacity', '0.7')
                    .style('stroke', option.colorSet[i])
                    .style('fill', 'none');

                svg.select('.total-y')
                    .append('g')
                    .attr('class', 'sum')
                    // .style('')
                    .attr('transform', 'translate(0,' + totalY(option.totalData[option.totalData.length - 1][name]) + ')')
                    .append('text')
                    .text(option.totalData[option.totalData.length - 1][name].format());


                var text = tmpGraphContainer.find('.sum text').eq(i);
                text.css('stroke', option.colorSet[i]);
                text.css('opacity', 0.8);
                text.css('font-size', '12px');
                text.attr('x', -80);
                text.attr('y', -10);
                // text.attr('x', (-text.width()) * 1.1);
                // text.attr('y', -text.height());
            });
            //
            // function svgToCanvas() {
            //     // Select the first svg element
            //     var svg = d3.select('.tmp-graph-container>svg')[0][0],
            //         img = new Image(),
            //         serializer = new XMLSerializer(),
            //         svgStr = serializer.serializeToString(svg);
            //
            //     img.src = 'data:image/svg+xml;base64,' + window.btoa(svgStr);
            //
            //     // You could also use the actual string without base64 encoding it:
            //     //img.src = "data:image/svg+xml;utf8," + svgStr;
            //
            //
            //     var canvas = document.createElement("canvas");
            //     document.body.appendChild(canvas);
            //
            //     canvas.width = w;
            //     canvas.height = h;
            //     canvas.getContext("2d").drawImage(img, 0, 0, w, h);
            //     // Now save as png or whatever
            //
            //     $('body').append('<a download="graph.png" href="' + canvas.toDataURL() + '"></a>');
            //     var tar = $('<a></a>');
            //     var filename = "graph.png";
            //     if (window.navigator.msSaveBlob) { // IE 10+
            //         //alert('IE' + csv);
            //         window.navigator.msSaveOrOpenBlob(new Blob([canvas.toDataURL().replace('data:image/png;base64,', '')], {type: "text/plain;charset=utf-8;"}), filename)
            //     }
            //     else {
            //         console.error(canvas.toDataURL());
            //         tar.attr({
            //             'download': filename,
            //             'href': canvas.toDataURL().replace(/^data:image\/(png|jpg);base64,/, 'data:application/'),
            //             'target': '_blank'
            //         });
            //         $('body').append(tar);
            //         tar[0].click();
            //         console.error('tar');
            //
            //     }
            // }

            // var nWin = function () {
            var newWindow = window.open();
            // var html = $(tmpGraphContainer).html();
            //
            // $(newWindow.document.body).html(html);
            console.log('1');
            svg = d3.select('.tmp-graph-container>svg')[0][0];
            img = new Image();
            serializer = new XMLSerializer();
            svgStr = serializer.serializeToString(svg);

            /*var doctype = '<?xml version="1.0" standalone="no"?>'
             + '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">';

             // serialize our SVG XML to a string.
             var source = (new XMLSerializer()).serializeToString(d3.select('svg').node());

             // create a file blob of our SVG.
             var blob = new Blob([ doctype + source], { type: 'image/svg+xml;charset=utf-8' });

             var url = window.URL.createObjectURL(blob);

             // Put the svg into an image tag so that the Canvas element can read it in.
             var img = d3.select('body').append('img')
             .attr('width', 100)
             .attr('height', 100)
             .node();


             img.onload = function(){
             // Now that the image has loaded, put the image into a canvas element.
             var canvas = d3.select('body').append('canvas').node();
             canvas.width = 100;
             canvas.height = 100;
             var ctx = canvas.getContext('2d');
             ctx.drawImage(img, 0, 0);
             var canvasUrl = canvas.toDataURL("image/png");
             var img2 = d3.select('body').append('img')
             .attr('width', 100)
             .attr('height', 100)
             .node();
             // this is now the base64 encoded version of our PNG! you could optionally
             // redirect the user to download the PNG by sending them to the url with
             // `window.location.href= canvasUrl`.
             img2.src = canvasUrl;
             }
             // start loading the image.
             img.src = url;*/

            img.src = 'data:image/svg+xml;base64,' + jQuery.base64.encode(svgStr);
            console.log(img.src);
            // img.src = 'data:image/svg+xml;base64,' + window.btoa(svgStr);
            // img.src = 'data:image/svg+xml;base64,' + svgStr;

            // You could also use the actual string without base64 encoding it:
            //img.src = "data:image/svg+xml;utf8," + svgStr;

            /*var svg = document.querySelector('svg');
             var serializer = new XMLSerializer();
             var svgString = serializer.serializeToString(svg);
             var canvas = document.getElementById("test");
             canvg(canvas, svgString);*/

            img.onload = function () {

                console.log('a');
                var canvas = newWindow.document.createElement("canvas");
                console.log('b');
                newWindow.document.body.appendChild(canvas);
                console.log('c');
                canvas.width = w;
                canvas.height = h;
                canvas.getContext('2d').drawImage(img, 0, 0, w, h);
                console.log('d');
                // newWindow.document.write("<img src='" + img.src + "'/>");
                // console.error(canvas.toDataURL());
                // var a = newWindow.document.createElement("a");
                // a.download = "graph.png";
                // a.href = canvas.toDataURL("image/png");
                // a.click();
                $('.tmp-graph-container').remove();
            };


            // }();
            // return w;
        }


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
                    // console.error(d[name]);
                    if (option.data[i][name] != undefined) {
                        return;
                    }
                    option.data[i][name] = d[name];

                    if (i != 0) {
                        option.totalData[i][name] = parseInt(option.totalData[i - 1][name]) + parseInt(d[name]);
                    } else {
                        option.totalData[i][name] = parseInt(d[name]);
                    }
                    // addColor();
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
                    graphContainer.find('.graph-overall-container').remove();
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
            getGraphContainer: function () {
                return graphContainer
            },
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
                    // graphContainer.find('.graph-overall-container').remove();
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
                    if (option.graphOverall) {
                        setGraphOverall();
                    }

                    svg.on('click', function(){
                       openWithNewWindow();
                    });
                }
            },
            getNameList: function () {
                return option.nameList;
            },
            deleteGraphOverall: function () {
                graphContainer.find('.graph-overall-container').remove();
            },
            init: init,
            openWithNewWindow: openWithNewWindow
        }
    });

    return {
        graph: graph
    }
})();