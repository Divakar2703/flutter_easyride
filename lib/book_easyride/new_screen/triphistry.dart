import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/trip_histry_provider.dart';

class TripHistoryScreens extends StatefulWidget {
  @override
  _TripHistoryScreensState createState() => _TripHistoryScreensState();
}

class _TripHistoryScreensState extends State<TripHistoryScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TripHistoryProviders>(context, listen: false)
          .fetchTripHistory(6, 1, '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(
            'Trip History',
            style: TextStyle(color: Colors.white),
          )),
      body: Consumer<TripHistoryProviders>(
        builder: (context, provider, _) {
          if (provider.tripHistoryList == null ||
              provider.tripHistoryList!.isEmpty) {
            return Center(child: Container());
          }
          return ListView.builder(
            itemCount: provider.tripHistoryList!.length,
            itemBuilder: (context, index) {
              final trip = provider.tripHistoryList![index];
              return Column(
                children: [
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Colors.green),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          trip.pickupAddress ??
                                              'No Pickup Address',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              fontFamily: 'Poppins'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Colors.red),
                                      SizedBox(width: 3),
                                      Expanded(
                                        child: Text(
                                          trip.dropAddress ?? 'No Drop Address',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        InkWell(
                          // onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => TripHistoryScreen()));
                          // },
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trip.rideStatus ?? '',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                )
                              ]),
                        ),
                        Text(
                          trip.vehicle ?? '',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
