import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hot_source_app/get_data.dart';
import 'package:hot_source_app/sizing.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:hot_source_app/data_models.dart';



class MapPage extends StatefulWidget {
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  State<StatefulWidget> createState() {
    return MapState();
  }
}

class MapState extends State<MapPage> {


  var selectedPlace;
  List<String> _cities = [];
  List<List<String>> _data = [];
  LatLng _latLng = LatLng(25.0478, 121.5319);
  String _city = 'Taipei';
  MapController mapController = MapController();
  LocalStorage storage = LocalStorage('hot');
  late Data data;
  late GetData getData;

  void readCity() async {
    final csv = await rootBundle.loadString('assets/city.csv');
    _data = [
      for (String l in csv.split('\n')) [for (String s in l.split(',')) s]
    ];
    // List<List<dynamic>> data = CsvToListConverter().convert();

    setState(() => _cities = [for (List l in _data) l[0]]);
  }

  void connect() async {
    final d = await getData.getData();
    List<String> days = [];
    List<double> temps = [];
    for (Temps t in d.temps) {
      days.add(t.time.day.toString());
      temps.add(t.temp);
    }
    await storage.setItem('days', days);
    await storage.setItem('temps', temps);
    await storage.setItem('percent', double.parse(d.heat_percent.toString()));
    setState(() {
      data = d;
      storage.setItem('city', _city);
    });
  }

  void initState() {
    super.initState();
    readCity();
    _latLng = LatLng(25.0478, 121.5319);
    _city = 'Taipei';
    mapController = MapController();
    getData = GetData(city: _city);
    connect();
  }

  @override
  Widget build(BuildContext context) {
    Sizing _size = Sizing(context: context);

    return (Container(
      child: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: _latLng,
              zoom: 5,
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
                    point: _latLng,
                    builder: (ctx) => Container(
                        child: Column(
                      children: [
                        Text(
                          _city,
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: _size.height(percent: 5)),
                        ),
                        Icon(
                          Icons.room,
                          color: Colors.red,
                          size: _size.height(percent: 6),
                        )
                      ],
                    )),
                  ),
                ],
              ),
            ],
          ),
          Container(
            child: Container(
              padding: EdgeInsets.all(_size.height(percent: 2)),
              color: Color.fromARGB(170, 255, 255, 255),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return _cities.where((String option) {
                    return option.contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  print(
                      '${_data[_cities.indexOf(selection)][1]},${_data[_cities.indexOf(selection)][2]}');
                  String _lat = _data[_cities.indexOf(selection)][1];
                  String _lng = _data[_cities.indexOf(selection)][2];

                  setState(() {
                    _latLng = LatLng(double.parse(_lat), double.parse(_lng));
                    _city = selection;
                    mapController.move(_latLng, 5);
                    connect();
                  });
                },
              ),
            ),
          ),
          Positioned(
              right: 14,
              bottom: 35,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _latLng = LatLng(25.0478, 121.5319);
                    _city = 'Taipei';
                    mapController.rotate(0);
                    mapController.move(_latLng, 5);
                    connect();
                  });
                },
                child: Icon(
                  Icons.my_location,
                  color: Colors.blueGrey,
                ),
              )),
        ],
      ),
    ));
  }
}
