import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';

void main() {
  runApp(MaterialApp(
    title: 'CalTrain Stations',
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var stations;
  Set<Marker> m;
  Completer<GoogleMapController> _controller = Completer();
  Future<GoogleMapController> controller;

  @override
  void initState() {
    DefaultAssetBundle.of(context)
        .loadString('json/caltrain_stations.json')
        .then((v) {
      setState(() {
        stations = jsonDecode(v);
      });
    });

    m = {
      Marker(
        markerId: MarkerId('Gilroy'),
        position: LatLng(37.003636, -121.5671767),
        infoWindow: InfoWindow(title: 'Gilroy Station'),
      )
    };
    controller = _controller.future;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CalTrain Stations'),
      ),
      body: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('json/caltrain_stations.json')
              .then((v) {
            setState(() {
              json.decode(v).forEach((e) {
                m.add(Marker(
                  markerId: MarkerId(e['name']),
                  position: LatLng(e['lat'], e['lng']),
                  infoWindow: InfoWindow(title: '${e['name']} Station'),
                ));
              });
            });
            return null;
          }),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: tMap(),
                ),
                Flexible(
                  flex: 1,
                  child: bList(),
                ),
              ],
            );
          }),
    );
  }

  Widget tMap() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: m,
      initialCameraPosition: CameraPosition(
        zoom: 11,
        target: LatLng(37.3937715, -122.0766438),
      ),
      minMaxZoomPreference: MinMaxZoomPreference(7, 15),
      zoomGesturesEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Widget bList() {
    return FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('json/caltrain_stations.json'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return ListView.builder(
              itemCount: json.decode(snapshot.data).length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ListTile(
                      title: GestureDetector(
                        onTap: () {
                          //controller.animateCamera(CameraUpdate.newCameraPosition());
                          controller.then((v) {
                            v.animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                zoom: 11,
                                target: LatLng(
                                    json.decode(snapshot.data)[index]['lat'],
                                    json.decode(snapshot.data)[index]['lng']),
                              ),
                            ));
                          });
                        },
                        child: Text(json.decode(snapshot.data)[index]['name']),
                      ),
                      leading: Container(
                        padding: EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Image(
                            image: NetworkImage(
                                'https://picsum.photos/id/${index + 1}/300/300')),
                      ),
                      //trailing: Text('Trailing'),
                      subtitle: GestureDetector(
                          onTap: () async {
                            //'https://www.google.com/maps/@37.5148383,-121.913165,15z'
                            //'https://www.google.com/maps/@${json.decode(snapshot.data)[index]['lat']},${json.decode(snapshot.data)[index]['lng']},15z'
                            //'https://www.google.com/maps/@${json.decode(snapshot.data)[index]['lat']},${json.decode(snapshot.data)[index]['lng']},18z/data=!3d${json.decode(snapshot.data)[index]['lat']}!4d${json.decode(snapshot.data)[index]['lng']}'
                            if (await canLaunch(
                                'https://www.google.com/maps/@${json.decode(snapshot.data)[index]['lat']},${json.decode(snapshot.data)[index]['lng']},15z')) {
                              await launch(
                                  'https://www.google.com/maps/@${json.decode(snapshot.data)[index]['lat']},${json.decode(snapshot.data)[index]['lng']},18z');
                            } else {
                              throw "Can't Launch";
                            }
                          },
                          child: Text(
                              json.decode(snapshot.data)[index]['address'])),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width / 15) * 12,
                      child: Divider(
                        color: Colors.orange,
                        height: 5,
                      ),
                    ),
                  ],
                );
              });
        });
  }
}
