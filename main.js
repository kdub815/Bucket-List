var layer = new L.StamenTileLayer("watercolor");
var map = new L.Map("mapid", {
    center: new L.LatLng(39.952825, -75.171631),
    zoom: 12
});
map.addLayer(layer);