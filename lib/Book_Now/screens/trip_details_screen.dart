import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/Book_Now/screens/drive_looking_screen.dart';
import 'package:flutter_easy_ride/provider/map_provider.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../Pre_Booking/provider/preebooking_provider.dart';
import '../../common_widget/custombutton.dart';
import '../../common_widget/map_widget.dart';
import 'cancel_ride.dart';

// updated code

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  final LatLng _pickupLocation = LatLng(ALatitude, ALongitude);

  @override
  void initState() {
    super.initState();
    Provider.of<PreebookingProvider>(context, listen: false);
    Provider.of<CabBookProvider>(context, listen: false).getVehicleData();
    Provider.of<MapProvider>(context, listen: false).loadMapData(
      ALatitude,
      ALongitude,
      30.32455712895656,
      78.00607616176579,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: MapWidget(
              initialPosition: _pickupLocation,
              markers: mapProvider.markers,
              polylineCoordinates: mapProvider.polylineCoordinates,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Looking for', style: TextStyle(fontFamily: "Poppins")),
                Text(
                  'Bike ride',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ProgressBar(),
          ),
          Divider(thickness: 8, height: 20),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(Icons.location_on, color: Colors.green),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    'Block A, New Ashok Nagar, New Delhi',
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(Icons.more_vert),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    'Sector 63, Noida Uttar Pradesh',
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 8, height: 20),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Fare',
                        style: TextStyle(fontSize: 15, fontFamily: "Poppins")),
                    Text('₹ 100', style: TextStyle(fontFamily: "Poppins")),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Customtbutton(
                  text: 'Back',
                  fontFamily: "Poppins",
                  textColor: Colors.white,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    Provider.of<PreebookingProvider>(context, listen: false)
                        .Cancialpreebook(
                      "Book-00075307",
                      "plan changed",
                      8238375356,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CancelRideScreen()),
                    );
                  },
                  child: Customtbutton(
                    fontFamily: "Poppins",
                   
                      backgroundColor: const Color(0xff1937d7),
                    text: 'Cancel Ride',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
