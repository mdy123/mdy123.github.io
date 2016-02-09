 // custom binding for map DIV tag
  ko.bindingHandlers.mapHandler = {
      init: function(element, valueAccessor, allBindings, viewModel, bindingContext) {
          var map = ko.unwrap(valueAccessor());
          var marker;
          // boundaries for the map window
          var bounds = new google.maps.LatLngBounds();

          for (var i = 0; i < addresses.length; i++) {
              //create maker object.
              marker = new google.maps.Marker({
                  map: map,
                  position: {
                      lat: addresses[i].lat,
                      lng: addresses[i].lng
                  },
                  title: addresses[i].name,
                  varData: addresses[i].address,
              });
              // create marker click event to show maker's infowindow
              marker.addListener('click', function() {
                  var self = this;
                  var infoBox = '<p><strong>' + self.title + '</strong></p><p>' + self.varData.split(', USA')[0] + '</p>';
                  new google.maps.InfoWindow({
                      content: infoBox
                  }).open(map, self);
                  self.setAnimation(google.maps.Animation.BOUNCE);
                  setTimeout(function() {
                      self.setAnimation(null);
                  }, 1500);
              });

              addresses[i].markerObj = marker;

              // marker added to the map.
              bounds.extend(new google.maps.LatLng(addresses[i].lat, addresses[i].lng));

              // fit the map to the new marker
              map.fitBounds(bounds);

              // center the map
              map.setCenter(bounds.getCenter());
          }

          // adjust map bounds
          window.addEventListener('resize', function(e) {
              // Make sure the map bounds get updated on page resize
              map.fitBounds(bounds);
          });

      }
  };

  var MapView = function() {
      this.mapObj = new google.maps.Map(document.querySelector('#map'), {
          disableDefaultUI: true
      });
  };

  // initiate view model for map
  var mapView = new MapView();
