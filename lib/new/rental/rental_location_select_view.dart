import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/new/rental/select_recurring_rental_view.dart';

class RentalLocationSelectView extends StatefulWidget {
  const RentalLocationSelectView({super.key});


  @override
  State<RentalLocationSelectView> createState() => _RentalLocationSelectViewState();
}

class _RentalLocationSelectViewState extends State<RentalLocationSelectView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3fdf6),
      appBar: AppBar(
        backgroundColor: Color(0xff1937d7),
        title: Text('Select Location',
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
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.shade300,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter pickup location',
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 12),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.location_on_rounded,
                            color: Colors.black54,
                          ),
                        ),
                        suffixIcon: const Padding(
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

            Spacer(),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SelectRecurringRentalView()));

              },
              child: Container(
                //  margin: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                height: 44,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff1937d7),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Select rental packege",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins', // Set Poppins as the default font
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
}
