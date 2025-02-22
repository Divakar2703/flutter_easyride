import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../Book_Now/screens/select_vehicle.dart';
import '../../common_widget/custombutton.dart';
import '../../utils/eve.dart';


class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
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
            top: MediaQuery.of(context).size.height * 0.08,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Icon(Icons.my_location_rounded),
                    const SizedBox(width: 10),
                    Text(
                      dropAddress!.length > 30
                          ? '${dropAddress!.substring(0, 30)}...'
                          : dropAddress!,
                      ),
                    ],
                ),
              ),
            ),
          ),
        
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              child: GestureDetector(
                // style: ElevatedButton.styleFrom(
                //   foregroundColor: Colors.black,
                //   backgroundColor: const Color(0xff1937d7),
                //   elevation: 0,
                //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(7.0),
                //   ),
                // ),
                onTap: () async {
                  cabProvider.addDropLocation(dropLat.toString(),
                      dropLong.toString(), dropAddress, "book_now");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectVehicle()),
                  );
                },
                child: Customtbutton(
                  text: "Proceed",


                )
                // const
                // Text(
                //   'Proceed',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontFamily: 'Poppins',
                //     fontWeight: FontWeight.w600,
                //     color: Colors.white,
                //   ),
                // ),

              ),
            ),
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
