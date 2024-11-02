import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/rental/recurring/components/select_hour.dart';
import 'package:flutter_easy_ride/new/rental/week_schedule_view.dart';
import 'package:flutter_easy_ride/rental/recurring/components/week_wallet_view.dart';

class SelectRecurringRentalView extends StatefulWidget {
  const SelectRecurringRentalView({super.key});

  @override
  State<SelectRecurringRentalView> createState() => _SelectRecurringRentalViewState();
}

class _SelectRecurringRentalViewState extends State<SelectRecurringRentalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3fdf6),
      appBar: AppBar(
        backgroundColor: Color(0xff1937d7),
        title: Text('Select Recurring Rental',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins', // Set Poppins as the default font
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
      body: SingleChildScrollView(
        child: Column(
          children: [
         Padding(
           padding: const EdgeInsets.only(left: 24,right: 24,top: 24,bottom: 12),
           child: Column(
             children: [
               Row(
                 children: [
                   Icon(Icons.location_on_outlined,color: Colors.green.shade700,size: 20,),
                   SizedBox(width: 10,),
                   Text('Chittorgarh Raj',
                     style: TextStyle(
                         fontWeight: FontWeight.w400,
                         fontFamily: 'Poppins', // Set Poppins as the default font
                         fontSize: 15
                     ),
                   ),
                 ],
               ),
               SizedBox(height: 8,),
               Divider(
                 color: Colors.grey.shade400,
               ),
             ],
           ),
         ),
        
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade100,
                      Colors.blue.shade100,
                    ], // Change these colors to your preferred gradient colors
                    begin: Alignment.topLeft, // Optional: control the direction of the gradient
                    end: Alignment.bottomRight,
                  ),
               //   borderRadius: BorderRadius.circular(40)
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.white, // Change this to your desired color
                    child: Icon(
                      Icons.location_on_sharp,
                      color:  Color(0xff1937d7),
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Estimated kms : 20.4 kms",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff1937d7),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins', // Set Poppins as the default font
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xff1937d7),
                    size: 16,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xff1937d7),
                    size: 16,
                  ),Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xff1937d7),
                    size: 16,
                  ),
        
        
        
                ],
              ),
            ),
        
            SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.all(12), // Add margin here
              color: Colors.white,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                  ),
                  child: SelectHour(),
                ),
              ),
            ),
        
            SizedBox(height: 10,),
            WeekScheduleView(),

            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WeekWalletView()));

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
                      "Continus",
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
