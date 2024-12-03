import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/book_easyride/model/triphistry.dart';
import 'package:flutter_easy_ride/book_easyride/new_screen/triphistry_details.dart';
import 'package:provider/provider.dart';
import '../provider/triphistry_provider.dart';

// class TripHistoryScreens extends StatefulWidget {
//   @override
//   _TripHistoryScreensState createState() => _TripHistoryScreensState();
// }

// class _TripHistoryScreensState extends State<TripHistoryScreens> {
//   @override
//   void initState() {
//     Provider.of<TriphistryProvider>(context, listen: false).GetHistory();

//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<TripHistoryProviders>(context, listen: false)
//           .fetchTripHistory(6, 1, '');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Colors.blue,
//           title: Text(
//             'Trip History',
//             style: TextStyle(color: Colors.white),
//           )),
//       body: Consumer<TripHistoryProviders>(
//         builder: (context, provider, _) {
//           if (provider.tripHistoryList == null ||
//               provider.tripHistoryList!.isEmpty) {
//             return Container();
//           }
//           return ListView.builder(
//             itemCount: provider.tripHistoryList!.length,
//             itemBuilder: (context, index) {
//               final trip = provider.tripHistoryList![index];
//               return Column(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(Icons.location_on,
//                                           color: Colors.green),
//                                       SizedBox(width: 5),
//                                       Expanded(
//                                         child: Text(
//                                           trip.pickupAddress ??
//                                               'No Pickup Address',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w400,
//                                               fontSize: 12,
//                                               fontFamily: 'Poppins'),
//                                         ),
//                                       ),
//                                     ],
//                                   ),

//                                   Row(children: [Column(children: [Icon(Icons.more_vert, color: Colors.black,)])]),
//                                   SizedBox(height: 15),
//                                   Row(
//                                     children: [
//                                       Icon(Icons.location_on,
//                                           color: Colors.red),
//                                       SizedBox(width: 3),
//                                       Expanded(
//                                         child: Text(
//                                           trip.dropAddress ?? 'No Drop Address',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: 12,
//                                             fontFamily: 'Poppins',
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Divider(),
//                         InkWell(
//                           onTap: () {
//                             // Navigator.push(
//                             //     context,
//                             //     MaterialPageRoute(
//                             //         builder: (context) => HistryDetails()));
//                           },
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 trip.rideStatus ?? '',
//                                 style: TextStyle(
//                                     color: Colors.blue,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12),
//                               )
//                             ],
//                           ),
//                         ),
//                         Text(
//                           trip.vehicle ?? '',
//                           style: TextStyle(
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w400,
//                               fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => HistryDetails()));
//                     },
//                     child: Container(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// 1. updated code in a list all history details

class TripHistory extends StatefulWidget {
  const TripHistory({super.key});

  @override
  State<TripHistory> createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {
  late TriphistryProvider historyProvider;

  @override
  void initState() {
    historyProvider = Provider.of<TriphistryProvider>(context, listen: false);
    historyProvider.GetHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Trip Histry',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
      ),
      body: Consumer<TriphistryProvider>(
        builder: (context, provider, child) {
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistryDetails()));
            },
            child: ListView.builder(
              itemCount: provider.historyList.length,
              itemBuilder: (context, index) {
                final item = provider.historyList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.green),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  item.pickupAddress ?? 'No Pickup Address',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [Icon(Icons.more_vert)],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.red),
                              SizedBox(width: 3),
                              Expanded(
                                child: Text(
                                  item.dropAddress ?? 'No Drop Address',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                rideStatusValues.reverse[item.rideStatus] ?? '',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                vehicleValues.reverse[item.vehicle] ?? '',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
