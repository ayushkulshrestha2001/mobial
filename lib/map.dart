import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:http/http.dart' as http;

class MapDisplay extends StatefulWidget {
  List<Marker> markers;
  Map<String, Widget>? popup;

  MapDisplay({required this.markers, this.popup});

  @override
  _MapDisplayState createState() => _MapDisplayState(markers: markers);
}

class _MapDisplayState extends State<MapDisplay> {
  PopupController _popupLayerController = PopupController();
  List<Marker> markers;
  _MapDisplayState({required this.markers});
  @override
  void initState() {
    super.initState();
    print(markers.length);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          plugins: [
            MarkerClusterPlugin(),
          ],
          center: LatLng(13.199379, 77.710136),
          zoom: 14,
          interactiveFlags: InteractiveFlag.all,
          onTap: (_, Latlng) => _popupLayerController.hideAllPopups()
          // rotation: 90.0,
          ),
      children: <Widget>[
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate:
                'https://atlas.microsoft.com/map/tile/png?api-version=1&layer=basic&style=main&tileSize=256&view=Auto&zoom={z}&x={x}&y={y}&subscription-key=gCUOaS3l6uKVcg20GfuNBtkRBlZuNZwlZSbgwEjfqlA',
            additionalOptions: {
              'subscriptionKey': 'gCUOaS3l6uKVcg20GfuNBtkRBlZuNZwlZSbgwEjfqlA',
            },
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
        ),
        // PopupMarkerLayerWidget(
        //     options: PopupMarkerLayerOptions(
        //   markers: markers,
        //   popupController: _popupLayerController,
        //   popupBuilder: (_, Marker marker) {
        //     if (marker is MarkMap) {
        //       return MarkerPopUp(mark: marker.mark);
        //     }
        //     return Container(
        //       height: 100.0,
        //       child: Card(
        //         child: Column(
        //           children: [
        //             Text(
        //               'Not a monument',
        //             )
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // )),
      ],
    );
  }
}

class Mark {
  static const double size = 25;

  Mark({
    required this.name,
    required this.imagePath,
    required this.lat,
    required this.long,
  });

  final String name;
  final String imagePath;
  final double lat;
  final double long;
}

class MarkMap extends Marker {
  MarkMap({required this.mark})
      : super(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          height: Mark.size,
          width: Mark.size,
          point: LatLng(mark.lat, mark.long),
          builder: (BuildContext ctx) => Icon(Icons.location_on),
        );

  final Mark mark;
}

// class MonumentMarkerPopup extends StatelessWidget {
//   const MonumentMarkerPopup({Key? key, required this.mark})
//       : super(key: key);
//   final Mark mark;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Image.network(monument.imagePath, width: 200),
//             Text(monument.name),
//             Text('${monument.lat},${monument.long}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
class MarkerPopUp extends StatelessWidget {
  final Mark mark;
  const MarkerPopUp({
    required this.mark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Card(
        child: Column(
          children: [
            Text(
              'Not a monument',
            )
          ],
        ),
      ),
    );
  }
}
// <Marker>[
//             MonumentMarker(
//               monument: Monument(
//                 name: 'Eiffel Tower',
//                 imagePath:
//                     'https://cdn.lifestyleasia.com/wp-content/uploads/2019/10/21224220/Winer-Parisienne.jpg',
//                 lat: 48.857661,
//                 long: 2.295135,
//               ),
//             ),
//             Marker(
//               anchorPos: AnchorPos.align(AnchorAlign.top),
//               point: LatLng(48.859661, 2.305135),
//               height: Monument.size,
//               width: Monument.size,
//               builder: (BuildContext ctx) => Icon(Icons.shop),
//             ),
//           ],