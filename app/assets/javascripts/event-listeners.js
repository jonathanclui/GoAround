// Resize the map when scrolling down to see it
$(document).scroll(function() {
	google.maps.event.trigger(map, "resize");
});

// Submit the request for results when enter is pressed
$(document).keypress(function(e) {
	if (e.which == 13 && (($(':focus').activeElement == $("#start_input").activeElement) || ($(':focus').activeElement == $("#end_input").activeElement))) {
		geocodeInput();
	}
})