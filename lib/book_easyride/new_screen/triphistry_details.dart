// // import 'package:flutter/material.dart';
// // import 'package:flutter_easy_ride/book_easyride/custom/header.dart';
// // import 'package:provider/provider.dart';
// // import '../provider/trip_histrydetailsprovider.dart';

// // class TripHistoryScreen extends StatefulWidget {
// //   @override
// //   _TripHistoryScreenState createState() => _TripHistoryScreenState();
// // }

// // class _TripHistoryScreenState extends State<TripHistoryScreen> {
// //   @override
// //   void initState() {
// //     super.initState();

// //     Future.delayed(Duration.zero, () {
// //       final tripHistoryProvider =
// //           Provider.of<TripHistoryProvider>(context, listen: false);
// //       tripHistoryProvider.fetchTripHistory("Book-00852362");
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final tripHistoryProvider = Provider.of<TripHistoryProvider>(context);
// //     final trip = tripHistoryProvider.tripData;
// //     // final trips = tripHistoryProvider.tripData?.trip ?? [];

// //     if (trip == null) {
// //       return Container();
// //     }

// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         backgroundColor: Colors.lightBlue,
// //         title: const Text(
// //           'Trip History',
// //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(10.0),
// //         child: ListView.builder(
// //           // itemCount: 1,
// //           // itemCount: trip.length,
// //           itemBuilder: (context, index) {
// //             // final trip = trip[index];
// //             return Container(
// //               margin: const EdgeInsets.only(bottom: 10),
// //               padding: const EdgeInsets.all(15),
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(2),
// //                 color: Colors.white,
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.grey.withOpacity(0.5),
// //                     spreadRadius: 2,
// //                     blurRadius: 5,
// //                   ),
// //                 ],
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Icon(
// //                         Icons.location_on,
// //                         color: Color.fromARGB(255, 0, 128, 0),
// //                       ),
// //                       const SizedBox(width: 8),
// //                       Expanded(
// //                         child: Header(
// //                           title: trip.pickupAddress ?? 'Not data avalable',
// //                         ),
// //                       ),
// //                     ],
// //                   ),

// //                  VerticalDivider(
// //                   color: Colors.black,
// //                   width: 10,
// //                   thickness: 3,
// //                   indent: 3,
// //                   endIndent: 10,
// //                  ),
// //                   const SizedBox(height: 20),
// //                   Row(
// //                     children: [
// //                       Icon(
// //                         Icons.location_on,
// //                         color: Colors.redAccent,
// //                       ),
// //                       const SizedBox(width: 8),
// //                       Expanded(
// //                         child: Header(
// //                           title: trip.dropAddress,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const Divider(),

// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Header(
// //                         title: 'Ride Status',
// //                       ),
// //                       Header(
// //                         title: trip.rideStatus == 'Completed'
// //                             ? 'Completed'
// //                             : 'Pending',
// //                       )
// //                     ],
// //                   ),

// //                   SizedBox(
// //                     height: 10,
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Header(
// //                         title: 'vehicle_image',
// //                       ),
// //                       Header(
// //                         image: trip.vehicleImage,
// //                       )
// //                     ],
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Header(
// //                         title: 'driver_img',
// //                       ),
// //                       Header(
// //                         image: trip.driverImg,
// //                       )
// //                     ],
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Header(
// //                         title: 'Trip Date',
// //                       ),
// //                       Header(
// //                         title: trip.entryDate,
// //                       )
// //                     ],
// //                   ),
// //                   SizedBox(
// //                     height: 5,
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Header(
// //                         title: 'Total Fare',
// //                       ),
// //                       Header(
// //                         title: trip.totalFare,
// //                       )
// //                     ],
// //                   ),
// //                   SizedBox(
// //                     height: 5,
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Header(
// //                         title: 'Vehicle',
// //                       ),
// //                       Header(
// //                         title: trip.vehicle,
// //                       )
// //                     ],
// //                   ),
// //                   SizedBox(
// //                     height: 5,
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Header(
// //                         title: 'Driver Name',
// //                       ),
// //                       Header(
// //                         title: trip.driverName,
// //                       )
// //                     ],
// //                   ),
// //                   SizedBox(
// //                     height: 5,
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Header(
// //                         title: 'Totat Wait charge',
// //                       ),
// //                       Header(
// //                         title: trip.totalWaitCharge,
// //                       )
// //                     ],
// //                   ),
// //                   SizedBox(
// //                     height: 5,
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Header(
// //                         title: 'Ride Status',
// //                       ),
// //                       Header(
// //                         title: trip.rideStatus,
// //                       )
// //                     ],
// //                   ),
// //                   SizedBox(
// //                     height: 5,
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Header(
// //                         title: 'Payment Status',
// //                       ),
// //                       Header(
// //                         title: trip.paymentStatus,
// //                       )
// //                     ],
// //                   ),
// //                   SizedBox(
// //                     height: 5,
// //                   ),
// //                   // Row(
// //                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   //   children: [
// //                   //     Header(
// //                   //       title: 'Payment Type',
// //                   //     ),
// //                   //     Header(
// //                   //       title: trip.paymenttype,
// //                   //     )
// //                   //   ],
// //                   // ),
// //                   SizedBox(
// //                     height: 5,
// //                   ),
// //                   // Row(
// //                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   //   children: [
// //                   //     Header(
// //                   //       title: 'Post PaymentType',
// //                   //     ),
// //                   //     Header(
// //                   //       title: trip.postPaymentType,
// //                   //     )
// //                   //   ],
// //                   // ),

// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Header(
// //                         title: 'Arrive Distination',
// //                       ),
// //                       Header(
// //                         title: trip.isArrivedDestination,
// //                       )
// //                     ],
// //                   ),

// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Header(
// //                         title: 'Success',
// //                       ),
// //                       Header(
// //                         title: trip.status,
// //                       )
// //                     ],
// //                   ),

// //                   SizedBox(
// //                     height: 10,
// //                   ),
// //                 ],
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/trip_histrydetailsprovider.dart';


// class TripHistryDetailsScreen extends StatefulWidget {
//   const TripHistryDetailsScreen({super.key});
//   @override
//   State<TripHistryDetailsScreen> createState() =>
//       _TripHistryDetailsScreenState();
// }
// class _TripHistryDetailsScreenState extends State<TripHistryDetailsScreen> {

//    @override
//   void initState() {
//     super.initState();
    
//     // Future.microtask(() {
//       Provider.of<TripHistryDetailsProviders>(context, listen: false).fetchTripHistryDetails();
//           // .fetchTripHistryDetails("Book-00852362" as int);
//     // });
//   }
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Trip Histry Details'),
//       ),
//       body: Consumer<TripHistryDetailsProviders>(
//         builder: (context, provider, _) {
//           return ListView.builder(
//             itemCount: provider.TripHistryDetailsList!.length,
//             itemBuilder: (context, index) {
//               final trips = provider.TripHistryDetailsList![index];
//               return Column(
//                 children: [Text(trips.driverName ?? '')],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/trip_histrydetailsprovider.dart';

class TripHistoryScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip History Details'),
      ),
      body: FutureBuilder(
        future: Provider.of<TripHistrydetailsprovider>(context, listen: false)
            .fetchHistoryDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<TripHistrydetailsprovider>(
              builder: (context, tripHistoryProvider, child) {
                return ListView.builder(
                  itemCount: tripHistoryProvider.historyList.length,
                  itemBuilder: (context, index) {
                    final history = tripHistoryProvider.historyList[index];
                    return ListTile(
                      leading: Image.network(history.vehicleImage ?? ''),
                      title: Text(history.vehicle ?? 'Vehicle'),
                      subtitle: Text('Fare: ₹${history.grandTotal ?? '0'}'),
                      trailing: Text(history.rideStatus ?? 'Status'),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
