import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // For Lottie animations

class BookingSuccessScreen extends StatefulWidget {
  const BookingSuccessScreen({super.key});

  @override
  _BookingSuccessScreenState createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation controller for text scaling
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background color
          AnimatedContainer(
            duration: const Duration(seconds: 3),
            curve: Curves.linear,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff1937d7), Colors.lightBlueAccent, Colors.indigo],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Main content of the success screen
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lottie success animation
                Lottie.asset(
                  'assets/lottie/success.json', // Add your Lottie animation file here
                  // width: 150,
                  // height: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),

                // Scaling animated text
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1), // Scale from 0 to 1
                  duration: Duration(seconds: 5), // Duration for the animation
                  curve: Curves.elasticOut, // Elastic effect for more pop
                  builder: (context, double scale, child) {
                    return Transform.scale(
                      scale: scale, // Apply scaling
                      child: Text(
                        'Booking Confirmed!',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),

                // Static subtext
                Text(
                  'Your booking has been successfully confirmed.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),

                // Done button
                ElevatedButton(
                  onPressed: () {
                    // Action to return or continue
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.blueAccent,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
