import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/histrydetails_Provider.dart';


class TriphistrydetailsScreen extends StatefulWidget {
  @override
  _TriphistrydetailsScreenState createState() => _TriphistrydetailsScreenState();
}

class _TriphistrydetailsScreenState extends State<TriphistrydetailsScreen> {
  @override
  void initState() {
    super.initState();
   
    Provider.of<TriphistrydetailsProvider>(context, listen: false).fetchTripDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trip List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
          
            Expanded(
              child: Consumer<TriphistrydetailsProvider>(
                builder: (context, provider, child) {

                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator()); 
                    
                  }

                  if (provider.errorMessage != null) {
                    return Center(child: Text('Error: ${provider.errorMessage}')); 
                   
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
