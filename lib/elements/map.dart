import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapEl extends StatefulWidget {
  const MapEl({super.key});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapEl> {
var stationMarkers = [];


void MarkerAdder(){
throw UnimplementedError("IMPLEMENT THIS WITH API CALLS");

}
  @override
  void initState(){
    super.initState();
    print("Map State initialized");
  }

  @override
  Widget build(BuildContext context) {
    try {
    return FlutterMap(
      options: const MapOptions(
        initialCenter:  LatLng(18.20807, -67.14028),  
        initialZoom: 15,
      ),
      children: [  // Use 'layers' instead of 'children'
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
      ],
    );
    } catch (e) {
      print('Error building map: $e'); // Catch and log the error
      return Center(
        child: Text('Error loading map: $e'),
      );
  }
}
}