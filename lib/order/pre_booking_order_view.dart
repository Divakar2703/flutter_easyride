import 'package:flutter/material.dart';

import 'components/pre_booking_widget.dart';

class PreBookingOrderView extends StatefulWidget {
  const PreBookingOrderView({super.key});

  @override
  State<PreBookingOrderView> createState() => _PreBookingOrderViewState();
}

class _PreBookingOrderViewState extends State<PreBookingOrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3fdf6),
      appBar: AppBar(
        backgroundColor: Color(0xff1937d7),
        title: Text('Order details',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              fontSize: 17,
              color: Colors.white
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,size: 21,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 5,),
         // PreBookingWidget()
        ],
      ),
    );
  }
}
