setInterval(function(){
  $("#answer_time").val(parseInt($("#answer_time").val(), 10) + 1);
}, 1000);

$(document).ready(function(){
  $(".review-form").bind("ajax:success",
    function(){
      $.ajax({
        url: "/",
        dataType: "script"
      });
    }
  );
});
