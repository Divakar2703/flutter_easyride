import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/utils/eve.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../common_widget/map_widget.dart';
import '../../provider/map_provider.dart';
import 'confirm_booking_screen.dart';

class BookingDetailsScreen extends StatefulWidget {
  @override
  _BookingDetailsScreenState createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  late GoogleMapController mapController;

  final LatLng _pickupLocation =
      LatLng(ALatitude, ALongitude); // Pickup location coordinates
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  String selectedDate = "Date"; // For displaying the selected date
  String selectedTime = "Time"; // For displaying the selected time
  String promoCode = ""; // Variable to store the promo code
  bool isPromoApplied = false; // Variable to check if promo is applied
  TextEditingController _promoController =
      TextEditingController(); // Controller for promo code input
  double mapHeightPercentage = 0.55; // Default map height
  double currentZoomLevel = 14.0;
  bool zooming = false;
  int selectedSwitch = -1; // Initialize selectedSwitch with -1
  var address = "B-702, Sarthak the Sarjak,";
  bool isChecked = false;
  String selectedInstruction = "";
  String selectedAInstruction = "";
  bool isRecorded = false;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();

    Provider.of<CabBookProvider>(context, listen: false).GetNotes();

    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.loadMapData(
        ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
    mapProvider.getPolyPoints(
        ALatitude, ALongitude, 30.32455712895656, 78.00607616176579);
    polylinePoints = PolylinePoints();
  }

  void _showFareBreakdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Fare Breakdown",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              _buildFareRow("Base Fare", "Rs. 100"),
              _buildFareRow("Discount", "- Rs. 20"),
              _buildFareRow("Tolls", "Rs. 30"),
              _buildFareRow("GST", "Rs. 10"),
              Divider(),
              _buildFareRow("Total", "Rs. 120", isBold: true),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFareRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);

    return Scaffold(
      body: mapProvider.isLoading ? _buildShimmerLoading() : _buildContent(),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Container(
            height: 300,
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(height: 20, color: Colors.grey.shade300),
                  SizedBox(height: 10),
                  Container(height: 20, color: Colors.grey.shade300),
                  SizedBox(height: 10),
                  Container(height: 100, color: Colors.grey.shade300),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final mapProvider = Provider.of<MapProvider>(context);
    final convcharges = Provider.of<CabBookProvider>(context);
   

    return Stack(
      children: [
        MapWidget(
          initialPosition: _pickupLocation,
          markers: mapProvider.markers,
          polylineCoordinates: mapProvider.polylineCoordinates,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Price",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins")),
                          SizedBox(
                            width: 10,
                          ),
                          Text("₹120",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins",
                                  color: Color(0xff1937d7))),
                          SizedBox(
                            width: 10,
                          ),
                          Text("₹150",
                              style: TextStyle(
                                  fontSize: 20,
                                  decoration: TextDecoration.lineThrough,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        icon:
                            Icon(Icons.info_outline, color: Color(0xff1937d7)),
                        onPressed: () => _showFareBreakdown(context),
                      ),
                    ],
                  ),
               
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Distance",
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        width: 10,
                      ),
                      Text("10 km",
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildBox("Date & Time", Icons.arrow_drop_down,
                          _onDateTap, "$selectedDate, $selectedTime"),
                      _buildBox("Wallet", Icons.arrow_drop_down, _onWalletTap,
                          "$_selectedPaymentMethod"),
                    ],
                  ),
                  Row(
                    children: [
                      _buildBox("Add Notes", Icons.arrow_drop_down,
                          _onAddNotesTap, ""),
                      _buildBox("Promo Code", Icons.arrow_drop_down,
                          _onPromoTap, "$promoCode"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BookingSuccessScreen()));
                          // Provider.of<CabBookProvider>(context, listen: false).bookCab(requestID, 259, "paymentType"," orderID", "transID", "amount" as double, "conCharge" as double);
                          Provider.of<CabBookProvider>(context, listen: false).convcharge();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          backgroundColor: Color(0xff1937d7), // Button color
                        ),
                        child: Text('Confirm Booking',

                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBox(
      String label, IconData icon, VoidCallback onTap, String value) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.42,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100, // Set the width based on your requirement
              child: Text(
                value == "" ? label : value,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff1937d7),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                ),
                textAlign: TextAlign.center,
                overflow:
                    TextOverflow.ellipsis, // Adds "..." when text is too long
                maxLines: 1, // Limits the text to a single line
              ),
            ),
            Icon(icon, color: Color(0xff1937d7)),
          ],
        ),
      ),
    );
  }

  // Box Tap Callbacks
  void _onDateTap() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildDateTimePicker(context);
      },
    );
  }

  void _onWalletTap() {
    _showPaymentBottomSheet(context);
    
  }

  void _onAddNotesTap() {
    _showPickupNotesBottomSheet(context);
  }

  void _onPromoTap() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildPromoCodeBottomSheet(context);
      },
    );
  }

  Widget _buildPromoCodeBottomSheet(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Promo Code",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins"),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _promoController,
                decoration: InputDecoration(
                  labelText: "Promo Code",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1937d7)),
                    onPressed: () {
                      // Apply promo code logic
                      setState(() {
                        if (_promoController.text.isNotEmpty) {
                          promoCode = _promoController.text;
                          isPromoApplied = true;
                        } else {
                          isPromoApplied = false;
                        }
                      });
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: Text(
                      "Apply",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker(BuildContext context) {
    DateTime now = DateTime.now();
    List<String> dateOptions = List.generate(
      7,
      (index) => DateFormat('EE, MMM d').format(now.add(Duration(days: index))),
    );
    List<String> timeOptions =
        List.generate(24, (index) => '${index.toString().padLeft(2, '0')}:00');

    int selectedDateIndex = 0;
    int selectedTimeIndex = 0;

    return Container(
      height: 300,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Date & Time",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins"),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Row(
              children: [
                // Date Picker
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40,
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedDateIndex),
                    onSelectedItemChanged: (int index) {
                      selectedDateIndex = index;
                    },
                    children: dateOptions.map((date) {
                      return Center(child: Text(date));
                    }).toList(),
                  ),
                ),
                // Time Picker
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40,
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedTimeIndex),
                    onSelectedItemChanged: (int index) {
                      selectedTimeIndex = index;
                    },
                    children: timeOptions.map((time) {
                      return Center(child: Text(time));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff1937d7)),
              onPressed: () {
                // Update selected date and time
                setState(() {
                  selectedDate = dateOptions[selectedDateIndex];
                  selectedTime = timeOptions[selectedTimeIndex];
                });
                Navigator.pop(context); // Close the bottom sheet
              },
              child: Text(
                "Done",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "poppins",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // void _showPickupNotesBottomSheet(BuildContext context) {
  //   TextEditingController _notesController = TextEditingController();
  //   var mQuery = MediaQuery.of(context);
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     isScrollControlled: true,
  //     builder: (context) {
  //       return Padding(
  //         padding: EdgeInsets.only(
  //           bottom: MediaQuery.of(context)
  //               .viewInsets
  //               .bottom, // To prevent keyboard overlap
  //         ),
  //         child: Container(
  //           color: Colors.white,
  //           padding: EdgeInsets.all(16),
  //           height: MediaQuery.of(context).size.height *
  //               0.6, // Adjust the height as needed
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "Add Pickup Notessss",
  //                 style: TextStyle(
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.bold,
  //                     fontFamily: "Poppins"),
  //               ),
  //               SizedBox(height: 10),
  //               Expanded(
  //                 child: Container(
  //                   width: double.infinity,
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(16),
  //                         topRight: Radius.circular(16)),
  //                   ),
  //                   child: Padding(
  //                     padding: EdgeInsets.only(
  //                       top: MediaQuery.of(context).size.height * 0.028,
  //                     ),
  //                     child: SingleChildScrollView(
  //                       child: Column(
  //                         children: [
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(
  //                                 horizontal: mQuery.size.width * 0.045),
  //                             child: Row(
  //                               children: [
  //                                 Container(
  //                                   width: mQuery.size.width * 0.055,
  //                                   height: mQuery.size.height * 0.04,
  //                                   decoration: BoxDecoration(
  //                                       shape: BoxShape.circle,
  //                                       color: Color(0xff29b2fe)),
  //                                   child: Center(
  //                                     child: Icon(
  //                                       Icons.home,
  //                                       color: Colors.white,
  //                                       size: mQuery.size.width * 0.04,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 SizedBox(width: mQuery.size.width * 0.07),
  //                                 Text(
  //                                   "Dehradun",
  //                                   style: TextStyle(
  //                                     fontSize: mQuery.size.height * 0.019,
  //                                     fontFamily: 'SatoshiMedium',
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: mQuery.size.height * 0.008,
  //                           ),
  //                           Divider(),
  //                           SizedBox(height: mQuery.size.height * 0.024),
  //                           Container(
  //                             width: double.infinity,
  //                             height: mQuery.size.height * 0.2,
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: mQuery.size.width * 0.045),
  //                             decoration: BoxDecoration(
  //                               color: Colors.white,
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey.withOpacity(0.5),
  //                                   spreadRadius: 0.2,
  //                                   blurRadius: 7,
  //                                   offset: Offset(0, 0),
  //                                 ),
  //                               ],
  //                             ),
  //                             child: SingleChildScrollView(
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Row(
  //                                     children: [
  //                                       Transform.scale(
  //                                         scale: 0.9,
  //                                         child: Radio(
  //                                           value: 1,
  //                                           groupValue: selectedSwitch,
  //                                           onChanged: (int? value) {
  //                                             setState(() {
  //                                               selectedSwitch = value!;
  //                                               selectedInstruction =
  //                                                   "Contactless delivery at the door";
  //                                             });
  //                                           },
  //                                           activeColor: Color(0xff29b2fe),
  //                                         ),
  //                                       ),
  //                                       Text(
  //                                         "Contactless delivery at the door",
  //                                         style: TextStyle(
  //                                             fontFamily: 'SatoshiMedium',
  //                                             fontSize:
  //                                                 mQuery.size.height * 0.018),
  //                                       )
  //                                     ],
  //                                   ),
  //                                   Row(
  //                                     children: [
  //                                       Transform.scale(
  //                                         scale: 0.9,
  //                                         child: Radio(
  //                                           value: 2,
  //                                           groupValue: selectedSwitch,
  //                                           onChanged: (int? value) {
  //                                             setState(() {
  //                                               selectedSwitch = value!;
  //                                               selectedInstruction =
  //                                                   "Contactless delivery to the guard";
  //                                             });
  //                                           },
  //                                           activeColor: Color(0xff29b2fe),
  //                                         ),
  //                                       ),
  //                                       Text(
  //                                         "Contactless delivery to the guard",
  //                                         style: TextStyle(
  //                                             fontFamily: 'SatoshiMedium',
  //                                             fontSize:
  //                                                 mQuery.size.height * 0.018),
  //                                       )
  //                                     ],
  //                                   ),
  //                                   Row(
  //                                     children: [
  //                                       Transform.scale(
  //                                         scale: 0.9,
  //                                         child: Radio(
  //                                           value: 3,
  //                                           groupValue: selectedSwitch,
  //                                           onChanged: (int? value) {
  //                                             setState(() {
  //                                               selectedSwitch = value!;
  //                                               selectedInstruction =
  //                                                   "Hand me the order";
  //                                             });
  //                                           },
  //                                           activeColor: Color(0xff29b2fe),
  //                                         ),
  //                                       ),
  //                                       Column(
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         children: [
  //                                           Text(
  //                                             "Hand me the order",
  //                                             style: TextStyle(
  //                                                 fontFamily: 'SatoshiMedium',
  //                                                 fontSize: mQuery.size.height *
  //                                                     0.018),
  //                                           ),
  //                                           Text(
  //                                             "Order will be given directly to you",
  //                                             style: TextStyle(
  //                                                 color: Colors.black54,
  //                                                 fontFamily: 'SatoshiRegular',
  //                                                 fontSize: mQuery.size.height *
  //                                                     0.014),
  //                                           )
  //                                         ],
  //                                       )
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: mQuery.size.height * 0.032,
  //                           ),
  //                           Container(
  //                             width: double.infinity,
  //                             height: mQuery.size.height * 0.11,
  //                             margin: EdgeInsets.symmetric(
  //                                 horizontal: mQuery.size.width * 0.045),
  //                             decoration: BoxDecoration(
  //                               color: Colors.white,
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey.withOpacity(0.5),
  //                                   spreadRadius: 0.2,
  //                                   blurRadius: 7,
  //                                   offset: Offset(0, 0),
  //                                 ),
  //                               ],
  //                             ),
  //                             child: SingleChildScrollView(
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   SizedBox(
  //                                     height: mQuery.size.height * 0.012,
  //                                   ),
  //                                   Padding(
  //                                     padding: EdgeInsets.symmetric(
  //                                         horizontal:
  //                                             mQuery.size.width * 0.045),
  //                                     child: Text(
  //                                       "Additional Instructions",
  //                                       style: TextStyle(
  //                                           fontSize:
  //                                               mQuery.size.height * 0.019,
  //                                           fontFamily: 'SatoshiBold'),
  //                                     ),
  //                                   ),
  //                                   Row(
  //                                     children: [
  //                                       Checkbox(
  //                                         value: isChecked,
  //                                         onChanged: (value) {
  //                                           setState(() {
  //                                             isChecked = value!;
  //                                             selectedAInstruction =
  //                                                 "Don't ring the bell";
  //                                           });
  //                                         },
  //                                         activeColor: Color(0xff29b2fe),
  //                                       ),
  //                                       Text(
  //                                         "Don't ring the bell",
  //                                         style: TextStyle(
  //                                             fontFamily: 'SatoshiMedium',
  //                                             fontSize:
  //                                                 mQuery.size.height * 0.0175),
  //                                       )
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(height: 20),
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(
  //                                 horizontal: mQuery.size.width * 0.045),
  //                             child: TextField(
  //                               controller: _notesController,
  //                               maxLines: 4,
  //                               decoration: InputDecoration(
  //                                 hintText: "Enter your pickup notes here",
  //                                 border: OutlineInputBorder(
  //                                   borderRadius: BorderRadius.circular(8),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           SizedBox(height: 20),
  //                           SizedBox(
  //                             width: double.infinity,
  //                             child: ElevatedButton(
  //                               onPressed: () {
  //                                 // Handle save notes logic here
  //                                 Provider.of<CabBookProvider>(context,
  //                                         listen: false)
  //                                     .GetNotes();
  //                                 String notes = _notesController.text;
  //                                 // You can now save 'notes' or pass it to your backend or state management
  //                                 Navigator.pop(
  //                                     context); // Close the bottom sheet
  //                               },
  //                               style: ElevatedButton.styleFrom(
  //                                 padding: EdgeInsets.all(12),
  //                                 backgroundColor:
  //                                     Color(0xff1937d7), // Button color
  //                               ),
  //                               child: Text(
  //                                 'Save Notes',
  //                                 style: TextStyle(
  //                                     fontSize: 16, color: Colors.white),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  //  updated code  update

  void _showPickupNotesBottomSheet(BuildContext context) {
    TextEditingController _notesController = TextEditingController();
    var mQuery = MediaQuery.of(context);
    bool isChecked = false;

    List<bool> isCheckedList = [];
    List<String> selectedInstructions = [];

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            height: mQuery.size.height * 0.6,
            child: Consumer<CabBookProvider>(
              builder: (context, provider, child) {
                if (provider.notes == null ||
                    provider.notes!.deliveryNotes == null) {
                  return Center(child: CircularProgressIndicator());
                }

                final instructions = provider.notes!.deliveryNotes.notes ?? [];
                final additionalInstructions =
                    provider.notes!.deliveryNotes.additionalInstructions ?? [];

                isCheckedList = List.generate(
                    additionalInstructions.length, (index) => false);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Pickup Notes",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.2,
                              blurRadius: 7,
                              offset: Offset(0, 0),
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: mQuery.size.height * 0.028),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ...instructions.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  String note = entry.value;

                                  return Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.9,
                                        child: Radio(
                                          value: index,
                                          groupValue:
                                              provider.selectedInstructionIndex,
                                          onChanged: (int? value) {
                                            if (value != null) {
                                              provider.setSelectedInstruction(
                                                  value);
                                            }
                                          },
                                          activeColor: Color(0xff29b2fe),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          note,
                                          style: TextStyle(
                                            fontFamily: 'SatoshiMedium',
                                            fontSize:
                                                mQuery.size.height * 0.018,
                                            color:
                                                provider.selectedInstructionIndex ==
                                                        index
                                                    ? Color(0xff29b2fe)
                                                    : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),                                
                                SizedBox(height: mQuery.size.height * 0.032),
                                if (additionalInstructions.isNotEmpty) ...[
                                  Container(
                                    width: double.infinity,
                                    height: mQuery.size.height * 0.11,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: mQuery.size.width * 0.045),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0.2,
                                          blurRadius: 7,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  mQuery.size.width * 0.045),
                                          child: Text(
                                            "Additional Instructions",
                                            style: TextStyle(
                                              fontSize:
                                                  mQuery.size.height * 0.019,
                                              fontFamily: 'SatoshiBold',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: mQuery.size.height *
                                                0.01), // Add spacing between the title and instructions
                                        ...additionalInstructions
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          int index = entry.key;
                                          String instruction = entry.value;

                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    mQuery.size.height * 0.005),
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                  value: isCheckedList[index],
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      isCheckedList[index] =
                                                          value ?? true;
                                                    });
                                                  },
                                                  activeColor:
                                                      isCheckedList[index]
                                                          ? Colors.blue
                                                          : Colors.white,
                                                  checkColor: Colors.white,
                                                  side: BorderSide(
                                                    color: isCheckedList[index]
                                                        ? Colors.blue
                                                        : Colors.black,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    instruction,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'SatoshiMedium',
                                                      fontSize:
                                                          mQuery.size.height *
                                                              0.0175,
                                                      color:
                                                          isCheckedList[index]
                                                              ? Colors.blue
                                                              : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  ),
                                ],
                                SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: mQuery.size.width * 0.045),
                                  child: TextField(
                                    controller: _notesController,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      hintText: "Enter your pickup notes here",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Provider.of<CabBookProvider>(context,
                                              listen: false)
                                          .GetNotes();
                                      String notes = _notesController.text;
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(12),
                                      backgroundColor: Color(0xff1937d7),
                                    ),
                                    child: Text(
                                      'Save Notes',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  String _selectedPaymentMethod =
      'Cash on Delivery'; // Initial payment option selected

  void _showPaymentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Makes the bottom sheet scrollable
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false, // Prevents sheet from occupying full screen
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.white,
              child: SingleChildScrollView(
                controller:
                    scrollController, // Makes the bottom sheet scrollable
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Payment Method',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins"),
                      ),
                      SizedBox(height: 16),
                      _buildPaymentOption(
                        title: 'Cash on Delivery',
                        subtitle: 'Pay when the ride ends',
                        icon: Icons.money,
                        value: 'Cash on Delivery',
                      ),
                      _buildPaymentOption(
                        title: 'Pay Later After Ride',
                        subtitle: 'Pay after your ride completes',
                        icon: Icons.time_to_leave,
                        value: 'Pay Later After Ride',
                      ),
                      _buildPaymentOption(
                        title: 'Pay via Card',
                        subtitle: 'Secure credit/debit card payment',
                        icon: Icons.credit_card,
                        value: 'Pay via Card',
                      ),
                      _buildPaymentOption(
                        title: 'Pay via Wallet',
                        subtitle: 'Use your wallet balance',
                        icon: Icons.account_balance_wallet,
                        value: 'Pay via Wallet',
                      ),
                      

                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle payment confirmation here
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(12),
                            backgroundColor: Color(0xff1937d7),
                          ),
                          child: Text(
                            'Confirm Payment',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: RadioListTile(
        contentPadding: EdgeInsets.all(16),
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (String? newValue) {
          setState(() {
            _selectedPaymentMethod = newValue!;
          });
        },
        title: Row(
          children: [
            Icon(icon, size: 30, color: Color(0xff1937d7)),
            SizedBox(width: 16),
            Text(title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                  color: Color(0xff1937d7),
                )),
          ],
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
              color: Colors.grey),
        ),
      ),
    );
  }
}
