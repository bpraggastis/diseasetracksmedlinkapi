$(function(){

  var map;
  var markers = [];

  function initialize() {

    var mapElement = $("#map-canvas");

    var latitude = parseFloat(mapElement.attr('data-center-latitude'));
    var longitude = parseFloat(mapElement.attr('data-center-longitude'));

    var latLng = new google.maps.LatLng(latitude,longitude)
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
    map = new google.maps.Map(document.getElementById('map-canvas'),
        mapOptions);

    // var marker = new google.maps.Marker({
    //   position: new google.maps.LatLng(latitude, longitude),
    //   map: map
    // });
  }

  var place_marker = function(e){
    var new_mark = $(e.target);
    var latitude = parseFloat(new_mark.attr('data-latitude'));
    var longitude = parseFloat(new_mark.attr('data-longitude'));

    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(latitude, longitude),
    });
    marker.setMap(map);
    markers.push(marker)
  };

  var clear_markers = function(){
    for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
    };
    markers = [];
  }

  $(".location-marker").click(place_marker);
  $(".clear-markers").click(clear_markers);

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
