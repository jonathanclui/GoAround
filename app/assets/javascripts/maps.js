// Global variables to initialize for Google Maps
var directionsService = new google.maps.DirectionsService();
var directionsDisplay;
var map;
var geocoder;

// Search Latitude and Longitudes
var LAT = 0;
var LONG = 1;
var startLocation = [37.7699298, -122.4469157];
var endLocation = [37.7683909618184, -122.51089453697205];

function initialize() {
	// Initialize the directions renderer
	directionsDisplay = new google.maps.DirectionsRenderer();

	// Initialize the geocoder
	geocoder = new google.maps.Geocoder();

	// Initialize the map to display 
	var mapOptions = {
	  center: { lat: 37.786606, lng: -122.401153},
	  zoom: 14,
	  mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	map = new google.maps.Map(document.getElementById('map-canvas'),
	    mapOptions);

	// Link the map to the directions renderer
	directionsDisplay.setMap(map);
	directionsDisplay.setPanel(document.getElementById('directionsPanel'));
}

function geocodeInput() {
	var start = document.getElementById('start_input').value;
	var end = document.getElementById('end_input').value;
	// Geocode the start to display
	geocoder.geocode( { 'address': start }, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			startLocation = [getGeocodeLatitude(results), getGeocodeLongitude(results)];
		} else {
			alert('Geocode was not successful for the following reason: ' + status);
		}
	});

	// Geocode the end to display
	geocoder.geocode( { 'address': end }, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			endLocation = [getGeocodeLatitude(results), getGeocodeLongitude(results)];
		} else {
			alert('Geocode was not successful for the following reason: ' + status);
		}
	});
}

// The "B" parameter specifies the longitude in Google Maps Geocode API
function getGeocodeLongitude(result) {
	return result[0]["geometry"]["location"]["B"];
}

// The "k" parameter specifies the latitude in the Google Maps Geocode API
function getGeocodeLatitude(result) {
	return result[0]["geometry"]["location"]["k"];
}

function calcRoute() {
  var selectedMode = document.getElementById("mode").value;
  var request = {
      origin: new google.maps.LatLng(startLocation[LAT], startLocation[LONG]),
      destination: new google.maps.LatLng(endLocation[LAT], endLocation[LONG]),
      // Note that Javascript allows us to access the constant
      // using square brackets and a string value as its
      // "property."
      travelMode: google.maps.TravelMode[selectedMode]
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    }
  });
}

google.maps.event.addDomListener(window, 'load', initialize);