fetch('https://getbootstrap.com/.then(function (response) {
	// The API call was successful!
	return response.text();
}).then(function (html) {

	// Convert the HTML string into a document object
	var parser = new DOMParser();
	var doc = parser.parseFromString(html, 'text/html');

	// Get the image file
	var img = doc.querySelector('img');
	console.log(img);

}).catch(function (err) {
	// There was an error
	console.warn('Something went wrong.', err);
});