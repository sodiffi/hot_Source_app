
import 'package:flutter/material.dart';



const kGoogleApiKey = "AIzaSyADaRIeMSVJNYGP6GMNC9z1ome2CjMN8GE";

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MapState();
  }
}

class MapState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return (Container(child: Text("這邊是地圖"),));
  }

 
}
