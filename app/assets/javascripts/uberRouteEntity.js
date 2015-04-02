function uberRouteEntity(start, end) {
	// attributes and variables
	this.start = start;
	this.end = end;

	this.endPoints = new Map();

	function getStart() {
		return this.start;
	}

	function setStart(start) {
		this.start = start;
	}

	function getEnd() {
		return this.end;
	}

	function setEnd(end) {
		this.end = end;
	}
}