$(function(){
  // var map;
  // function initialize() {
  //   var mapOptions = {
  //     zoom: 8,
  //     center: new google.maps.LatLng(-34.397, 150.644)
  //   };
  //   map = new google.maps.Map(document.getElementById('map-canvas'),
  //       mapOptions);
  //     }
  //
  // google.maps.event.addDomListener(window, 'load', initialize);

  var latitude =  -25.363882;
  var longitude = 131.044922;
  // var myLatlng = new google.maps.LatLng(-25.363882,131.044922);
  var myLatlng = new google.maps.LatLng(latitude, longitude);
  var mapOptions = {
    zoom: 4,
    center: myLatlng
  }
  var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

  // To add the marker to the map, use the 'map' property
  var marker = new google.maps.Marker({
      position: myLatlng,
      map: map
});






});
