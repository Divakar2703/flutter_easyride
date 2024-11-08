import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/profile_Screen.dart';
import 'book_easyride/new_screen/triphistry.dart';
import 'notification_Screen.dart';

final Color kDarkBlueColor = const Color(0xff1937d7);

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'BitsPan India',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
            accountEmail: Text('+91-5484389989'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/user.png',
                  width: 55,
                  height: 55,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: kDarkBlueColor,
              // image: DecorationImage(
              //     image: AssetImage('gggg'), fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person_sharp,
              color: Colors.grey,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.payment_outlined,
              color: Colors.grey,
            ),
            title: Text(
              'Payment',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins', // Set Poppins as the default font
              ),
            ),
            onTap: () {
              //    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.time_to_leave_outlined,
              color: Colors.grey,
            ),
            title: Text(
              'My Rides',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins', // Set Poppins as the default font
              ),
            ),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => BannerScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_none_rounded,
              color: Colors.grey,
            ),
            title: Text(
              "Notification",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins', // Set Poppins as the default font
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.grey,
            ),
            title: Text(
              'Setting',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins', // Set Poppins as the default font
              ),
            ),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => TestimonialsScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.history,
              color: Colors.grey,
            ),
            title: Text(
              'History',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins', // Set Poppins as the default font
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TripHistory()),
                
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help_outline,
              color: Colors.grey,
            ),
            title: Text(
              'Help',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins', // Set Poppins as the default font
              ),
            ),
            onTap: () {
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => UserPlansScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
              color: Colors.grey,
            ),
            title: Text(
              'LogOut',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins', // Set Poppins as the default font
              ),
            ),
            onTap: () => print('dora'),
          ),
        ],
      ),
    );
  }
}
