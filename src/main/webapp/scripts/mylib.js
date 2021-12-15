function goLogin() {
	if (window.location.href.includes('home') && !window.location.href.includes('seller') && !window.location.href.includes('admin')){
		window.location.href = contextPath + "/login";
	}
	else {
		window.location.href = contextPath + "/login?returnUrl=" + window.location.href;
	}
}

function filterSearch(filterName, searchName) {
	if (searchName == ""){
		window.location.href = removeURLParameter(window.location.href, filterName);
	}
	else {
		window.location.href = updateURLParameter(window.location.href, filterName, searchName);
	}
}

function filter(filterName, select) {
	var c = select.value;
	if (c == ""){
		window.location.href = removeURLParameter(window.location.href, filterName);
	}
	else {
		window.location.href = updateURLParameter(window.location.href, filterName, c);
	}
}

function updateURLParameter(url, param, paramVal) {
	var TheAnchor = null;
	var newAdditionalURL = "";
	var tempArray = url.split("?");
	var baseURL = tempArray[0];
	var additionalURL = tempArray[1];
	var temp = "";

	if (additionalURL) {
		var tmpAnchor = additionalURL.split("#");
		var TheParams = tmpAnchor[0];
		TheAnchor = tmpAnchor[1];
		if (TheAnchor)
			additionalURL = TheParams;

		tempArray = additionalURL.split("&");

		for (var i = 0; i < tempArray.length; i++) {
			if (tempArray[i].split('=')[0] != param) {
				newAdditionalURL += temp + tempArray[i];
				temp = "&";
			}
		}
	}
	else {
		var tmpAnchor = baseURL.split("#");
		var TheParams = tmpAnchor[0];
		TheAnchor = tmpAnchor[1];

		if (TheParams)
			baseURL = TheParams;
	}

	if (TheAnchor)
		paramVal += "#" + TheAnchor;

	var rows_txt = temp + "" + param + "=" + paramVal;
	return baseURL + "?" + newAdditionalURL + rows_txt;
}

function removeURLParameter(url, parameter) {
	var urlparts = url.split('?');
	if (urlparts.length >= 2) {
		var prefix = encodeURIComponent(parameter) + '=';
		var pars = urlparts[1].split(/[&;]/g);

		for (var i = pars.length; i-- > 0;) {
			if (pars[i].lastIndexOf(prefix, 0) !== -1) {
				pars.splice(i, 1);
			}
		}
		return urlparts[0] + (pars.length > 0 ? '?' + pars.join('&') : '');
	}
	return url;
}

function generateRandomColor() {
	var r = Math.floor(Math.random() * 255);
	var g = Math.floor(Math.random() * 255);
	var b = Math.floor(Math.random() * 255);
	return "rgb(" + r + "," + g + "," + b + ")";
};