import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Pre_Booking/screens/booking_details_screen.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../Book_Now/provider/cab_book_provider.dart';
import '../../common_widget/custombutton.dart';
import '../../common_widget/map_widget.dart';
import '../../common_widget/vehicle_widget.dart';
import '../../provider/map_provider.dart';

final Color kDarkBlueColor = const Color(0xff1937d7);

class SelectPrebookingVehicle extends StatefulWidget {
  const SelectPrebookingVehicle({super.key});

  @override
  State<SelectPrebookingVehicle> createState() => _SelectPrebookingVehicleState();
}

class _SelectPrebookingVehicleState extends State<SelectPrebookingVehicle> {
  late GoogleMapController mapController;
  final LatLng _pickupLocation = LatLng(ALatitude, ALongitude); // Pickup location coordinates
  int selectedRow = -1;
  Set<int> selectedRows = Set<int>(); // Use a Set to keep track of selected indices

  @override
  void initState() {
    super.initState();
    Provider.of<CabBookProvider>(context, listen: false).getVehicleData();
    //Provider.of<PreebookingProvider>(context, listen: false).getprebookvehicle();

    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.loadMapData(ALatitude, ALongitude, dropLat, dropLong);
    mapProvider.getPolyPoints(ALatitude, ALongitude, dropLat, dropLong);
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    final paymenttypes = Provider.of<CabBookProvider>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          MapWidget(
            initialPosition: _pickupLocation,
            markers: mapProvider.markers,
            polylineCoordinates: mapProvider.polylineCoordinates,
          ),
          // Draggable bottom sheet or fixed container for booking card

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              //height: MediaQuery.of(context).size.height * 0.5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
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
                        } else if (cabProvider.vehicleResponse!.data?.vehicleList == null ||
                            (cabProvider.vehicleResponse!.data?.vehicleList!.isEmpty ?? false)) {
                          return Center(child: Text("No vehicles available"));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: cabProvider.vehicleResponse?.data?.vehicleList?.length,
                            itemBuilder: (BuildContext context, int index) {
                              var vehicle = cabProvider.vehicleResponse?.data?.vehicleList?[index];
                              return VehicleListItem(
                                title: vehicle?.name ?? "",
                                subtitle: vehicle?.description ?? "",
                                price: "${vehicle?.fare ?? ""}",
                                time: "2 min",
                                assetPath: vehicle?.image ?? "",
                                isSelected: selectedRows.contains(index),
                                onTap: () {
                                  setState(() {
                                    selectedVehicle = vehicle?.id ?? "";
                                    selectedFare = vehicle?.fare ?? "0.0";
                                    vehicleDetails = cabProvider.vehicleResponse?.data?.vehicleList?[index];
                                    setState(() {});
                                    // Toggle the selection state
                                    if (selectedRows.contains(index)) {
                                      selectedRows.remove(index); // Deselect if already selected
                                    } else {
                                      cabProvider.getOffers(int.parse(vehicle?.id ?? "0"));
                                      selectedRows.add(index); // Select if not selected
                                      cabProvider.sendRequestToDriver(vehicle?.id ?? "", "pre_booking");
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Customtbutton(
                          text: "Confirm",
                          onPressed: () {
                            Navigator.of(context).push(_createRoute());
                          },
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

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BookingDetailsScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start off the screen to the right
        const end = Offset.zero; // Slide to the center
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
