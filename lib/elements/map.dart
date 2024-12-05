import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MapEl extends StatefulWidget {
  const MapEl({super.key});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapEl> {
  List<Marker> stationMarkers = []; // Store markers here

  // Your API URL (update with the correct address)
  final String apiUrl = 'http://192.168.1.10:5000/stations';

  // Function to fetch station data from the API
  Future<List<Map<String, dynamic>>> fetchStations() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((station) => station as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load stations');
    }
  }

  // Add markers to the map
  Future<void> MarkerAdder() async {
    try {
      // Fetch station data
      final stations = await fetchStations();

      // Map each station to a Marker
      List<Marker> markers = stations.map((station) {
        return Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(station['latitude'], station['longitude']),
          builder: (ctx) => Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 40.0,
          ),
        );
      }).toList();

      // Update the state to display markers
      setState(() {
        stationMarkers = markers;
      });
    } catch (e) {
      print('Error adding markers: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    print("Map State initialized");
    MarkerAdder(); // Load markers when the map initializes
  }

  @override
  Widget build(BuildContext context) {
    try {
      return FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(18.20807, -67.14028),
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(markers: stationMarkers), // Display markers
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
