import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/screens/pickup_screen.dart';
import 'package:flutter_easy_ride/provider/api_provider.dart';
import 'package:provider/provider.dart';
import '../../common_widget/cab_card_widget.dart';
import '../../nav_Bar.dart';
import '../../utils/colors.dart';
import 'components/car_show_container.dart';
import 'components/add_banner_widget.dart';
import 'components/banner_slider.dart';
import 'components/location_show_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _NewHomeViewState();
}

class _NewHomeViewState extends State<HomeView> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ApiProvider>(context, listen: false)
        .getCurrentLocation()
        .then((_) {
      // After fetching auth, call the next method
      Provider.of<ApiProvider>(context, listen: false).fetchAuth();
    })
        .catchError((error) {
      // Handle errors if needed
      print("Error: $error");
    });
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      drawer: const NavBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.primaryBlue,
                expandedHeight: 280.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryBlue,
                              AppColors.gradientEnd,
                            ],
                            stops: [0.79, 0.31], // First 70% green, last 30% white
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 9,right: 14,top: 44),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Material(
                                    shape: const CircleBorder(),
                                    elevation: 4, // Adjust elevation as needed
                                    child: SizedBox(
                                      width: 38.0, // Adjust width as needed
                                      height: 38.0, // Adjust height as needed
                                      child: IconButton(
                                        onPressed: () {
                                          _scaffoldKey.currentState?.openDrawer(); // Open the drawer
                                        },
                                        splashRadius: 20,
                                        iconSize: 22.0, // Adjust icon size as needed
                                        icon: const Icon(
                                          Icons.menu,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50.0),
                                        ),
                                        child: Material(
                                          elevation: 2,
                                          borderRadius: BorderRadius.circular(50.0),
                                          child: Container(
                                            height: 44.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50.0),
                                              color: Colors.grey.shade200,
                                            ),
                                            child: const Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      hintText: 'Where To?',
                                                      hintStyle:  TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: 'Poppins', // Set Poppins as the default font
                                                      ),
                                                      border: InputBorder.none,
                                                      contentPadding:  EdgeInsets.symmetric(
                                                          horizontal: 32.0, vertical: 12),
                                                      prefixIcon:  Padding(
                                                        padding: EdgeInsets.all(12.0),
                                                        child: Icon(
                                                          Icons.search_outlined,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                      suffixIcon:  Padding(
                                                        padding: EdgeInsets.all(11.0),
                                                        child: Icon(
                                                          Icons.mic,
                                                          color: Colors.black54,
                                                          size: 22,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const  SizedBox(height: 22,),
                              ShaderMask(
                                shaderCallback: (bounds) =>const LinearGradient(
                                  colors: [
                                    AppColors.yellowText,
                                    AppColors.lightYellowText
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds),
                                child: const Text(
                                  "Easy Ride",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 34,
                                    color: Colors.white, // This color will be masked by the gradient
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins', // Set Poppins as the default font
                                  ),
                                ),
                              ),
                              const  Text(
                                "Ride Easy, Arrive Happy",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white, // This color will be masked by the gradient
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins', // Set Poppins as the default font
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                bottom: const PreferredSize(
                  preferredSize:  Size.fromHeight(63.0),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                    child:CarShowContainer(),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [

                  const LocationShowWidget(),

                    const BannerSlider(),
                    const  Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Commute smarter",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                              //letterSpacing: 1.0, // Adjust this value as needed
                            ),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                    const AddBannerWidget(),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
