import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../Book_Now/screens/select_vehicle.dart';
import '../../utils/eve.dart';
import '../dashboard/home_dashboard.dart';




class DashboardMap extends StatefulWidget {
  const DashboardMap({Key? key}) : super(key: key);

  @override
  State<DashboardMap> createState() => _MapPageState();
}

class _MapPageState extends State<DashboardMap> {
  LatLng? sourceLocation;
  LatLng? destLocation;
  String? address = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        sourceLocation = LatLng(position.latitude, position.longitude);
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

  @override
  Widget build(BuildContext context) {
    final cabProvider = Provider.of<CabBookProvider>(context);
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
                  zoom: 15,
                ),
                markers: _buildMarkers(),
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
                      onTap: () {

                      },
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
                  const SizedBox(width: 20),
                  const Text(
                    'Cab Booking',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Spacer(),
                  Material(
                    color: Colors.white,
                    elevation: 3.0,
                    shape: const CircleBorder(),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {

                      },
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

          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    builder: (context) {
                      final screenHeight = MediaQuery.of(context).size.height;
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: SizedBox(
                          height: screenHeight - 115,
                          child: const HomeDashboard(),
                        ),
                      );
                    },
                  );
                },
                child: Icon(Icons.keyboard_arrow_up,size: 40,)),
          ),
        ],
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    Set<Marker> markers = {};

    if (destLocation != null) {
      markers.add(
        Marker(
          markerId: MarkerId('Destination'),
          position: destLocation!,
        ),
      );
    }
    markers.add(
      Marker(
        markerId: MarkerId('Source'),
        position: sourceLocation!,
        infoWindow: InfoWindow(title: 'Source Location'),
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
