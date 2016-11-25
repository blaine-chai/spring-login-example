var BookmarkTableModule = (function () {

    var getModule = function (opt) {
        var defaults = {
            width: '100%',
            height: '100%',
            title: '',
            template: '<div class="panel panel-default" style="width: 100%;height: 100%;margin: 0;">' +
            '<div id="" class="bookmark-title" style="border-bottom: 1px solid #ddd;width: 100%;text-align: center;font-size: 16px;vertical-align: middle;">' +
            '<h4>User Bookmark Alarm</h4>' +
            '</div>' +
            '<div id="" style="overflow-y: scroll;height: calc(100% - 40px);">' +
            '<table class="table table-hover table-condensed" style="margin-bottom: 0;border-top: 0;font-size: 12px;">' +
            '<thead></thead>' +
            '<tbody></tbody>' +
            '</table>' +
            '</div>' +
            '</div>',
            header: '',
            data: [],
            tBodyGenerator: function () {

            },
            tHeadGenerator: function () {
            },
            container: $('body')
        };

        var option = $.extend(defaults, opt);

        var container = option.container;

        var init = function () {
            var template=$(option.template);
            template.find('.bookmark-title').find('h4').text(option.title);
            container.append(template);
        };

        var refresh = function () {

        };

        return {
            setWidth: function (width) {
                option.width = width;
            },
            getWidth: function () {
                return option.width
            },
            setHeight: function (height) {
                option.height = height;
            },
            getHeight: function () {
                return option.height
            },

            setTitle: function (title) {
                option.title = title;
            },
            getTitle: function () {
                return option.title
            },

            setTemplate: function (template) {
                option.template = template;
            },

            setContainer: function (c) {
                option.container = c;
                container = option.container;
            },
            getContainer: function () {
                return container;
            },

            setTBodyGenerator: function (fn) {
                option.tBodyGenerator = fn;
            },
            getTBodyGenerator: function () {
                return option.tBodyGenerator;
            },
            generateTBody: function () {
                option.tBodyGenerator();
            },
            setTHeadGenerator: function (fn) {
                option.tHeadGenerator = fn;
            },
            getTHeadGenerator: function () {
                return option.tHeadGenerator;
            },
            generateTHead: function () {
                option.tHeadGenerator();
            },

            removeTableContent: function () {
                container.find('tbody').children().remove();
            },
            getData: function () {
                return option.data;
            },
            removeData: function () {
                option.data = [];
            },
            setData: function (d) {
                option.data = d;
            },
            init: init
        }
    };

    return {
        getModule: getModule
    };
})();
