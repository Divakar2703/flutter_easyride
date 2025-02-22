import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Pre_Booking/screens/select_pickup_time.dart';
import 'package:intl/intl.dart';

final Color kDarkBlueColor = const Color(0xff1937d7);

class SelectPickop extends StatefulWidget {
  const SelectPickop({Key? key}) : super(key: key);

  @override
  State<SelectPickop> createState() => _SelectPickopState();
}

class _SelectPickopState extends State<SelectPickop> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 15, minute: 5); // Default time

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 21,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, size: 26),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'When do you want to be picked up?',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins', // Set Poppins as the default font
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Text(
                '${DateFormat('EEEE, MMMM dd').format(_selectedDate)}',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins', // Set Poppins as the default font
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Divider(
                thickness: 1.2,
              ),
            ),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: Text(
                '${_selectedTime.format(context)}',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins', // Set Poppins as the default font
                ),
              ),
            ),
            SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.black87,
                        size: 26,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Choose your exact pickup\n time up to  90 days in advance',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontFamily:
                              'Poppins', // Set Poppins as the default font

                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(
                        Icons.refresh_outlined,
                        color: Colors.black87,
                        size: 26,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Extra wait time included to meet\nyour ride',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontFamily:
                              'Poppins', // Set Poppins as the default font

                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_view_day,
                        color: Colors.black87,
                        size: 26,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Cancel at no charge up to 60 min\nin advance',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontFamily:
                              'Poppins', // Set Poppins as the default font

                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Text(
                    'See terms',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins', // Set Poppins as the default font
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                //  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectPickupTime()));
                Navigator.of(context).push(_createRoute());
              },
              child: Container(
                //  margin: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                height: 44,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kDarkBlueColor),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Set pickup time",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily:
                            'Poppins', // Set Poppins as the default font
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
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
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SelectPickupTime(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start off the screen to the right
        const end = Offset.zero; // Slide to the center
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
