$(function () {
  $('input[name="period[period_id]"]:radio').change(function () {
    var radioval = $(this).val();
    window.location.href = `/ranking?period=${radioval}`;
  });
});
