function mapRouteEntity(start, end) { 
	this.start = start;
	this.end = end;
	// Initialize routes data
	this.routes = new Map();

	this.getResponse = function(key) {
		return this.routes.get(key);
	}

	this.setDriving = function(response) {
		this.routes.set("DRIVING", response);
	}

	this.setTransit = function(response) {
		this.routes.set("TRANSIT", response);
	}

	this.setBicycling = function(response) {
		this.routes.set("BICYCLING", response);
	}

	this.setWalking = function(response) {
		this.routes.set("WALKING", response);
	}
};