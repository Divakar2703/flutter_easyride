import 'package:flutter/material.dart';

class CancelRideScreen extends StatelessWidget {
  const CancelRideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancel Ride'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            const Text(
              'Are you sure you want to cancel your ride?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Please select a reason for cancellation:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            // List of reasons using RadioListTile
            Expanded(
              child: ListView(
                children: [
                  RadioListTile(
                    title: const Text('Change of plans'),
                    value: 'Change of plans',
                    groupValue: 'reason',
                    onChanged: (value) {
                      // Set selected reason here
                    },
                  ),
                  RadioListTile(
                    title: const Text('Driver is taking too long'),
                    value: 'Driver delay',
                    groupValue: 'reason',
                    onChanged: (value) {
                      // Set selected reason here
                    },
                  ),
                  RadioListTile(
                    title: const Text('Found a better price'),
                    value: 'Better price',
                    groupValue: 'reason',
                    onChanged: (value) {
                      // Set selected reason here
                    },
                  ),
                  RadioListTile(
                    title: const Text('Other'),
                    value: 'Other',
                    groupValue: 'reason',
                    onChanged: (value) {
                      // Set selected reason here
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Confirm Cancel Button
            ElevatedButton(
              onPressed: () {
                // Handle cancellation logic
                Navigator.pop(context, 'cancelled'); // Passing a cancellation result
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Center(
                child: Text(
                  'Confirm Cancellation',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
