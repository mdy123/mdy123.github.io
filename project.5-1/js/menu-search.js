  //  view model for search menu 
  var View = function() {
      this.searchData = ko.observable('');
      this.addressArray = ko.observableArray(addresses.slice());
      // click event to show marker's infowindow when click the station name. 
      this.clickEvt = function(x, y) {
          google.maps.event.trigger(x.markerObj, 'click');
      };
  };

  // initiate view model
  var view = new View();

  // observ function for comparing between searh input box and address array
  view.searchData.subscribe(function(x) {
      var tempArray = [];
      view.addressArray.removeAll();
      for (var i = 0; i < addresses.length; i++) {
          // convert both search string and name of the station to lower case
          // then saved the matched station data to temp array 
          if (((addresses[i].name).toLowerCase()).indexOf(x.toLowerCase()) >= 0) {
              tempArray.push(addresses[i]);
          }
      }
      view.addressArray(tempArray);
  });

  // observ function to redraw maker depending on the search result
  view.addressArray.subscribe(function(x) {
      if (view.addressArray().length === 0) {
          for (var ii = 0; ii < 32; ii++) {
              addresses[ii].markerObj.setMap(null);
          }
      } else {
          for (var i = 0; i < view.addressArray().length; i++) {
              view.addressArray()[i].markerObj.setMap(mapView.mapObj);
          }
      }
  });
