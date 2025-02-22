import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/provider/api_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Book_Now/common_widget/shimmer_loader.dart';
import '../../nav_Bar.dart';
import '../../provider/dashboard_provider.dart';
import '../../utils/colors.dart';
import '../../view/home/components/add_banner_widget.dart';
import '../../view/home/components/car_show_container.dart';
import 'customcurrent_location.dart';

class HomeView1 extends StatefulWidget {
  const HomeView1({Key? key}) : super(key: key);
  @override
  State<HomeView1> createState() => _NewHomeViewState();
}

class _NewHomeViewState extends State<HomeView1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var dashboardProvider = Provider.of<DashboardProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Row(
          children: [
            Text(
              "Book Ride",
              style: GoogleFonts.lobster(
                  fontWeight: FontWeight.w500, color: Colors.white),
            ),
            SizedBox(
             width: 96,
            ),
            Lottie.asset(
              "assets/images/car.json",
              width: 100,
              height: 200,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
      drawer: Container(color: Colors.white, child: const NavBar()),
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<ApiProvider>(
        builder: (BuildContext context, ApiProvider value, Widget? child) {
          return value.loading
              ? ShimmerLoader()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/ride_car_one.png",
                            width: 70,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4, 4), // Shadow position
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-1, -1), // Light highlight
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Text(
                              "Rent your Luxury Wheels Today",
                              style: GoogleFonts.lobster(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFB3E5FC),
                                  Color(0xFF81D4FA),
                                  Color(0xFF4FC3F7),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 60),
                            child: Column(
                              children: [

                                CarShowContainer(),
                                Row(
                                  children: [
                                    Expanded(child: CarShowContainer(),

                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  height: MediaQuery.of(context).size.height *
                                      0.20, // 25% of screen height
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    child: CurrentLocationMap(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      const AddBannerWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildButton("Complete Ride", Colors.blue),
                            buildButton("Pending Ride;", Colors.blue),
                            buildButton("Ride status", Colors.blue)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AddBannerWidget(),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
buildButton(String text, Color color) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: 117,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFADD8E6), // Light Blue
            Color(0xFFFFD700),
            Color(0xFFB3E5FC),
            Color(0xFF81D4FA),
            Color(0xFF4FC3F7),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(4, 4), // Shadow position
            blurRadius: 8,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.6),
            offset: Offset(-2, -2), // Light highlight
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontFamily: 'Poppins'),
        ),
      ),
    ),
  );
}




