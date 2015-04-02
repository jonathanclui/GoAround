// Global Variables
var startLocation = [];
var endLocation = [];

populateResults = function(mode) {
	// Initialize Deferred Objects
	startGeolocDeferred = $.Deferred();
	endGeolocDeferred = $.Deferred();

	// Geocode user inputs for uber
	geocodeInput();

	// Populate Google Maps Data
	findDirectionsFromGeolocation(mode);

	// Call Uber once Geolocation is complete
	$.when(startGeolocDeferred, endGeolocDeferred).done(function() {
		//getPriceEstimates();
		//getTimeEstimates();
		//getProductTypes();
	});
}

/* Populates the results list items from a user submission */
var populateResultsFromUser = function() {
	var mode = "DRIVING";
	populateResults("mode");
}
