import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/screens/book_now_screen.dart';
import 'package:flutter_easy_ride/Pre_Booking/screens/pre_booking_screen.dart';
import 'package:flutter_easy_ride/view/authentication/login.dart';
import 'package:flutter_easy_ride/view/dashboard/dashboard_map.dart';

import '../../rental/rental_hourly_and_recurring_view.dart';
import '../../utils/local_storage.dart';

class CabDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String? userNumber;

  CabDrawer({
    required this.userName,
    required this.userEmail,
    this.userNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue
            ),
            accountName: Text(userName, style: TextStyle(fontSize: 18,color: Colors.white)),
            accountEmail: Text(userEmail,style: TextStyle(color: Colors.white),),
            // currentAccountPicture: CircleAvatar(
            //   child: Icon(Icons.person, size: 40),
            // ),
            otherAccountsPictures: userNumber != null
                ? [Text(userNumber!, style: TextStyle(color: Colors.white))]
                : null,
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardMap()));
            //  Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            leading: Icon(Icons.local_taxi),
            title: Text('Book Now'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookNowScreen()));

              // Navigator.pushNamed(context, '/book_now');
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Pre Booking'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PreBookingScreen()));

              // Navigator.pushNamed(context, '/pre_booking');
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text('Rental'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>RentalHourlyAndRecurringView()));

              //Navigator.pushNamed(context, '/rental');
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Recent Booking'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RentalHourlyAndRecurringView()));

              //Navigator.pushNamed(context, '/recent_booking');
            },
          ),
          Spacer(),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              _showLogoutConfirmation(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Perform logout action
                Navigator.of(context).pop();
                await LocalStorage.saveUserID("");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
