// Uber API Keys
var uberClientId = "Q3U62L8ey6cHXN4w_Zm9oUf31ZzM03Fd";
var uberServerToken = "KcAW5MPZORiQ3dWyihu6NIwGQWg0D97ZO543oEiw";

getProductTypes = function(lat, long) {
	// Call Uber API for price estimates
	$.ajax({
		url: "https://api.uber.com/v1/products",
	    headers: {
	    	Authorization: "Token " + uberServerToken
	    },
	    data: { 
	    	latitude: startLocation[LAT],
	        longitude: startLocation[LONG],
	    },
	    success: function(result) {
	    	// Result is the result of the API call
	    	console.log(result);
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
	    	console.log(result);
	    }
	});
}

getTimeEstimates = function(startLat, startLong) {
	  // Call Uber API for time estimates
	  $.ajax({
	  	url: "https://api.uber.com/v1/estimates/time",
	    headers: {
	    	Authorization: "Token " + uberServerToken
	    },
	    data: { 
	        start_latitude: startLocation[LAT],
	        start_longitude: startLocation[LONG],
	    },
	    success: function(result) {
	        // Result is the result of the API call
	        console.log(result);
	    }
	});
}