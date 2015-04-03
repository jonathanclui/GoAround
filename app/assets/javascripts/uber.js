// Uber API Keys for development
var uberClientId = "Q3U62L8ey6cHXN4w_Zm9oUf31ZzM03Fd";
var uberServerToken = "KcAW5MPZORiQ3dWyihu6NIwGQWg0D97ZO543oEiw";

var uberRoute;

// Processing Uber API Calls
renderUberResults = function() {
	// Unbind the directions text in the panel and remove all styles
	directionsDisplay.setPanel(null);
	$("#directionsPanel").removeAttr('style');

	$("#directionsPanel").html("<div id='uberResultsInfo'></div>");

	var content = "";

	var prod = uberRoute.getProductsEndpoint().products;
	var price = uberRoute.getPriceEndpoint().prices;
	var time = uberRoute.getTimeEndpoint().times;
	// Loop through product types and generate html
	for (i = 0; i < prod.length; i++) {
		//console.log(prod[i].image);

		var displayName = prod[i].display_name;
		var lowEstimate;
		var highEstimate;
		// Search Products for price ranges
		for (j = 0; j < price.length; j++) {
			var curRoute = price[j];
			if (curRoute.display_name === displayName) {
				lowEstimate = curRoute.low_estimate;
				highEstimate = curRoute.high_estimate;
			}
		}

		// Search Time Estimates for estimates
		var estimatedTime = null;
		for (k = 0; k < time.length; k++) {
			if (time[k].display_name == displayName) {
				estimatedTime = getTimeInMins(time[k].estimate);
			}
		}
		content += generateUberListItem(displayName, lowEstimate, highEstimate, estimatedTime);
	}

	// Draw the slogan for the car type
	content += "<div id='uberSloganHolder'><h2 id='uberSlogan'>" + prod[0].description + "</h2></div>";

	// Draw the uber car 
	content += "<div id='uberDetails'><img id='uberCarImage' src='http://d1a3f4spazzrp4.cloudfront.net/car-types/mono/mono-uberx.png' alt='Uber'></div>";

	// Draw the capacity
	content += "<div id='uberCapacityHolder'><h2 id='uberCapacity'>Capacity of " + prod[0].capacity + " people </h2></div>";

	// Draw the button in a div
	content += "<div id='requestBtnHolder'><button type='button' class='btn btn-primary' id='requestBtn' disabled>" +
		"Request " + prod[0].display_name + "</button><button type='button' class='btn btn-default' id='cancelBtn' disabled>Cancel</button></div>";
	
	$("#uberResultsInfo").html(content);

	// Set the first item as the active uber item
	$("#"+prod[0].display_name).addClass("uberActive");
}

generateUberListItem = function(uberType, uberPriceLow, uberPriceHigh, uberTime) { 
	var priceText;
	var arrivalText;
	var arrivalUnit = "";
	if (uberTime == null) {
		arrivalText = "Not Available";
	} else {
		arrivalText = "Arriving in " + uberTime;
		arrivalUnit = "mins";
	}

	if (uberType == "uberTAXI") {
		priceText = "Metered";
	} else {
		priceText = "$" + uberPriceLow + "-" + "$" + uberPriceHigh;
	}

	return "<li id='" + uberType + "'><div class='tripImage' id='" + uberType + "Image'><span>" + 
		uberType + "</span></div><div class='uberProperties'><span class='uberPrice'>" + priceText 
		+ "</span><span class='uberLength'>" +"<span class='arrivalTime' id='" + uberType + 
		"ArrivalTime'>" + arrivalText + "</span><span class='arrivalUnit' id='" + 
		uberType + "ArrivalUnit'>" + arrivalUnit + "</span></span></div></li>";
}

getTimeInMins = function(time) {
	return Math.ceil(time / 60.0);
}

clearUberResults = function() {
	$("#uberResultsInfo").empty();
}

drawUberInfo = function(type) {
	var prod = uberRoute.getProductsEndpoint().products;
	for (i = 0; i < prod.length; i++) {
		if (prod[i].display_name === type) {
			// Draw the slogan for the car type
			var newSlogan = "<h2 id='uberSlogan'>" + prod[i].description + "</h2>";
			$('#uberSlogan').replaceWith(newSlogan);

			// Draw the uber car 
			var newCarImage = "<img id='uberCarImage' src='" + prod[i].image + "' alt='Uber'>";
			$('#uberCarImage').replaceWith(newCarImage);

			// Draw the capacity
			var newUberCapacity = "<h2 id='uberCapacity'>Capacity of " + prod[i].capacity + " people </h2>";
			$('#uberCapacity').replaceWith(newUberCapacity);

			$("#requestBtn").html("Request " + prod[i].display_name);
		}
	}
}

// Uber API Calls to Uber Server
getUberData = function(startLocation, endLocation) {
	getProductTypes(startLocation);
	getPriceEstimates(startLocation, endLocation);
	getTimeEstimates(startLocation);
}
getProductTypes = function(startLocation) {
	// Call Uber API for product types
	$.ajax({
		url: "https://api.uber.com/v1/products",
	    headers: {
	    	Authorization: "Token " + uberServerToken
	    },
	    data: { 
	    	latitude: startLocation[LAT],
	        longitude: startLocation[LONG]
	    },
	    success: function(result) {
	    	// Result is the result of the API call
	    	uberRoute.setProductsEndpoint(result);
	    }
	});
}

getPriceEstimates = function(startLocation, endLocation) {
	// Call Uber API for price estimates
	$.ajax({
		url: "https://api.uber.com/v1/estimates/price",
	    headers: {
	    	Authorization: "Token " + uberServerToken
	    },
	    data: { 
	    	start_latitude: startLocation[LAT],
	        start_longitude: startLocation[LONG],
	        end_latitude: endLocation[LAT],
	        end_longitude: endLocation[LONG]
	    },
	    success: function(result) {
	    	// Result is the result of the API call
	    	uberRoute.setPriceEndpoint(result);
	    }
	});
}

getTimeEstimates = function(startLocation) {
	  // Call Uber API for time estimates
	  $.ajax({
	  	url: "https://api.uber.com/v1/estimates/time",
	    headers: {
	    	Authorization: "Token " + uberServerToken
	    },
	    data: { 
	        start_latitude: startLocation[LAT],
	        start_longitude: startLocation[LONG]
	    },
	    success: function(result) {
	        // Result is the result of the API call
	        uberRoute.setTimeEndpoint(result);
	    }
	});
}
