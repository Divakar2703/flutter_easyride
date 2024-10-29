import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/eve.dart';

class MapProvider with ChangeNotifier {
  final String googleApiKey = "AIzaSyAKgqAyTO5G0rIf8laUc5_gOaF16Qwjg2Y";
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Set<Marker> _markers = {};
  bool isLoading = true;

  Set<Marker> get markers => _markers;



  double currentZoomLevel = 14.0;
  double mapHeightPercentage = 0.6;
  bool zooming = false;
  late GoogleMapController _controller;

  // Called when map is created
  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
    // Other setup code if necessary
  }

  // Toggle zoom level
  void toggleZoom() {
    zooming = !zooming;
    if (zooming) {
      _zoomIn();
    } else {
      _zoomOut();
    }
    notifyListeners();
  }

  // Increase zoom level
  void _zoomIn() {
    currentZoomLevel++;
    _controller.animateCamera(CameraUpdate.zoomTo(currentZoomLevel));
    notifyListeners();
  }

  // Decrease zoom level
  void _zoomOut() {
    currentZoomLevel--;
    _controller.animateCamera(CameraUpdate.zoomTo(currentZoomLevel));
    notifyListeners();
  }

  // Toggle map size between expanded and normal
  void toggleMapSize() {
    mapHeightPercentage = mapHeightPercentage == 0.6 ? 0.9 : 0.6;
    notifyListeners();
  }

  Future<void> getPolyPoints(double originLat, double originLng, double destLat, double destLng) async {
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey: "AIzaSyAKgqAyTO5G0rIf8laUc5_gOaF16Qwjg2Y",
          request: PolylineRequest(
              origin: PointLatLng(ALatitude, ALongitude),
              destination: PointLatLng(dropLat, dropLong),
              mode: TravelMode.driving));

      if (result.points.isNotEmpty) {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        notifyListeners();
      }
    } catch (error) {
      print("Error getting route: $error");
    }
  }

  void loadMapData(double originLat, double originLng, double destLat, double destLng) async {
    // Simulate a delay to fetch map data
    await Future.delayed(Duration(seconds: 2));
    // _markers.add(
    //   Marker(
    //     markerId: MarkerId("pickup"),
    //     position: LatLng(originLat, originLng), // Pickup Location
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    //   ),
    // );
    _markers.add(
      Marker(
        markerId: MarkerId("dropoff"),
        position: LatLng(dropLat, dropLong), // Drop Location
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
    isLoading = false;
    notifyListeners();
  }
}
