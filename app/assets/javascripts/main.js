function showModal(object) {
  var id = $(object).data("id");
  var date = $(object).data("date");
  var time_in = $(object).data("time-in");
  var time_out = $(object).data("time-out");
  $(".date-attendance").val(date);
  $(".time-in-attendance").val(time_in);
  $(".time-out-attendance").val(time_out);
  $("#form-attendance").attr("action", "/attendances/" + id);
}
