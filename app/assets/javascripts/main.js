window.setTimeout(function() {
  $(".alert").fadeTo(500, 0).slideUp(500, function() {
    $(this).remove();
  });
}, 3000);

function showAttendanceOnCalendar(this_month, attendances) {
  $(".responsive-calendar").responsiveCalendar({
    time: this_month,
    events: attendances
  });
};

function showModal(data) {
  $(document).on("click", ".day.active", function(event) {
    $("#attendance_modal").modal("show");
    var year = $(this).children("a").data("year");
    var month = $(this).children("a").data("month");
    var day = $(this).children("a").data("day");
    if (month < 10) month = "0" + month;
    if (day < 10) day = "0" + day;
    var date = year + "-" + month + "-" + day;
    $(".date-attendance").val(date);
    $(".time-in-attendance").val(data[date].time_in);
    $(".time-out-attendance").val(data[date].time_out);
    $("#form-attendance").attr("action", "/admin/attendances/" + data[date].id);
    $(".delete-attendance").attr("href", "/admin/attendances/" + data[date].id);
  });
};
