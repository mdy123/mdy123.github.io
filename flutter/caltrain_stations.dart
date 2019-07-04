import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'dart:async';
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
          zoom: 9,
          target: LatLng(37.003636, -121.5671767),
        ));
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
                      title: Text(json.decode(snapshot.data)[index]['name']),
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
                      subtitle:
                          Text(json.decode(snapshot.data)[index]['address']),
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
