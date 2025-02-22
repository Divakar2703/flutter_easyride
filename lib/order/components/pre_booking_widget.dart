import 'package:flutter/material.dart';

import '../../model/booking.dart';

class PreBookingWidget extends StatelessWidget {
  List<Booking> bookingList;
   PreBookingWidget({super.key,required this.bookingList});

  final List<Map<String, dynamic>> bookingData = const [
    {
      'carType': 'SUV Car',
      'price': '547.00',
      'startTime': '2:38 AM',
      'duration': '8h 53m',
      'endTime': '4:38 PM',
      'startLocation': 'Gurugram',
      'endLocation': 'Delhi,Mg',
      'route': 'Gurugram,Delhi,Mg',
      'returnRoute': 'Delhi,Mg,Gurugram'
    },
    // {
    //   'carType': 'Sedan Car',
    //   'price': '524.00',
    //   'startTime': '3:38 AM',
    //   'duration': '2h 53m',
    //   'endTime': '1:38 PM',
    //   'startLocation': 'Delhidl',
    //   'endLocation': 'raja,Mg',
    //   'route': 'Mohd,Delhi,Mg',
    //   'returnRoute': 'dwpmf j'
    // },
    // Add more entries here if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: bookingList.length,
          itemBuilder: (context, index) {
            var data = bookingList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Card(
                elevation: 2,
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            data.bookingType,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Color(0xff1937d7),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.currency_rupee_rounded,
                            color: Colors.black87,
                            size: 20,
                          ),
                          Text(
                            data.totalFare,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Start",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              fontSize: 19,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Divider(
                              thickness: 1.8,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.6,
                              ),
                            ),
                            child: Text(
                              data.userJourneyDistance,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1.8,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "End",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              fontSize: 19,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width:MediaQuery.of(context).size.width*0.4,
                            child: Text(
                              data.pickupAddress,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width:MediaQuery.of(context).size.width*0.4,

                            child: Text(
                              data.dropAddress,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Status",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          Spacer(),
                          Text(
                            data.rideStatus,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              margin:   EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1.6,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                 "One Way",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding:
                              EdgeInsets.symmetric( horizontal:4,vertical: 4),
                              margin:   EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1.6,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person,color: Colors.grey.shade600,size: 20,),
                                  Text(
                                    "  02",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                              margin:   EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1.6,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    " Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_down_rounded,color: Colors.grey.shade600,size: 20,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        ),


      ],
    );
  }
}
