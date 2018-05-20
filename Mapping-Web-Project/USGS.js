// Creating map object
var map = L.map("map", {
  center: [40.7128, -74.0059],
  zoom: 11
});

// Adding tile layer
L.tileLayer("https://api.mapbox.com/styles/v1/mapbox/light-v9/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoiam1pMzk4IiwiYSI6ImNqZ3ljMG1mbjBqYjcyd2xla2w2MzY0emkifQ.vyQcmkFnQwg0QsigaTJcBQ").addTo(map);

var link = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_month.geojson";

d3.json(link, function (data) {
  L.geoJSON(data, {
    style: genStyle,
    pointToLayer: function(feature, latlng) {
      return L.markerCircle(latlng, {

      }).addTo(map);

  return console.log(data);


  function genStyle(feature) {
    var allStyle = {
      opacity: 1,
      stroke: true,
      //.... other defualt props

      fillColor: magColor(feature.properties.mag),
      radius: magRadius(feature.properties.mag)
    }

    return allStyle
  }

  function magColor(size) {
    switch (size) {
      case size > 5:
        return "#red"
      case size > 4:
        return "#DarkOrange"
      case size > 3:
        return "#orange"
      case size > 2:
        return "#yellow"
      case size > 1:
        return "green"
      default:
        // this will return a default if not in the other cases
        return "#gray"
    }
  }

  function magRadius(mag) {
    return mag * 0.5; // The function finds the radius by dividing mag in half

  }

  function onEachFeature (feature, layer) {
    // Set mouse events to change map styling
    layer.on({
      // When a user's mouse touches a map feature, the mouseover event calls this function, that feature's opacity changes to 90% so that it stands out
      mouseover: function (event) {
        layer = event.target;
        layer.setStyle({
          fillOpacity: 0.9
        });
      },
      // When the cursor no longer hovers over a map feature - when the mouseout event occurs - the feature's opacity reverts back to 50%
      mouseout: function (event) {
        layer = event.target;
        layer.setStyle({
          fillOpacity: 0.5
        });
      },
      // When a feature (neighborhood) is clicked, it is enlarged to fit the screen
      click: function (event) {
        map.fitBounds(event.target.getBounds());
      }
    });
    // Giving each feature a pop-up with information pertinent to it
    layer.bindPopup("<h1>" + feature.properties.mag + "</h1> <hr> <h2>" + feature.properties.place + "</h2>");
  }

})

