// Global variables to initialize for Google Maps
var directionsService = new google.maps.DirectionsService();
var directionsDisplay;
var map;
var geocoder;
var startSearchBox;
var endSearchBox;

// Variable for mapRouteEntity to store route data
var lastRoute;

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

	// Initialize the search box for autocomplete
	startSearchBox = new google.maps.places.SearchBox(document.getElementById("start_input"));
	endSearchBox = new google.maps.places.SearchBox(document.getElementById("end_input"));
	startSearchBox.bindTo('bounds', map);
	endSearchBox.bindTo('bounds', map);

	// Initialize the mapRouteEntity
	lastRoute = new mapRouteEntity("", "");

	// Initialize uberRouteEntity
	uberRoute = new uberRouteEntity(startLocation, endLocation);
}

var findDirectionsFromGeolocation = function(mode) {
	start = document.getElementById("start_input").value;
	end = document.getElementById("end_input").value;

	// Reset the Directions Display Panel
	directionsDisplay.setPanel(document.getElementById('directionsPanel'));

	if ((start !== lastRoute.start) || (end !== lastRoute.end)) {
		// Brand new search
		lastRoute.start = start;
		lastRoute.end = end;

		var drivingRequest = {
  			origin: start,
  			destination: end,
      		travelMode: google.maps.TravelMode["DRIVING"]
	  	};
	  	var transitRequest = {
	  		origin: start,
	  		destination: end,
	      	travelMode: google.maps.TravelMode["TRANSIT"]
	  	};
	  	var bicyclingRequest = {
	  		origin: start,
	  		destination: end,
	      	travelMode: google.maps.TravelMode["BICYCLING"]
	  	};
	  	var walkingRequest = {
	  		origin: start,
	  		destination: end,
	      	travelMode: google.maps.TravelMode["WALKING"]
	  	};

	  	directionsService.route(drivingRequest, function(response, status) {
	    	if (status == google.maps.DirectionsStatus.OK) {
	    		directionsDisplay.setDirections(response);
	    		lastRoute.setDriving(response);
	    		tripDuration = getTripDuration(response);
	      		$("#drivingDuration").html(tripDuration);
	      		$("#uberDuration").html(tripDuration);

	      		// On a new request we always default the display to be "Driving"
	      		setActiveClass("#drivingResults");
	    	}
	  	});
	  	directionsService.route(transitRequest, function(response, status) {
	    	if (status == google.maps.DirectionsStatus.OK) {
	    		lastRoute.setTransit(response);
	      		$("#publicTransitDuration").html(getTripDuration(response));
	      		var fare = getTripFare(response);
	      		if (fare != null) {
	      			$("#publicTransitFare").html("$" + parseFloat(fare).toFixed(2));
	      		} else {
	      			$("#publicTransitFare").empty();
	      		}
	    	}
	  	});
	  	directionsService.route(bicyclingRequest, function(response, status) {
	    	if (status == google.maps.DirectionsStatus.OK) {
	      		lastRoute.setBicycling(response);
	      		$("#bikingDuration").html(getTripDuration(response));
	    	}
	  	});
	  	directionsService.route(walkingRequest, function(response, status) {
	    	if (status == google.maps.DirectionsStatus.OK) {
	      		lastRoute.setWalking(response);
	      		$("#walkingDuration").html(getTripDuration(response));
	    	}
	  	});
	} else {
		var response = lastRoute.getResponse(mode);
		if (response != null) {
			directionsDisplay.setDirections(response);
		}
	}
}

var getTripDuration = function(response) {
	var durationInSecs = response.routes[0].legs[0].duration.value;
	return Math.ceil(durationInSecs / 60.0);
}

var getTripFare = function(response) {
	var tripFare = null;
	try {
		tripFare = response.routes[0].fare.value;
	} catch (err) {
	}
	return tripFare;
}

var geocodeInput = function() {
	var start = document.getElementById('start_input').value;
	var end = document.getElementById('end_input').value;
	// Geocode the start to display
	geocoder.geocode( { 'address': start }, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			startLocation = [getGeocodeLatitude(results), getGeocodeLongitude(results)];
			uberRoute.setStart(startLocation);
		} else {
			// Unsuccessful geocode
		}
		startGeolocDeferred.resolve();
	});

	// Geocode the end to display
	geocoder.geocode( { 'address': end }, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			endLocation = [getGeocodeLatitude(results), getGeocodeLongitude(results)];
			uberRoute.setEnd(endLocation);
		} else {
			// Unsuccesful geocode
		}
		endGeolocDeferred.resolve();
	});
}

function getGeocodeLatitude(result) {
	return result[0].geometry.location.lat();
}

function getGeocodeLongitude(result) {
	return result[0].geometry.location.lng();
}

google.maps.event.addDomListener(window, 'load', initialize);