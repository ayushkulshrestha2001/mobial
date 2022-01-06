import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:http/http.dart' as http;

class MapDisplay extends StatefulWidget {
  MapDisplay({Key? key}) : super(key: key);

  @override
  _MapDisplayState createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {
  // List<dynamic> qrMarkers = [];
  // List<Marker> markers = [];
  @override
  void initState() {
    super.initState();
    //getQrLocation();
  }

  // getQrLocation() async {
  //   var url = Uri.parse("https://mobial.herokuapp.com/api/get_qrcodes");
  //   http.Response response = await http.get(url);
  //   print(response.body);
  //   var data = jsonDecode(response.body);
  //   setState(() {
  //     qrMarkers = data;
  //     getMarkers();
  //   });
  // }

  // getMarkers() {
  //   qrMarkers.forEach((e) {
  //     String longitudeS = e['location'].split(",").first;
  //     String latitudeS = (e['location'].split(",").last);
  //     double _longitude = double.parse(longitudeS);
  //     double _latitude = double.parse(latitudeS);
  //     markers.add(Marker(
  //       width: 80.0,
  //       height: 80.0,
  //       point: LatLng(_longitude, _latitude),
  //       builder: (ctx) => Container(
  //         child: Icon(Icons.location_on, color: Colors.black),
  //       ),
  //     ));
  //   });
  // }

  List<Marker> markers = [
    Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(13.199379, 77.710136),
      builder: (ctx) => Container(
        child: Icon(Icons.location_on, color: Colors.black),
      ),
    ),
    Marker(
      anchorPos: AnchorPos.align(AnchorAlign.center),
      width: 80.0,
      height: 80.0,
      point: LatLng(13.198465052455404, 77.70745378642731),
      builder: (ctx) => Container(
        child: Icon(Icons.location_on, color: Colors.black),
      ),
    ),
    Marker(
      anchorPos: AnchorPos.align(AnchorAlign.center),
      width: 80.0,
      height: 80.0,
      point: LatLng(13.200235379999054, 77.70852205083513),
      builder: (ctx) => Container(
        child: Icon(Icons.location_on, color: Colors.black),
      ),
    ),
    Marker(
      anchorPos: AnchorPos.align(AnchorAlign.center),
      width: 80.0,
      height: 80.0,
      point: LatLng(13.200074666613734, 77.70951250043967),
      builder: (ctx) => Container(
        child: Icon(
          Icons.location_on,
          color: Colors.black,
        ),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        plugins: [MarkerClusterPlugin()],
        center: LatLng(13.199379, 77.710136),
        zoom: 14,
        // rotation: 90.0,
      ),
      children: <Widget>[
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
        ),
        MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            size: Size(40, 40),
            fitBoundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(50),
            ),
            markers: markers,
            polygonOptions: PolygonOptions(
                borderColor: Colors.blueAccent,
                color: Colors.black12,
                borderStrokeWidth: 3),
            builder: (context, markers) {
              return FloatingActionButton(
                child: Text(markers.length.toString()),
                onPressed: null,
              );
            },
          ),
        )
      ],
    );
  }
}
