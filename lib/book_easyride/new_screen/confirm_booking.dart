import 'package:flutter/material.dart';
import 'time.dart';

class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking({super.key});

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  String? selectedBank;

  final List<Map<String, dynamic>> banks = [
    {'name': 'GPay', 'image': 'assets/images/gpay.jpg'},
    {'name': 'Paytm', 'image': 'assets/images/paytem.png'},
    {'name': 'Online', 'image': 'assets/images/phonepay.png'},
    {'name': 'RozaPay', 'image': 'assets/images/rojapay.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Confirm Booking',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildBookingTimeContainer(),
              SizedBox(height: 10),
              buildDriverInfo(),
              SizedBox(height: 10),
              buildRideDetails(),
              SizedBox(height: 10),
              buildLocationInfo(),
              SizedBox(height: 20),
              buildPriceDetails(),
              SizedBox(height: 20),
              buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBookingTimeContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: containerDecoration(),
      child: Column(
        children: [
          Text(
            'You have just 9 minutes left to make your booking. Act fast, or you might miss out!',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w200,
                fontSize: 13),
          ),
          SizedBox(height: 20),
          ProgressIndicatorPage(),
        ],
      ),
    );
  }

  Widget buildDriverInfo() {
    return Container(
      decoration: containerDecoration(),
      padding: EdgeInsets.all(8.0),
      width: double.infinity,
      height: 90,
      child: Row(
        children: [
          Image.asset(
            "assets/images/driver1.jpg",
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Sachin Kumar',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRideDetails() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: containerDecoration(),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/images/ride1.jpg', width: 40, height: 40),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Arvind Yadav', style: textStyle()),
                    Text('Sivam Kumar', style: textStyle()),
                  ],
                ),
              ),
              Text('Ramesh', style: textStyle()),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset("assets/images/ride.png", width: 40, height: 40),
              SizedBox(width: 20),
              Text('RIDE DETAILS', style: textStyle()),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLocationInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: containerDecoration(),
      child: Column(
        children: [
          locationRow(
              Icons.location_on, Colors.green, 'Noida Sector 16, India'),
          SizedBox(height: 5),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    child:
                        Icon(Icons.more_vert, color: Colors.black, size: 24.0),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Column(
                children: [],
              ),
            ),
          ),
          locationRow(
              Icons.location_on, Colors.red, 'New Delhi West, Delhi, India'),
        ],
      ),
    );
  }

  Widget locationRow(IconData icon, Color color, String location) {
    return Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            location,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPriceDetails() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: containerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset("assets/images/rupaya.jpg", width: 40, height: 40),
              SizedBox(width: 10),
              Text(
                'Price Details',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(height: 10),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedBank,
              hint: Text('Online',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Poppins',
                      color: Colors.black)),
              icon: Icon(Icons.arrow_forward_ios_outlined),
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  selectedBank = newValue;
                });
              },
              items: banks.map<DropdownMenuItem<String>>((bank) {
                return DropdownMenuItem<String>(
                  value: bank['name'],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Image.asset(bank['image'], width: 30, height: 30),
                        SizedBox(width: 30),
                        Text(bank['name']),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildConfirmButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 100),
      child: Text(
        'Confirm Booking',
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Colors.white),
      ),
    );
  }

  BoxDecoration containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 5,
          spreadRadius: 2,
          offset: Offset(0, 3),
        ),
      ],
    );
  }



  TextStyle textStyle() {
    return TextStyle(
        fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 13);
  }
}
