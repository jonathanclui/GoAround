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

// Listeners to change the color of the active item in uber panel
$(document).on("mouseover", "#uberX", function() {
	setActiveUberClass(this);
	drawUberInfo("uberX");
});
$(document).on("mouseover", "#uberXL", function() {
	setActiveUberClass(this);
	drawUberInfo("uberXL");
});
$(document).on("mouseover", "#UberBLACK", function() {
	setActiveUberClass(this);
	drawUberInfo("UberBLACK");
});
$(document).on("mouseover", "#UberSUV", function() {
	setActiveUberClass(this);
	drawUberInfo("UberSUV");
});
$(document).on("mouseover", "#uberTAXI", function() {
	setActiveUberClass(this);
	drawUberInfo("uberTAXI");
});
$(document).on("mouseover", "#uberPLUS", function() {
	setActiveUberClass(this);
	drawUberInfo("uberPLUS");
});
$(document).on("mouseover", "#UberLUX", function() {
	setActiveUberClass(this);
	drawUberInfo("UberLUX");
});
