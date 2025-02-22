import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/common_widget/shimmer_loader.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../model/driver_details.dart';
import '../../payment/cab_payment_page.dart';
import '../../payment/razorpay/PhonePeGatewayWebview.dart';
import '../../service/socket/socket_helper.dart';
import '../../utils/eve.dart';
import 'time.dart';

class ConfirmBooking extends StatefulWidget {
  int? requestID;
   ConfirmBooking({super.key, this.requestID});

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  final SocketHelper socketHelper = SocketHelper();

  @override
  void initState() {
    socketHelper.connect();
    socketHelper.findDriver(selectedVehicle, "15"); // Replace with actual IDs

    // Example: Call findDriver after connection
   // socketHelper.findDriver(selectedVehicle, "15"); // Replace with actual IDs
   // final convcharges = Provider.of<CabBookProvider>(context, listen: false).convcharge();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final convcharges = Provider.of<CabBookProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Confirm Booking',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:
      //bookingID!=""?
      StreamBuilder<DriverDetails>(
        stream: socketHelper.driverDetailsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: ShimmerLoader());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("No driver data received"));
          } else {
            final driverDetails = snapshot.data!;
            return       Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    buildBookingTimeContainer(),
                    SizedBox(height: 10),
                    buildDriverInfo(driverDetails.driverProfilePic,driverDetails.driverName,driverDetails.mobileNo),
                    SizedBox(height: 10),
                    buildRideDetails(driverDetails.userJourneyDistance.toString(),driverDetails.driverAway.toString(),driverDetails.vehicleImage,driverDetails.vehicleName),
                    SizedBox(height: 10),
                    buildLocationInfo(driverDetails.pickupAddress,driverDetails.dropAddress),
                    SizedBox(height: 20),
                    // convcharge(),
                    SizedBox(height: 10),
                    buildPriceDetails(driverDetails.totalFare),
                    SizedBox(height: 20),
                    buildConfirmButton(int.parse(driverDetails.sendRequestId),driverDetails.totalFare),
                  ],
                ),
              ),
            );

        }
        },
      )
          //:ShimmerLoader()

    );
  }

  Widget buildBookingTimeContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: containerDecoration(),
      child: Column(
        children: [
          Text(
            'You have just 9 minutes left to make your booking. Act fast, or you might miss out!',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w200,
                fontSize: 13),
          ),
          SizedBox(height: 20),
          ProgressIndicatorPage(),
        ],
      ),
    );
  }

  Widget buildDriverInfo(String image,String name,String number,) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(12.0),
      width: double.infinity,
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Driver Profile Picture
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              image=="https://asatvindia.in/cab/null"?"https://cdn-icons-png.flaticon.com/512/8583/8583437.png":image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),

          // Driver Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Driver Name and Contact
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  '📞 $number',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          // Vehicle Details
        ],
      ),
    );

    //   Container(
    //   decoration: containerDecoration(),
    //   padding: EdgeInsets.all(8.0),
    //   width: double.infinity,
    //   height: 90,
    //   child: Row(
    //     children: [
    //       Image.asset(
    //         "assets/images/driver1.jpg",
    //         width: 40,
    //         height: 40,
    //         fit: BoxFit.cover,
    //       ),
    //       SizedBox(width: 10),
    //       Expanded(
    //         child: Text(
    //           'Sachin Kumar',
    //           style: TextStyle(
    //             fontFamily: 'Poppins',
    //             fontWeight: FontWeight.w500,
    //             fontSize: 13,
    //           ),
    //           overflow: TextOverflow.ellipsis,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget buildRideDetails(String distance,String away,String vehicleImg,String vehicleName,) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: containerDecoration(),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  vehicleImg,
                  width: 60,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 4),
              Text(
                vehicleName,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

            ],
          ),
          SizedBox(width: 20),
          Column(
            children: [
              Text(
                'Driver arrives',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: Colors.green[700],
                ),
              ),
              SizedBox(height: 4),

              Text(
                'in $away min',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Distance',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 4),

              Text(
                '$distance km',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLocationInfo(String pickupAddress,String dropAddress) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: containerDecoration(),
      child: Column(
        children: [
          locationRow(
              Icons.location_on, Colors.green, '$pickupAddress'),
          SizedBox(height: 5),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    child:
                        Icon(Icons.more_vert, color: Colors.black, size: 24.0),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Column(
                children: [],
              ),
            ),
          ),
          locationRow(
              Icons.location_on, Colors.red, '$dropAddress'),
        ],
      ),
    );
  }

  Widget locationRow(IconData icon, Color color, String location) {
    return Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            location,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }

  // Widget convcharge() {
  //   final convcharges = Provider.of<CabBookProvider>(context);

  //   return Container(
  //     child: Column(
  //       children: [
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Text(
  //               convcharges.paytype!.convCharge == null
  //                   ? 'convcharge'
  //                   : "conv charge",
  //               style: TextStyle(
  //                   fontSize: 13,
  //                   fontFamily: 'Poppins',
  //                   fontWeight: FontWeight.w500),
  //             ),
  //             SizedBox(
  //               width: 20,
  //             ),
  //             Text(
  //               convcharges.paytype!.convCharge,
  //               style: TextStyle(
  //                   fontSize: 13,
  //                   fontFamily: 'Poppins',
  //                   fontWeight: FontWeight.w500),
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildPriceDetails(double totalfare) {
    final convcharges = Provider.of<CabBookProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: containerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Image.asset("assets/images/rupaya.jpg", width: 40, height: 40),
              SizedBox(width: 10),
              Text(
                'Price Details',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          SizedBox(height: 10),
          Row(
            crossAxisAlignment:  CrossAxisAlignment.start,
            mainAxisAlignment:  MainAxisAlignment.start,
            children: [
              Text(
                convcharges.paytype!.convCharge == null
                    ? 'Conv charge'
                    : 'Conv charge',
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(convcharges.paytype!.convCharge),
                  SizedBox(width: 3),
                  Text('₹'),
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment:  CrossAxisAlignment.start,
            mainAxisAlignment:  MainAxisAlignment.start,
            children: [
              Text(
                'Total Fare',
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(totalfare.toString()),
                  SizedBox(width: 3),
                  Text('₹'),
                ],
              )
            ],
          ),

          SizedBox(height: 10),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedBank,
              hint: Text('Online',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Poppins',
                      color: Colors.black)),
              icon: Icon(Icons.arrow_forward_ios_outlined),
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  selectedBank = newValue??"COD";
                });
              },
              items: banks.map<DropdownMenuItem<String>>((bank) {
                return DropdownMenuItem<String>(
                  value: bank['name'],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Image.asset(bank['image'], width: 30, height: 30),
                        SizedBox(width: 30),
                        Text(bank['name']),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          selectedBank!="COD"?Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            InkWell(
              onTap: (){
                if(selectedBank=="online"){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CabPaymentPage(orderId: orderID,convCharge: convcharges.paytypes?.convCharge,)));
                }
                else if(selectedBank=="razorpay"){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CabPaymentPage()));

                }
                else if(selectedBank=="phonepay"){
                  if(transactionID==""){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PhonePeGatewayWebView(orderId: orderID, txnAmount: 1,)));
                  }
                  else{
                    Fluttertoast.showToast(msg: "Your payment is done using $selectedBank Methods");
                  }
                }
                else {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CabPaymentPage()));
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: transactionID==""?Text("PAY",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),):Text("PAID",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),),
              ),
            )
          ],):Container()
        ],
      ),
    );
  }

  Widget buildConfirmButton(int requestID,double fare,) {
    var cabBookProvider=Provider.of<CabBookProvider>(context);
    final convcharges = Provider.of<CabBookProvider>(context);

    return InkWell(
      onTap:(){
        if(selectedBank!="COD"){
          if(transactionID!=""){

            cabBookProvider.bookCab(requestID, selectedBank??"COD", transactionID, fare,double.parse(convcharges.paytype!.convCharge) );
          }
          else{
            Fluttertoast.showToast(msg: "Please proceed to pay first on selected pay method $selectedBank");

          }

          //cabBookProvider.bookCab(requestID, selectedBank??"", "", fare, 0);

        }
        else{
          cabBookProvider.bookCab(requestID, "COD", "", fare, 0);

        }

      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 100),
        child: Consumer<CabBookProvider>(
          builder: (BuildContext context, CabBookProvider value, Widget? child) {
            print("status===${value.confirmBookingStatus}");
            if(value.confirmBookingStatus=="success"){
              socketHelper.confirmOrRejectRequest(reqId: requestID.toString(), isConfirm: "1", isReject: "0");
              return Text(
                'Confirmed',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.white),
              );

          }
            else {
            return Text(
            'Confirm Booking',
            style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Colors.white),
            );

            }
          },

        ),
      ),
    );
  }

  BoxDecoration containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 5,
          spreadRadius: 2,
          offset: Offset(0, 3),
        ),
      ],
    );
  }

  TextStyle textStyle() {
    return TextStyle(
        fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 13);
  }

}

