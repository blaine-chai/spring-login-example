var LogOutTimer = function () {
    var S = {
        timer: null,
        // limit : 1000 * 60 * 5,
        limit: 1000,
        fnc: function () {
        },
        start: function () {
            S.timer = window.setTimeout(S.fnc, S.limit);
        },
        reset: function () {
            window.clearTimeout(S.timer);
            S.start();
        }
    };

    document.onmousemove = function () {
        S.reset();
    };

    return S;
}();

LogOutTimer.limit = 1000 * 60 * 15;

LogOutTimer.fnc = function () {
    window.location.replace('/logout');
};

LogOutTimer.start();
