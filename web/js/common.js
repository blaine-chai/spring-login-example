function stringCheck(str) {
    var blank_pattern = /^\s+|\s+$/g;
    if (str.replace(blank_pattern, '') == "") {
        // alert('닉네임을 다시 입력해주세요.');
        return false;
    }
    return true;
}