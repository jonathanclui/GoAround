// Global Variables
var startLocation = [];
var endLocation = [];

// Search Latitude and Longitudes
var LAT = 0;
var LONG = 1;

// Deferred objects
var startGeolocDeferred;
var endGeolocDeferred; 

populateResults = function(mode) {
	// Initialize Deferred Objects
	startGeolocDeferred = $.Deferred();
	endGeolocDeferred = $.Deferred();

	// Geocode user inputs for uber
	geocodeInput();

	// Populate Google Maps Data
	if (mode !== "UBER") {
		findDirectionsFromGeolocation(mode);
	}

	// Call Uber once Geolocation is complete
	$.when(startGeolocDeferred, endGeolocDeferred).done(function() {
		if (startLocation.length === 2 && endLocation.length === 2) {
			// Set new start and end routes
			uberRoute.setStart(startLocation);
			uberRoute.setEnd(endLocation);

			//Make backend API Calls to Uber Server
			getUberData(startLocation, endLocation);

			// If hovering over Uber list item, render results
			if (mode === "UBER") {
				var response = lastRoute.getResponse("DRIVING");
				if (response !== null) {
					directionsDisplay.setDirections(response);
					renderUberResults();
				}
			} else {
				clearUberResults();
			}
		}
	});
}

/* Populates the results list items from a user submission */
var populateResultsFromUser = function() {
	var mode = "DRIVING";
	populateResults("mode");
}
