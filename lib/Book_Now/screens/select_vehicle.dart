import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../common_widget/map_widget.dart';
import '../../common_widget/vehicle_widget.dart';
import '../../provider/map_provider.dart';
import '../Components/promocode.dart';
import '../provider/cab_book_provider.dart';

final Color kDarkBlueColor = const Color(0xff1937d7);

class SelectVehicle extends StatefulWidget {
  const SelectVehicle({super.key});

  @override
  State<SelectVehicle> createState() => _SelectVehicleState();
}

class _SelectVehicleState extends State<SelectVehicle> {

  late GoogleMapController mapController;
  final LatLng _pickupLocation = LatLng(ALatitude, ALongitude); // Pickup location coordinates
  int selectedRow=-1;

  Set<int> selectedRows = Set<int>(); // Use a Set to keep track of selected indices

  @override
  void initState() {
    super.initState();
    Provider.of<CabBookProvider>(context, listen: false).getVehicleData();
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.loadMapData(ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
    mapProvider.getPolyPoints(ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);

  }


  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);

    return Scaffold(
      body:
      Stack(
        children: [
          MapWidget(initialPosition: _pickupLocation, markers: mapProvider.markers, polylineCoordinates: mapProvider.polylineCoordinates,),
          // Draggable bottom sheet or fixed container for booking card
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              height: MediaQuery.of(context).size.height * 0.5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*0.4,
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                        ),
                        color: Colors.white,
                      ),
                      child: Consumer<CabBookProvider>(builder: (context, cabProvider, child) {
                        if (cabProvider.vehicleResponse == null) {
                          return Center(child: CircularProgressIndicator());
                        } else if (cabProvider.vehicleResponse!.vehicle == null || cabProvider.vehicleResponse!.vehicle!.isEmpty) {
                          return Center(child: Text("No vehicles available"));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: cabProvider.vehicleResponse?.vehicle.length,
                            itemBuilder: (BuildContext context, int index) {
                              var vehicle = cabProvider.vehicleResponse?.vehicle[index];
                
                              return VehicleListItem(
                                title: vehicle!.name,
                                subtitle: vehicle.description,
                                price: vehicle.fare.toString(),
                                time: "2 min",
                                assetPath: vehicle.image,
                                isSelected: selectedRows.contains(index), // Check if the current index is in the selected rows
                                onTap: () {
                                  setState(() {
                                    // Toggle the selection state
                                    if (selectedRows.contains(index)) {
                                      selectedRows.remove(index); // Deselect if already selected
                                    } else {
                                      selectedRows.add(index); // Select if not selected
                                    }
                                  });
                                },
                              );
                
                            },
                          );
                        }
                      }),
                    ),
                    // Confirm Button
                    GestureDetector(
                      onTap: () {
                        // Add your confirm action here
                        openPromocodeBottomSheet(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff1937d7), // Your confirm button color
                        ),
                        child: const Center(
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );


  }

}

