//= require datetime.js
$(document).ready(function() {
  $('.timepicker').timepicker({
    hourGrid: 4,
    minuteGrid: 10,
    timeFormat: 'HH:mm',
    hourMax: 20,
    hourMin: 6,
    closeText: '关闭'
  });
});
