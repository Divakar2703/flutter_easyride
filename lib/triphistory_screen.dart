
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
   
    Provider.of<TripHistoryProvider>(context, listen: false).fetchTripHistory('1');  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip History"),
      ),
      body: Column(
        children: [
       
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              
              controller: _filterController,
              decoration: InputDecoration(
              
                
                
                hintText: 'Search by Trip Namae',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(15)
                ),
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
                  return Center(child: CircularProgressIndicator());
                }
                if (provider.filteredTrips.isEmpty) {
                  return Center(child: Text('No trips found'));
                }
                return ListView.builder(
                  itemCount: provider.filteredTrips.length,
             
                  itemBuilder: (context, index) {
                    var trip = provider.filteredTrips[index];
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      color: Colors.orange,
                      decoration: BoxDecoration(
                        color: Colors.orange
                      ),
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
