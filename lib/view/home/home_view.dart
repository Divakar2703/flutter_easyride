// import 'package:flutter/material.dart';
// import 'package:flutter_easy_ride/provider/api_provider.dart';
// import 'package:provider/provider.dart';
//
// import '../../Book_Now/common_widget/shimmer_loader.dart';
// import '../../nav_Bar.dart';
// import '../../order/components/pre_booking_widget.dart';
// import '../../order/pre_booking_order_view.dart';
// import '../../provider/dashboard_provider.dart';
// import '../../utils/colors.dart';
// import 'components/add_banner_widget.dart';
// import 'components/car_show_container.dart';
//
// class HomeView extends StatefulWidget {
//   const HomeView({Key? key}) : super(key: key);
//   @override
//   State<HomeView> createState() => _NewHomeViewState();
// }
//
// class _NewHomeViewState extends State<HomeView> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Provider.of<ApiProvider>(context, listen: false).getCurrentLocation().then((_) {
//       // After fetching auth, call the next method
//       Provider.of<ApiProvider>(context, listen: false).fetchAuth();
//     }).catchError((error) {
//       // Handle errors if needed
//       print("Error: $error");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var dashboardProvider = Provider.of<DashboardProvider>(context);
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: const NavBar(),
//       backgroundColor: AppColors.backgroundColor,
//       body: Consumer<ApiProvider>(
//         builder: (BuildContext context, ApiProvider value, Widget? child) {
//           return value.loading
//               ? ShimmerLoader()
//               : Stack(
//                   children: [
//                     CustomScrollView(
//                       slivers: [
//                         SliverAppBar(
//                           backgroundColor: AppColors.primaryBlue,
//                           expandedHeight: 280.0,
//                           floating: false,
//                           pinned: true,
//                           flexibleSpace: FlexibleSpaceBar(
//                             collapseMode: CollapseMode.pin,
//                             background: Stack(
//                               children: [
//                                 Container(
//                                   decoration: const BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         AppColors.primaryBlue,
//                                         AppColors.gradientEnd,
//                                       ],
//                                       stops: [0.79, 0.31], // First 70% green, last 30% white
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                     ),
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 9, right: 14, top: 44),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Material(
//                                               shape: const CircleBorder(),
//                                               elevation: 4, // Adjust elevation as needed
//                                               child: SizedBox(
//                                                 width: 38.0, // Adjust width as needed
//                                                 height: 38.0, // Adjust height as needed
//                                                 child: IconButton(
//                                                   onPressed: () {
//                                                     _scaffoldKey.currentState?.openDrawer(); // Open the drawer
//                                                   },
//                                                   splashRadius: 20,
//                                                   iconSize: 22.0, // Adjust icon size as needed
//                                                   icon: const Icon(
//                                                     Icons.menu,
//                                                     color: Colors.transparent,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius.circular(50.0),
//                                                   ),
//                                                   child: Material(
//                                                     elevation: 2,
//                                                     borderRadius: BorderRadius.circular(50.0),
//                                                     child: Container(
//                                                       height: 44.0,
//                                                       decoration: BoxDecoration(
//                                                         borderRadius: BorderRadius.circular(50.0),
//                                                         color: Colors.grey.shade200,
//                                                       ),
//                                                       child: const Row(
//                                                         children: [
//                                                           Expanded(
//                                                             child: TextField(
//                                                               decoration: InputDecoration(
//                                                                 hintText: 'Where To?',
//                                                                 hintStyle: TextStyle(
//                                                                   color: Colors.black54,
//                                                                   fontSize: 15,
//                                                                   fontWeight: FontWeight.w400,
//                                                                   fontFamily:
//                                                                       'Poppins', // Set Poppins as the default font
//                                                                 ),
//                                                                 border: InputBorder.none,
//                                                                 contentPadding: EdgeInsets.symmetric(
//                                                                     horizontal: 32.0, vertical: 12),
//                                                                 prefixIcon: Padding(
//                                                                   padding: EdgeInsets.all(12.0),
//                                                                   child: Icon(
//                                                                     Icons.search_outlined,
//                                                                     color: Colors.black54,
//                                                                   ),
//                                                                 ),
//                                                                 suffixIcon: Padding(
//                                                                   padding: EdgeInsets.all(11.0),
//                                                                   child: Icon(
//                                                                     Icons.mic,
//                                                                     color: Colors.black54,
//                                                                     size: 22,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 22,
//                                         ),
//                                         ShaderMask(
//                                           shaderCallback: (bounds) => const LinearGradient(
//                                             colors: [AppColors.yellowText, AppColors.lightYellowText],
//                                             begin: Alignment.topLeft,
//                                             end: Alignment.bottomRight,
//                                           ).createShader(bounds),
//                                           child: const Text(
//                                             "Easy Ride",
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               fontSize: 34,
//                                               color: Colors.white, // This color will be masked by the gradient
//                                               fontWeight: FontWeight.w600,
//                                               fontFamily: 'Poppins', // Set Poppins as the default font
//                                             ),
//                                           ),
//                                         ),
//                                         const Text(
//                                           "Ride Easy, Arrive Happy",
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             color: Colors.white, // This color will be masked by the gradient
//                                             fontWeight: FontWeight.w500,
//                                             fontFamily: 'Poppins', // Set Poppins as the default font
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           bottom: const PreferredSize(
//                             preferredSize: Size.fromHeight(63.0),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//                               child: CarShowContainer(),
//                             ),
//                           ),
//                         ),
//                         SliverList(
//                           delegate: SliverChildListDelegate(
//                             [
//                               // GestureDetector(
//                               //     child: const LocationShowWidget()),
//                               //  BannerSlider(banners: dashboardProvider.dashboardResponse!.banner,
//                               //
//                               //  ),
//
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Orders details",
//                                       style: TextStyle(
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.black87,
//                                         fontFamily: 'Poppins',
//                                       ),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.push(
//                                             context, MaterialPageRoute(builder: (context) => PreBookingOrderView()));
//                                       },
//                                       child: Text(
//                                         "See all",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w500,
//                                           color: Color(0xff1937d7),
//                                           fontFamily: 'Poppins',
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               PreBookingWidget(
//                                 bookingList: dashboardProvider.bookinglist,
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Commute smarter",
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.black87,
//                                         fontFamily: 'Poppins',
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               const AddBannerWidget(),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/utils/constant.dart';
import 'package:flutter_easy_ride/view/booking/provider/common_provider.dart';
import 'package:flutter_easy_ride/view/booking/ui/booking_screen.dart';
import 'package:flutter_easy_ride/view/components/common_textfield.dart';
import 'package:flutter_easy_ride/view/components/image_text_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height - 250,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: AppColors.white),
          child: GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(18.512457, 73.843106),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(99),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.2),
                        offset: Offset(0, 4),
                        blurRadius: 12,
                      )
                    ],
                  ),
                  child: Image.asset(AppImage.appLogo, width: 40, height: 40),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CommonTextField(
                    borderRadius: 12,
                    hintText: "Set Destination",
                    fillColor: AppColors.white.withOpacity(0.7),
                    borderColor: AppColors.borderColor.withOpacity(0.1),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(AppImage.menu, width: 24, height: 24),
                    ),
                    suffix: SvgPicture.asset(AppImage.search, width: 24, height: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.6,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: BorderDirectional(top: BorderSide(color: AppColors.yellow)),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.2),
                      offset: Offset(0, -4),
                      blurRadius: 18,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Text("Today's Offer", style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(AppImage.offer)),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -80,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ImageTextWidget(
                            title: "Book Now",
                            image: AppImage.bookNow,
                            subImage: AppImage.bookNowIcon,
                            onTap: () {
                              context.read<CommonProvider>().changeBooking(0);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: ImageTextWidget(
                            title: "Per-Booking",
                            image: AppImage.preBooking,
                            subImage: AppImage.preBookingIcon,
                            onTap: () {
                              context.read<CommonProvider>().changeBooking(1);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: ImageTextWidget(
                            title: "Rental",
                            image: AppImage.rental,
                            subImage: AppImage.rentalIcon,
                            onTap: () {
                              context.read<CommonProvider>().changeBooking(2);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
