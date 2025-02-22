import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CurrentLocationMap extends StatefulWidget {
  @override
  _CurrentLocationMapState createState() => _CurrentLocationMapState();
}

class _CurrentLocationMapState extends State<CurrentLocationMap> {
  GoogleMapController? _mapController;
  Location _location = Location();
  LatLng _currentPosition = LatLng(0, 0);
  Marker? _locationMarker;
  Circle? _currentCircle;
  StreamSubscription<LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _initializeLocationTracking();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  void _initializeLocationTracking() async {
    // Check if location services are enabled
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    // Check and request location permissions
    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    // Get initial location
    LocationData initialLocation = await _location.getLocation();
    _currentPosition =
        LatLng(initialLocation.latitude!, initialLocation.longitude!);

    // Update marker and circle for the current position
    _updateMarkerAndCircle(_currentPosition);

    // Start listening to location updates
    _locationSubscription =
        _location.onLocationChanged.listen((LocationData locationData) {
      LatLng newPosition =
          LatLng(locationData.latitude!, locationData.longitude!);
      _updateMarkerAndCircle(newPosition);

      // Automatically move the camera to the updated position
      _mapController?.animateCamera(CameraUpdate.newLatLng(newPosition));
    });
  }

  void _updateMarkerAndCircle(LatLng position) async {
    setState(() {
      // Update marker
      _locationMarker = Marker(
        markerId: MarkerId("current_location"),
        position: position,
        infoWindow: InfoWindow(title: "Current Location"),
      );

      // Update circle
      _currentCircle = Circle(
        circleId: CircleId("current_circle"),
        center: position,
        radius: 10, // Radius in meters
        fillColor: Colors.blueAccent.withOpacity(0.2),
        strokeColor: Colors.blueAccent,
        strokeWidth: 2,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
                height: MediaQuery.of(context).size.height * 0.20, // 25% of screen height
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white10, width: 15),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 1,
                        color: Colors.grey.shade800),
                    BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 1,
                      color: Colors.white,
                    )
                  ],
                ),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 16,
                  ),
                  markers: _locationMarker != null ? {_locationMarker!} : {},
                  circles: _currentCircle != null ? {_currentCircle!} : {},
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    _mapController?.moveCamera(
                        CameraUpdate.newLatLng(_currentPosition));
                  },
                  myLocationEnabled: false, // Hide default location icon
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  // Hide default location button
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
