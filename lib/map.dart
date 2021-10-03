import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';



class MapPage extends StatefulWidget {
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  State<StatefulWidget> createState() {
    return MapState();
  }
}

class MapState extends State<MapPage> {


  var selectedPlace;
  @override
  Widget build(BuildContext context) {
    return (Container(
      child: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(51.5, -0.09),
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                attributionBuilder: (_) {
                  return Text("© OpenStreetMap contributors");
                },
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 200.0,
                    height: 200.0,
                    point: LatLng(51.5, -0.09),
                    builder: (ctx) => Container(
                        child: Column(
                      children: [
                        Text(
                          "maybe city name",
                          style: TextStyle(backgroundColor: Colors.blueGrey),
                        ),
                        Icon(
                          Icons.dangerous,
                          color: Colors.red,
                          size: 100,
                        )
                      ],
                    )),
                  ),
                ],
              ),
            ],
          ),
          Container(
            child: Text("搜尋框"),
          ),
        ],
      ),
    ));
  }
}
