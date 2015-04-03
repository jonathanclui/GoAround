function uberRouteEntity(start, end) {
	// start and end have [lat, lng] format
	this.start = start;
	this.end = end;

	// map of product, price, and time data
	this.endPoints = new Map();

	this.getStart = function() {
		return this.start;
	}

	this.setStart = function(start) {
		this.start = start;
	}

	this.getEnd = function() {
		return this.end;
	}

	this.setEnd = function(end) {
		this.end = end;
	}

	this.getEndpoints = function() {
		return this.endPoints;
	}

	this.getProductsEndpoint = function() {
		return this.endPoints.get("PRODUCTS");
	}

	this.getPriceEndpoint = function() {
		return this.endPoints.get("PRICE");
	}

	this.getTimeEndpoint = function() {
		return this.endPoints.get("TIME");
	}

	this.setProductsEndpoint = function(result) {
		this.endPoints.set("PRODUCTS", result);
	}

	this.setPriceEndpoint = function(result) {
		this.endPoints.set("PRICE", result);
	}

	this.setTimeEndpoint = function(result) {
		this.endPoints.set("TIME", result);
	}
};