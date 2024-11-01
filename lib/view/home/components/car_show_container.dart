import 'package:flutter/material.dart';
import '../../../Book_Now/screens/book_now_screen.dart';
import '../../../Book_Now/screens/pickup_screen.dart';
import '../../../Pre_Booking/screens/pre_booking_screen.dart';
import '../../../Pre_Booking/screens/select_Pickup.dart';
import '../../../rental/rental_location_select_view.dart';

class CarShowContainer extends StatefulWidget {
  const CarShowContainer({Key? key}) : super(key: key);

  @override
  State<CarShowContainer> createState() => _CarShowContainerState();
}

class _CarShowContainerState extends State<CarShowContainer> with TickerProviderStateMixin {
  final List<Map<String, String>> categories = [
    {"icon": 'assets/images/car_logo_three.png', "item": "Book Now"},
    {"icon": 'assets/images/car_logo_one.png', "item": "PreBooking"},
    {"icon": 'assets/images/car_logo_two.png', "item": "Rental"},
  ];

  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controllers and animations for each category
    _controllers = List.generate(categories.length, (index) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 800 + index * 100), // Stagger the animation start
        vsync: this,
      )..forward(); // Automatically start the animation
      return controller;
    });

    _animations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: Offset(2.0, 0.0), // Slide from the right
        end: Offset.zero, // To its final position
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.decelerate,
      ));
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Function to handle navigation with slide animation from the right
  void _onCategoryTap(String label) {
    Widget destination;

    if (label == "PreBooking") {
      destination = PreBookingScreen();
    } else if (label == "Rental") {
      destination = RentalLocationSelectView();
    } else {
      destination = BookNowScreen();
    }

    Navigator.of(context).push(_createRoute(destination));
  }

  // Custom slide animation route function
  Route _createRoute(Widget destination) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(2.0, 0.0); // Start the transition from the right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 1,
          childAspectRatio: 2.75 / 2.8,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return SlideTransition(
                position: _animations[index], // Apply the sliding animation
                child: GestureDetector(
                  onTap: () => _onCategoryTap(category["item"]!),
                  child: Column(
                    children: [
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(100), // Circular shape
                        child: Container(
                          width: 100, // Increased width for larger circle
                          height: 100, // Increased height for larger circle
                          padding: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60), // Circular shape
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                category["icon"]!,
                                height: 60, // Adjust icon size
                                width: 60,
                              ),
                          //    const SizedBox(height: 5), // Add spacing between icon and text
                              Text(
                                category["item"]!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      )

    );

  }
}
  
















