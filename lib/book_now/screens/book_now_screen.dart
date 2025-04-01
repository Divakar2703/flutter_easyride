import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/common_widget/shimmer_loader.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/Book_Now/screens/pickup_screen.dart';
import 'package:flutter_easy_ride/Book_Now/screens/select_vehicle.dart';
import 'package:flutter_easy_ride/provider/api_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/eve.dart';

class BookNowScreen extends StatefulWidget {
  const BookNowScreen({super.key});

  @override
  _BookNowScreenState createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  GoogleMapController? _mapController;
  LatLng _currentLocation=LatLng(ALatitude, ALongitude); // Example coordinates
  LatLng? sourceLocation;
  String pickupAddress="";
  TextEditingController pickupController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Alatitiue==${ALatitude}");
    _getCurrentLocation();
    Provider.of<CabBookProvider>(context, listen: false).getDropHistoryList();
  }


  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        sourceLocation = LatLng(position.latitude, position.longitude);
      });
      // Retrieve the address for the current location
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        ALatitude = position.latitude;
        ALongitude = position.longitude;
        pickupAddress =
        '${placemarks[0].thoroughfare}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode}';
        _currentLocation=LatLng(position.latitude, position.longitude);
        pickupController.text=pickupAddress;
      });
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    var cabBookProvider=Provider.of<CabBookProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
       //   appBar: AppBar(title: Text('Choose Your Ride')),
      body: cabBookProvider.isLoading?ShimmerLoader():Column(
        children: [
          // Map with search box on top
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.5,
                child: GoogleMap(
                  onTap: _handleMapTap,
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation,
                    zoom: 14.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {},
                  markers: {
                    Marker(
                      markerId: MarkerId('currentLocation'),
                      position: _currentLocation,
                    ),
                  },
                ),
              ),
              Positioned(
                top: 40,
                left: 15,
                right: 15,
                child: GestureDetector(
                  onTap: () {
                    // Navigate to another screen with door open animation
                    Navigator.push(
                      context,
                      createDoorOpenPageRoute(PickupScreen()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      enabled: false,
                    controller: pickupController,
                    //  initialValue: '${pickupAddress}',
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10,),
          // Choose a Ride section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Choose a Ride', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Container(
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                          onTap: () {
                            cabBookProvider.setCabType("Bike");
                            Navigator.push(
                              context,
                              createDoorOpenPageRoute(PickupScreen()),
                            );

                          },
                          child: rideOption('Bike', 'assets/icon/motorbike.png')),
                          InkWell(
                              onTap: (){
                                cabBookProvider.setCabType("AUTO");
                                Navigator.push(
                                  context,
                                  createDoorOpenPageRoute(PickupScreen()),
                                );
                              },
                              child: rideOption('Auto', 'assets/icon/auto.png')),
                          InkWell(
                              onTap: (){
                                cabBookProvider.setCabType("CAR");
                                Navigator.push(
                                  context,
                                  createDoorOpenPageRoute(PickupScreen()),
                                );
                              },
                              child: rideOption('Car', 'assets/icon/car.png')),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Divider(),
          SizedBox(height: 10,),

          // Destination search box and history
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to another screen with door open animation
                    cabBookProvider.setCabType("");
                    Navigator.push(
                      context,
                      createDoorOpenPageRoute(PickupScreen()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Where to go?',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),

               // SizedBox(height: 20),

                // History of search locations

                Container(
                  height: MediaQuery.of(context).size.height*0.2,
                  child: Consumer<CabBookProvider>(
                    builder: (BuildContext context, CabBookProvider provider, Widget? child) {
                    return  ListView.builder(
                      shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: provider.dropHistoryData?.list.length,
                          itemBuilder: (context,index){
                        var data=provider.dropHistoryData?.list[index];

                            return  InkWell(
                                onTap: (){
                                  cabBookProvider.setDropLocation(data!.dropAddress,double.parse(data.dropLat),double.parse(data.dropLong),);

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectVehicle()));
                                },
                                onLongPress: () async {
                                  // Show a confirmation dialog
                                  final deleteConfirmed = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Delete Item"),
                                        content: Text("Are you sure you want to delete this item?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false); // Cancel deletion
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true); // Confirm deletion
                                            },
                                            child: Text("Delete"),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  // If confirmed, delete the item from the list
                                  if (deleteConfirmed ?? false) {
                                    provider.deleteDropLocation(provider.dropHistoryData!.list[index].id); // Define this method in your provider to handle deletion
                                  }
                                },
                                child: locationHistoryItem(provider.dropHistoryData!.list[index].dropAddress));
                          });
                    },
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
  void _handleMapTap(LatLng tappedPoint) async {
    setState(() {
      _currentLocation=tappedPoint;
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          tappedPoint.latitude, tappedPoint.longitude);
      ALatitude=tappedPoint.latitude;
      ALongitude=tappedPoint.longitude;

        address =
        '${placemarks[0].thoroughfare}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode}';
        print("add===${address}");
        pickupController.text=address;
        setState(() {

        });

    } catch (e) {
      print('Error: $e');
    }
  }

  // Method to create a ride option widget
  Widget rideOption(String name, String assetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xffE3F2FD),
                    Colors.blue.shade300,
                  ],)
             // color: Colors.grey[200],
            ),
            child: Center(
              child: Image.asset(assetPath, width: 40, height: 40), // Use SVG or image asset
            ),
          ),
          SizedBox(height: 5),
          Text(name, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  // Method to create a location history item widget
  Widget locationHistoryItem(String address) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.watch_later_outlined),
              SizedBox(width: 10),
              SizedBox(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: Text(address)),
            ],
          ),
          Icon(Icons.arrow_forward_ios, size: 18),
        ],
      ),
    );
  }

}

// Custom page route with door opening animation
Route createDoorOpenPageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = 0.0;
      var end = 1.0;
      var curve = Curves.fastOutSlowIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var scaleAnimation = animation.drive(tween);

      return ScaleTransition(
        scale: scaleAnimation,
        alignment: Alignment.topCenter,
        child: ScaleTransition(
          scale: scaleAnimation,
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
    },
  );
}


