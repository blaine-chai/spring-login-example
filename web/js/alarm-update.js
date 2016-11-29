// $(document).ready(function(){
//     var AlarmUpdateModule = function () {
//         setInterval(function () {
//             $.ajax({
//                 url: '/main/alarm/get-alarm-count',
//                 type: 'post',
//                 data: {},
//                 success: function (responseData) {
//                     if (parseInt(responseData) <= 0) {
//                         $('.alarm-badge').hide();
//                     } else {
//                         $('.alarm-badge').text(responseData).show(200);
//                     }
//                 }
//             });
//         }, 500)
//     }();
// });
