import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'provider/triphistoryprovider.dart';

class TripHistoryScreen extends StatefulWidget {
  @override
  _TripHistoryScreenState createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  final TextEditingController _filterController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Provider.of<TripHistoryProvider>(context, listen: false)
        .fetchTripHistory('1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trip Histry',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.white,
            )),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _filterController,
              decoration: InputDecoration(
                hintText: 'Search by Trip Name',
                border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.circular(20)),
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Provider.of<TripHistoryProvider>(context, listen: false)
                        .filterTrips(_filterController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<TripHistoryProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Container(
                            
                            height: 80,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  );
                }
                if (provider.filteredTrips.isEmpty) {
                  return Center(child: Text('No trips found'));
                }
                return ListView.builder(
                  itemCount: provider.filteredTrips.length,
                  itemBuilder: (context, index) {
                    var trip = provider.filteredTrips[index];
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      color: Colors.orange,
                      decoration: BoxDecoration(color: Colors.orange),
                      child: ListTile(
                        title: Text(trip['trip_name'] ?? "Unknown Trip"),
                        subtitle: Text(trip['date'] ?? "No date"),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
