var config = {
    apiKey: "AIzaSyBZqJh7r6POY_WaoyzrLAaghv-_K_Q7EvA",
    authDomain: "philly-bucketlist.firebaseapp.com",
    databaseURL: "https://philly-bucketlist.firebaseio.com",
    projectId: "philly-bucketlist",
    storageBucket: "philly-bucketlist.appspot.com",
    messagingSenderId: "508799675680"
};

firebase.initializeApp(config);

var layer = new L.StamenTileLayer("watercolor");
var map = new L.Map("mapid", {
    center: new L.LatLng(39.952825, -75.171631),
    zoom: 12
});
map.addLayer(layer);

var itemsRef = firebase.database().ref('items').once('value').then(function(snapshot){
	var data = snapshot.val();
	for (var key in data) {
		var lat = data[key].google_data[0].geometry.location.lat;
		var lng = data[key].google_data[0].geometry.location.lng;
		var name = data[key].name;

		L.marker([lat, lng]).addTo(map);
	}
});

