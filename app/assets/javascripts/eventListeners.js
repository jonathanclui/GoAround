// Add listeners after the page loads for the map
$(document).ready(function() { 
	setActiveClass = function(newActive) {
		$("li.active").removeClass("active");
		$(newActive).addClass("active");
	};

	// Add an event listener to submit query when enter key is pressed and focus is in either start or end box
	window.addEventListener("keypress", function(e) {
		if (e.which == 13 && (($(':focus').activeElement == $("#start_input").activeElement) || ($(':focus').activeElement == $("#end_input").activeElement))) {
			populateResultsFromUser();
		}
	});

	// Listeners to change the color of the active item
	$("#drivingResults").mouseover(function() {
		setActiveClass(this);

		var mode = "DRIVING";
		populateResults(mode);
	});
	$("#publicTransitResults").mouseover(function() {
		setActiveClass(this);

		var mode = "TRANSIT";
		populateResults(mode);
	});
	$("#uberResults").mouseover(function() {
		setActiveClass(this);
	});
	$("#bikingResults").mouseover(function() {
		setActiveClass(this);

		var mode = "BICYCLING";
		populateResults(mode);
	});
	$("#walkingResults").mouseover(function() {
		setActiveClass(this);

		var mode = "WALKING";
		populateResults(mode);
	});
});

// Resize the map when scrolling down to see it
$(document).scroll(function() {
	google.maps.event.trigger(map, "resize");
});