
function svgToCanvas() {
    // Select the first svg element
    var svg = d3.select('svg')[0][0],
        img = new Image(),
        serializer = new XMLSerializer(),
        svgStr = serializer.serializeToString(svg);

    img.src = 'data:image/svg+xml;base64,' + window.btoa(svgStr);

    // You could also use the actual string without base64 encoding it:
    //img.src = "data:image/svg+xml;utf8," + svgStr;


    var canvas = document.createElement("canvas");
    document.body.appendChild(canvas);

    canvas.width = w;
    canvas.height = h;
    canvas.getContext("2d").drawImage(img, 0, 0, w, h);
    // Now save as png or whatever

    $('body').append('<a download="graph.png" href="' + canvas.toDataURL() + '"></a>');
    var tar = $('<a></a>');
    var filename = "hi.png";
    if (window.navigator.msSaveBlob) { // IE 10+
        //alert('IE' + csv);
        window.navigator.msSaveOrOpenBlob(new Blob([canvas.toDataURL().replace('data:image', '')], {type: "text/plain;charset=utf-8;"}), filename)
    }
    else {
        console.error(canvas.toDataURL());
        tar.attr({
            'download': filename,
            'href': canvas.toDataURL().replace(/^data:image\/(png|jpg);base64,/, 'data:application/'),
            'target': '_blank'
        });
        $('body').append(tar);
        tar[0].click();
        console.error('tar');

    }
}