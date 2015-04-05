setActiveClass = function(newActive) {
	$("li.active").removeClass("active");
	$(newActive).addClass("active");
};

setActiveUberClass = function(newActive) {
	$("li.uberActive").removeClass("uberActive");
	$(newActive).addClass("uberActive");
};

window.addEventListener("keypress", function(e) {
	if (e.which == 13 && (($(':focus').activeElement == $("#start_input").activeElement) || ($(':focus').activeElement == $("#end_input").activeElement))) {
		populateResultsFromUser();
	}
});

// Listeners to change the color of the active item
$(document).on('mouseover', "#drivingResults", function() {
	setActiveClass(this);

	var mode = "DRIVING";
	populateResults(mode);
});
$(document).on('mouseover', "#publicTransitResults", function() {
	setActiveClass(this);

	var mode = "TRANSIT";
	populateResults(mode);
});
$(document).on('mouseover', "#uberResults", function() {
	setActiveClass(this);

	var mode = "UBER";
	populateResults(mode);
});
$(document).on('mouseover', "#bikingResults", function() {
	setActiveClass(this);

	var mode = "BICYCLING";
	populateResults(mode);
});
$(document).on('mouseover', "#walkingResults", function() {
	setActiveClass(this);

	var mode = "WALKING";
	populateResults(mode);
});
