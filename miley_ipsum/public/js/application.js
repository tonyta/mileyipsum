$(document).ready(function() {
  $('#ipsum-button').on('click', function(){
    $.get('/ipsum', function(response) {
      console.log(response);
      $('#ipsums').html(response);
    })
    $("html").css({overflow: "visible"});
  })


});
