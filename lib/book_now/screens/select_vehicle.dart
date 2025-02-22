import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/common_widget/shimmer_loader.dart';
import 'package:flutter_easy_ride/common_widget/custombutton.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../book_easyride/new_screen/confirm_booking.dart';
import '../../common_widget/map_widget.dart';
import '../../common_widget/payment_methods_widget.dart';
import '../../common_widget/vehicle_widget.dart';
import '../../provider/map_provider.dart';
import '../../service/socket/socket_helper.dart';
import '../Components/promocode.dart';
import '../provider/cab_book_provider.dart';
import 'drive_finding_screen.dart';

final Color kDarkBlueColor = const Color(0xff1937d7);

class SelectVehicle extends StatefulWidget {
  const SelectVehicle({super.key});

  @override
  State<SelectVehicle> createState() => _SelectVehicleState();
}

class _SelectVehicleState extends State<SelectVehicle> {
  late GoogleMapController mapController;
  final LatLng _pickupLocation =
      LatLng(ALatitude, ALongitude); // Pickup location coordinates
  int selectedRow = -1;
  final SocketHelper socketHelper = SocketHelper();


  Set<int> selectedRows = Set<int>(); // Use a Set to keep track of selected indices

  @override
  void initState() {
    super.initState();
    Provider.of<CabBookProvider>(context,listen: false).convcharge();
    Provider.of<CabBookProvider>(context, listen: false).getVehicleData();
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.loadMapData(ALatitude, ALongitude, dropLat, dropLong);
    mapProvider.getPolyPoints(ALatitude, ALongitude, dropLat, dropLong);
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    final cabProvder=Provider.of<CabBookProvider>(context);

    return Scaffold(
      body: mapProvider.isLoading
          ? ShimmerLoader()
          : Stack(
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
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10)
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                topLeft: Radius.circular(16),
                              ),
                              color: Colors.white,
                            ),
                            child: Consumer<CabBookProvider>(
                                builder: (context, cabProvider, child) {
                              if (cabProvider.vehicleResponse == null) {
                                return Center(
                                    child: Text("No vehicles available"));
                              } else if (cabProvider.vehicleResponse!.vehicle ==
                                      null ||
                                  cabProvider
                                      .vehicleResponse!.vehicle!.isEmpty) {
                                return Center(
                                    child: Text("No vehicles available"));
                              } else {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cabProvider
                                      .vehicleResponse?.vehicle.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var vehicle = cabProvider
                                        .vehicleResponse?.vehicle[index];

                                    return VehicleListItem(
                                      title: vehicle!.name,
                                      subtitle: vehicle.description,
                                      price: vehicle.fare.toString(),
                                      time: "2 min",
                                      assetPath: vehicle.image,
                                      isSelected: selectedRows.contains(
                                          index), // Check if the current index is in the selected rows
                                      onTap: () {

                                        setState(() {
                                          selectedVehicle=vehicle.id;
                                          socketHelper.connect();
                                          socketHelper.findDriver(selectedVehicle, "15");
                                          setState(() {
                                          });
                                          // Toggle the selection state
                                          if (selectedRows.contains(index)) {
                                            selectedRows.remove(
                                                index); // Deselect if already selected
                                          } else {
                                            cabProvider.getOffers(
                                                int.parse(vehicle.id));
                                            selectedRows.add(
                                                index); // Select if not selected
                                            cabProvider.sendRequestToDriver(vehicle.id,"book_now");
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
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.2), // Shadow color
                                  offset: Offset(0,
                                      -4), // Offset with negative y value for top shadow
                                  blurRadius: 6, // Blur radius
                                  spreadRadius: 1, // Spread radius
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () => _showPaymentMethodBottomSheet(context),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.payment,
                                                  color: Colors.green,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text("$selectedBank"),
                                              ],
                                            ),

                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.black,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      width: 2,
                                      color: Colors.grey.shade200,
                                    ),
                                    InkWell(
                                      onTap: ()=> openPromocodeBottomSheet(context),

                                        child: Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.local_offer_sharp,
                                                  color: Colors.blueAccent,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text("Offers"),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.black,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Consumer<CabBookProvider>(
                                  builder: (BuildContext context, provider, Widget? child) {
                                    return GestureDetector(
                                      onTap: () {
                                        print("selectedPaymentMethod==$selectedBank");
                                        if(selectedVehicle!=""){
                                        //  socketHelper.connect();
                                         // socketHelper.findDriver(selectedVehicle, "15"); // Replace with actual IDs
                                          // Provider.of<CabBookProvider>(context, listen: false).sendRequestToDriver();
                                          if(selectedBank=="COD"){
                                             socketHelper.findDriver(selectedVehicle, "15"); // Replace with actual IDs

                                            Provider.of<CabBookProvider>(context, listen: false).paynow(provider.bookingReq!.reqId,"COD",0);
                                            if(requestStatus){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfirmBooking(requestID:provider.bookingReq!.reqId,)));
                                            }
                                            else{
                                              Fluttertoast.showToast(msg: "Finding the best driver for your ride... Please wait.");
                                            }
                                          }
                                          else {
                                             socketHelper.findDriver(selectedVehicle, "15"); // Replace with actual IDs

                                            Provider.of<CabBookProvider>(context, listen: false).paynow(provider.bookingReq!.reqId,selectedBank,double.parse(cabProvder.paytype!.convCharge));
                                           if(requestStatus){
                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfirmBooking(requestID:provider.bookingReq!.reqId,)));
                                           }
                                           else{
                                             Fluttertoast.showToast(msg: "Finding the best driver for your ride... Please wait.");
                                           }
                                          }
                                        }
                                        else{
                                          Fluttertoast.showToast(msg: "Please Select the vehicle");
                                          Fluttertoast.showToast(msg: "Please select the payment method");

                                        }


                                        // Add your confirm action here
                                       // Navigator.push(context, MaterialPageRoute(builder: (context) => FindDriverScreen()));
                                      },
                                      child: Customtbutton(text: "Confirm",)


                                    );
                                  },

                                ),
                              ],
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

  void _showPaymentMethodBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return PaymentMethodBottomSheet(
          onPaymentSelected: (selectedMethod) {
            Navigator.pop(context, selectedMethod);
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedBank = result;
      });
    }
  }

}
