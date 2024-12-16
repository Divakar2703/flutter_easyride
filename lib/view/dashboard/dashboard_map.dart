import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/model/nearby_vehicle.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../Book_Now/screens/select_vehicle.dart';
import '../../provider/api_provider.dart';
import '../../provider/dashboard_provider.dart';
import '../../utils/eve.dart';
import 'home_dashboard.dart';
class DashboardMap extends StatefulWidget {
  const DashboardMap({Key? key}) : super(key: key);

  @override
  State<DashboardMap> createState() => _MapPageState();
}

class _MapPageState extends State<DashboardMap> {
  LatLng? sourceLocation;
  LatLng? destLocation;
  String? address = '';
  Set<Circle> _circles = {}; // Define a set for the circle
  Set<Marker> _markers = {}; // Define a set for cab markers

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    Provider.of<ApiProvider>(context, listen: false)
        .getCurrentLocation();
    Provider.of<ApiProvider>(context, listen: false).fetchAuth();
    Provider.of<DashboardProvider>(context, listen: false).fetchDashboard();
    Provider.of<DashboardProvider>(context, listen: false).getLocationVehicles();
    Provider.of<DashboardProvider>(context, listen: false).pendingBooking();

  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        sourceLocation = LatLng(position.latitude, position.longitude);

        // Add a circle around the current location
        _circles.add(
          Circle(
            circleId: const CircleId('currentLocation'),
            center: sourceLocation!,
            radius: 50, // Radius in meters
            fillColor: Colors.blue.withOpacity(0.2), // Fill color with transparency
            strokeColor: Colors.blue, // Stroke color
            strokeWidth: 2, // Stroke width
          ),
        );
        _markers.add(
          Marker(
            markerId: const MarkerId('Source'),
            position: sourceLocation!,
            infoWindow: const InfoWindow(title: 'You'),
          ),
        );
      });

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      setState(() {
        dropLat = position.latitude;
        dropLong = position.longitude;
        dropAddress =
        '${placemarks[0].thoroughfare}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode}';
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _addCabMarkers(List<NearbyCab> vehicles) async {
    final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)), // Define the size
      'assets/icon/auto.png', // Path to your custom icon
    );

    for (var vehicle in vehicles) {
      try {
        double lat = double.parse(vehicle.curr_lat);
        double lng = double.parse(vehicle.curr_long);

        _markers.add(
          Marker(
            markerId: MarkerId(vehicle.id),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: vehicle.name),
            icon: customIcon??BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          ),
        );
      } catch (e) {
        print("Error adding marker for vehicle ${vehicle.name}: $e");
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cabProvider = Provider.of<DashboardProvider>(context);

    // Update cab markers whenever cab data is updated
    // if (cabProvider.vehicleData!.vehicle.isNotEmpty) {
    //   _addCabMarkers(cabProvider.vehicleData!.vehicle);
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          if (sourceLocation != null)
            Container(
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                onTap: _handleMapTap,
                initialCameraPosition: CameraPosition(
                  target: sourceLocation!,
                  zoom: 14,
                ),
                markers: _markers,
                //_buildMarkers(),
                circles: _circles, // Add circles to the Google Map
                buildingsEnabled: false,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
              ),
            ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.06,
            left: 1,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Material(
                    color: Colors.white,
                    elevation: 3.0,
                    shape: const CircleBorder(),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {},
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.menu,
                          color: Colors.black87,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Material(
                    color: Colors.white,
                    elevation: 3.0,
                    shape: const CircleBorder(),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {},
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.black87,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: HomeDashboard(scrollController: scrollController),
              );
            },
          ),
        ],
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    Set<Marker> markers = {};

    // if (destLocation != null) {
    //   markers.add(
    //     Marker(
    //       markerId: MarkerId('Destination'),
    //       position: destLocation!,
    //     ),
    //   );
    // }
    markers.add(
      Marker(
        markerId: MarkerId('Source'),
        position: sourceLocation!,
        infoWindow: InfoWindow(title: 'You'),
      ),
    );
    return markers;
  }

  void _handleMapTap(LatLng tappedPoint) async {
    setState(() {
      destLocation = tappedPoint;
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          tappedPoint.latitude, tappedPoint.longitude);
      dropLat = tappedPoint.latitude;
      dropLong = tappedPoint.longitude;

      setState(() {
        dropAddress =
        '${placemarks[0].thoroughfare}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode}';
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}


