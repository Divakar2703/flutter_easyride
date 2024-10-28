import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/book_easyride/custom/header.dart';
import 'package:provider/provider.dart';
import '../provider/trip_histrydetailsprovider.dart';

class TripHistoryScreen extends StatefulWidget {
  @override
  _TripHistoryScreenState createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final tripHistoryProvider =
          Provider.of<TripHistoryProvider>(context, listen: false);
      tripHistoryProvider.fetchTripHistory("Book-00852362");
    });
  }

  @override
  Widget build(BuildContext context) {
    final tripHistoryProvider = Provider.of<TripHistoryProvider>(context);
    final trip = tripHistoryProvider.tripData;
    // final trips = tripHistoryProvider.tripData?.trip ?? [];

    if (trip == null) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Trip History',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 1,
          // itemCount: trip.length,
          itemBuilder: (context, index) {
            // final trip = trip[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Color.fromARGB(255, 0, 128, 0),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Header(
                          title: trip.pickupAddress ?? 'Not data avalable',
                        ),
                      ),
                    ],
                  ),
                   

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Header(
                          title: trip.dropAddress,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        title: 'Ride Status',
                      ),
                      Header(
                        title: trip.rideStatus == 'Completed' ? 'Completed'  : 'Pending',
                      )
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        title: 'vehicle_image',
                      ),
                      Header(
                        image: trip.vehicleImage,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        title: 'driver_img',
                      ),
                      Header(
                        image: trip.driverImg,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        title: 'Trip Date',
                      ),
                      Header(
                        title: trip.entryDate,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        title: 'Total Fare',
                      ),
                      Header(
                        title: trip.totalFare,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        title: 'Vehicle',
                      ),
                      Header(
                        title: trip.vehicle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        title: 'Driver Name',
                      ),
                      Header(
                        title: trip.driverName,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        title: 'Driver Contact',
                      ),
                      Header(
                        title: trip.deliveryboyMobileNo,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        title: 'Ride Status',
                      ),
                      Header(
                        title: trip.rideStatus,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        title: 'Payment Status',
                      ),
                      Header(
                        title: trip.paymentStatus,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        title: 'Payment Type',
                      ),
                      Header(
                        title: trip.paymenttype,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        title: 'Vehicle Number',
                      ),
                      Header(
                        title: trip.vehicleNumber,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
