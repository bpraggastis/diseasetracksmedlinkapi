$(function(){

  var map;
  var markers = [];

  function initialize() {

    var mapElement = $("#map-canvas");

    var latitude = parseFloat(mapElement.attr('data-center-latitude'));
    var longitude = parseFloat(mapElement.attr('data-center-longitude'));

    var latLng = new google.maps.LatLng(latitude,longitude);
    var mapOptions = {
      center: latLng,
      zoom: 4,
      mapTypeControl: true,
      mapTypeControlOptions: {
          style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
          position: google.maps.ControlPosition.BOTTOM_CENTER
      },
      zoomControl: true,
      zoomControlOptions: {
          style: google.maps.ZoomControlStyle.SMALL,
          position: google.maps.ControlPosition.RIGHT_TOP
      },
      panControl: true,
      panControlOptions: {
        position: google.maps.ControlPosition. RIGHT_TOP
      }
    };
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);



  }
  // ends initialize


  var content_string = function(my_content){ string = '<h4>'+ my_content + '</h4>' +
                        '<button href="#" + class="remove-marker">Remove Marker</button>';
                        return string;
  };



  var myInfoWindow = function(my_content, my_marker){
    var infowindow = new google.maps.InfoWindow({
      content: content_string(my_content),
    });
    console.log(my_marker.__gm_id);
    infowindow.open(map,my_marker);
    $('.remove-marker').click(function(my_marker){
      console.log('made it here');
      my_marker.setMap(null);
    });
  };

  var make_mark = function(event){
    var latitude = parseFloat(event.attr('data-latitude'));
    var longitude = parseFloat(event.attr('data-longitude'));
    var id = parseInt(event.attr('data-event-id'));
    var disease = event.attr('data-disease');

    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(latitude,longitude),
      event_id: id,
      event_disease: disease,
    });
    console.log(marker.event_id, marker.event_disease, marker.__gm_id);
    marker.setMap(map);
    markers.push(marker);
    // google.maps.event.addListener(marker, 'click',function(){
    //   console.log("clicked marker");
    google.maps.event.addListener(marker, 'click', function(e){
      myInfoWindow(marker.event_disease, marker);
    });

  };

  var place_marker = function(e){
    var new_mark = $(e.target);
    make_mark(new_mark);
  };

  var auto_marks = function(){
    var spots = $(".place-marker").children(".location-marker");
    spots.each(function(){
      latitude = parseFloat(this.getAttribute('data-latitude'));
      longitude = parseFloat(this.getAttribute('data-longitude'));
      event_id = this.
      make_mark(this);
    });
  };

  var clear_markers = function(){
    for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
    }
    markers = [];
  };

  var remove_marker = function(e){
    var index = markers.indexOf(e);
  };


  $(".location-marker").click(place_marker);
  $(".clear-markers").click(clear_markers);
  $(".auto-mark").click(auto_marks);
  $(".remove-marker").click(remove_marker);

  google.maps.event.addDomListener(window, 'load', initialize);

});
//
//   // var latitude =  -25.363882;
//   // var longitude = 131.044922;
//
//   var place_marker = function(e){
//     var latitude = $(e.target).dataset.latitude;
//     var longitude = $(e.target).dataset.longitude;
//
//     var marker = new google.maps.Marker({
//       position: new google.maps.LatLng(latitude, longitude),
//       map: map
//     });
//   };
//
//   var initialize = function(){
//     var myLatlng = new google.maps.LatLng(-25.363882,131.044922);
//     // var myLatlng = new google.maps.LatLng(latitude, longitude);
//     var mapOptions = {
//       zoom: 2,
//       center: myLatlng
//     };
//     var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
//   };
//
//   document.addEventListener('click', place_marker);
//   //
//   // var myLatlng = new google.maps.LatLng(-25.363882,131.044922);
//   // // var myLatlng = new google.maps.LatLng(latitude, longitude);
//   // var mapOptions = {
//   //   zoom: 4,
//   //   center: myLatlng
//   // };
//   // var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
//
//   // To add the marker to the map, use the 'map' property
// //   var marker = new google.maps.Marker({
// //       position: myLatlng,
// //       map: map
// });
//
//
//
//
//
//
// });
//
//
