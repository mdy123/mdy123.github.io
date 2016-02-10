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
                var imgdata;
                 
                // animate marker
                self.setAnimation(google.maps.Animation.BOUNCE);
                setTimeout(function() {
                  self.setAnimation(null);
                }, 700);
                  
                //AJAX call to Flickr to pull the image for Marker's Info Window
                var flickerAPI = "http://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?";
                $.getJSON(flickerAPI, {
                        tags: self.title,
                        tagmode: "any",
                        format: "json"
                    })
                    .done(function(data) {

                        if (data.items.length) {

                            imgdata = ('<img src="' + data.items[0].media.m + '" ' + 'alt="No Image Found" width="100%" height="75">');
                       }else {
                            imgdata = ('<img src="" ' + 'alt="No Image Found" width="100%" height="75">');
                        }

                        //Marker's Info Window
                        new google.maps.InfoWindow({
                            content: '<p><strong>' + self.title + '</strong></p><p>' + self.varData.split(', USA')[0] + '</p><div>' + imgdata + '</div>',
                        }).open(map, self);
                       
                    })
                    .fail(function() {
                          alert( "AJAX error." );
                    })
                    .always(function() {
                      //  no op                       
                    });
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
            // map bounds get updated on page resize
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

// apply binding two view models to UI 
// one for map and one for search menu
var viewModel = {
    mapview: mapView,
    menuview: view
};

ko.applyBindings(viewModel);
