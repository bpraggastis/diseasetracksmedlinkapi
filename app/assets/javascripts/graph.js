$(document).ready(function() {
  var button = $("#graph-trigger");
  // console.log(button);
  button.click(function(){
    if ($("#graph").css("height") == "0px") {
      $("#graph").css("height", 350);
      $("#map-canvas").css("width", "auto");
    } else {
      $("#graph").css("height", 0);
      $("#map-canvas").css("width", "100%");
    }
  });
});
