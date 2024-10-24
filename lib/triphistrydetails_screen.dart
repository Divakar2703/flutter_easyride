import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'provider/histrydetails_Provider.dart';

class TriphistrydetailsScreen extends StatefulWidget {
  @override
  _TriphistrydetailsScreenState createState() =>
      _TriphistrydetailsScreenState();
}

class _TriphistrydetailsScreenState extends State<TriphistrydetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TriphistrydetailsProvider>(context, listen: false)
        .fetchTripDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Trip List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<TriphistrydetailsProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: ListTile(
                              title: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                height: 20,
                                width: double.infinity,
                                color: Colors.white,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Container(
                                    height: 14,
                                    width: 150,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    height: 14,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  if (provider.errorMessage != null) {
                    return Center(
                        child: Text('Error: ${provider.errorMessage}'));
                  }

                  if (provider.tripList.isEmpty) {
                    return Center(child: Text('No trips available'));
                  }

                  return ListView.builder(
                    itemCount: provider.tripList.length,
                    itemBuilder: (context, index) {
                      final trip = provider.tripList[index];
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text('Trip ID: ${trip.tripId}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Driver: ${trip.driverName}'),
                              Text('Date: ${trip.data}'),
                              Text('Duration: ${trip.tripDuration}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
