import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../common_widget/map_widget.dart'; 
import '../../provider/map_provider.dart';
import 'drive_looking_screen.dart'; 
import 'trip_details_screen.dart'; 

class DriveFindingScreen extends StatefulWidget {
  const DriveFindingScreen({super.key});

  @override
  State<DriveFindingScreen> createState() => _DriveFindingScreenState();
}

class _DriveFindingScreenState extends State<DriveFindingScreen> {

  
  late GoogleMapController mapController;
  final LatLng _pickupLocation = LatLng(ALatitude, ALongitude); 
  @override
  void initState() {
    super.initState();
   
    final cabBookProvider = Provider.of<CabBookProvider>(context, listen: false);
    cabBookProvider.getVehicleData();

    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.loadMapData(ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
    mapProvider.getPolyPoints(ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
        
          MapWidget(
            initialPosition: _pickupLocation,
            markers: mapProvider.markers,
            polylineCoordinates: mapProvider.polylineCoordinates,
          ),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 500), 
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    SizedBox(height: 50,),
                    Text(
                      'Looking for your',
                      style: TextStyle(fontFamily: "Poppins"),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TripDetailsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: Text(
                          'Trip Details',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ProgressBar(), 
              ),
              SizedBox(height: 20),
              Divider(height: 2, thickness: 8),
            ],
          ),






          
        ],
      ),
    );
  }
}
