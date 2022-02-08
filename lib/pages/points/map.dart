import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

// ignore: must_be_immutable
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
          onTap: (_, latlng) => _popupLayerController.hideAllPopups()
          // rotation: 90.0,
          ),
      children: <Widget>[
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate:
                'https://atlas.microsoft.com/map/tile/png?api-version=1&layer=basic&style=main&tileSize=256&view=Auto&zoom={z}&x={x}&y={y}&subscription-key=JENfdJcTMjKcAKIZ2TwVMf3Z6dBA7hgFmveOnlm0CYc',
            additionalOptions: {
              'subscriptionKey': 'JENfdJcTMjKcAKIZ2TwVMf3Z6dBA7hgFmveOnlm0CYc',
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
