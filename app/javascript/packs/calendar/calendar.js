import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import moment from "moment"

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, interactionPlugin ],

    events: '/events.json',

  //細かな表示設定
    dayCellContent: function(e) {
    e.dayNumberText = e.dayNumberText.replace('日', ''); //日を表示させない
    },
    locale: 'ja',
    timeZone: 'Asia/Tokyo',
    firstDay: 1,
    headerToolbar: {
      start: '',
      center: 'title',
      end: 'today prev,next'
    },
    expandRows: true,
    stickyHeaderDates: true,
    buttonText: {
       today: '今日'
    },
    allDayText: '終日',
    height: "auto",
    editable: true, //イベントのドラッグ＆ドロップを許可
    navLinks: true,
    eventColor: '#1a73e8',
    eventDisplay: "block", // 日を跨がない場合でもイベントをセルで表示


    dateClick: function(info){
      //クリックした日付の情報を取得
      const year  = info.date.getFullYear();
      const month = (info.date.getMonth() + 1);
      const day   = info.date.getDate();

      // クリックした日付に書き換えている
      $('#event_start_1i').val(year);
      $('#event_end_1i').val(year);
      $('#event_start_2i').val(month);
      $('#event_end_2i').val(month);
      $('#event_start_3i').val(day);
      $('#event_end_3i').val(day + 1);

      //Bootstrapでモーダルを表示させる
      $('#modal_event').modal('show');

    },

    eventDrop: function (info) {
      $.ajax({
        //POST通信
        type: "patch",
        //ここでデータの送信先URLを指定します。
        url: "events/" + info.event.id + "/move_update",
        dataType: "json", //データ形式を指定
        data: {
          update_start: moment.utc(info.event.start).format("YYYY-MM-DDTHH:mm:ss"), //update_startをキーにして値を送信
          update_end: moment.utc(info.event.end).format("YYYY-MM-DDTHH:mm:ss"),
          id: info.event.id, //idをキーにして値を送信
        },
      }).then((res) => {
        console.log(res);
        calendar.render();
      });
    },
  });

  calendar.render();

  $(".error").click(function(){
        calendar.refetchEvents();
  });
});
