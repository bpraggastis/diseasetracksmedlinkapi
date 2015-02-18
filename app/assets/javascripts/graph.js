$(document).ready(function() {

  var graph_trigger = function(){
    if ($("#graph").css("height") == "0px") {
      $("#graph").css("height", "350px");
      $("#map-canvas").css("width", "auto");
    } else {
      $("#graph").css("height", "0px");
      $("#map-canvas").css("width", "100%");
    }
  };

  $(".graph-trigger").click(graph_trigger);

  

});
