import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/rental/recurring/components/recurring_recharge_packs.dart';

class WeekWalletView extends StatefulWidget {
  const WeekWalletView({super.key});

  @override
  State<WeekWalletView> createState() => _WeekWalletViewState();
}

class _WeekWalletViewState extends State<WeekWalletView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3fdf6),
      appBar: AppBar(
        backgroundColor: Color(0xff1937d7),
        title: Text('Rechage Easy Ride Wallet',
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Available Balance :',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.black54
                  ),
                ),
                Icon(Icons.currency_rupee_rounded,color: Colors.black54,size: 18,),
                Text('0.0',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.black54
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Your total amount :',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.black87
                  ),
                ),
                Icon(Icons.currency_rupee_rounded,color: Colors.green.shade600,size: 18,),
                Text('5080.0',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.green.shade600
                  ),
                ),
              ],
            ),

            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.currency_rupee_rounded,color:  Color(0xff1937d7),size: 28,),
                SizedBox(width: 20),
                Text('5080.0',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      color: Colors.black87
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 104),
              child: Divider(
                thickness: 1,

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Icon(Icons.currency_rupee_rounded,color:  Color(0xff1937d7),size: 15 ,),
                Text('580.0  ',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color:  Color(0xff1937d7),
                  ),
                ),
                Text('cashback applied',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color:  Color(0xff1937d7),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20,),
            Divider(
              thickness: 1,
            ),


            Row(
              children: [
                Text('Recurring recharge packs',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      color: Colors.black
                  ),
                ),
              ],
            ),

            RecurringRechargePacks(),

            Spacer(),
            GestureDetector(
              onTap: () {
             //   Navigator.push(context, MaterialPageRoute(builder: (context) => SelectRecurringRentalView()));
              },
              child: Container(
                //  margin: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                height: 44,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xff1937d7),
                ),
                child:const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add Money",
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
