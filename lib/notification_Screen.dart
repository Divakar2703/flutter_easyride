import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xff1937d7),
        title: Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 21,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          FractionallySizedBox(
            alignment: Alignment.topLeft,
            widthFactor: 1.0, // 1/4 of the width
            heightFactor: 0.1, // Full height
            child: Container(
              color: Color(0xff1937d7),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Poppins', // Set Poppins as the default font
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 12),
                      height: 40,
                      width: 40, // Set width to make it circular
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Make it circular
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.delete_outline_sharp,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),


                  ],
                ),


                SizedBox(height: 55,),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 12),
                      height: 50,
                      width: 50, // Set width to make it circular
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Make it circular
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 26,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'System',
                          style: TextStyle(
                            fontSize: 15.5,
                            color: Colors.black87,
                            fontFamily: 'Poppins', // Set Poppins as the default font
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'You booking #5599 has been suc..',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontFamily: 'Poppins', // Set Poppins as the default font
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 5,),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 12),
                      height: 50,
                      width: 50, // Set width to make it circular
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Make it circular
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_box,
                          color: Colors.green,
                          size: 26,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pramotion',
                          style: TextStyle(
                            fontSize: 15.5,
                            color: Colors.black87,
                            fontFamily: 'Poppins', // Set Poppins as the default font
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'You booking #5599 has been suc..',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontFamily: 'Poppins', // Set Poppins as the default font
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 5,),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 12),
                      height: 50,
                      width: 50, // Set width to make it circular
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Make it circular
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.qr_code,
                          color: Colors.yellow,
                          size: 26,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pramotion',
                          style: TextStyle(
                            fontSize: 15.5,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins', // Set Poppins as the default font
                          ),
                        ),
                        Text(
                          'You booking #5599 has been suc..',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins', // Set Poppins as the default font
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 5,),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 12),
                      height: 50,
                      width: 50, // Set width to make it circular
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Make it circular
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_box,
                          color: Colors.green,
                          size: 26,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pramotion',
                          style: TextStyle(
                            fontSize: 15.5,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins', // Set Poppins as the default font
                          ),
                        ),
                        Text(
                          'You booking #5599 has been suc..',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontFamily: 'Poppins', // Set Poppins as the default font

                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 5,),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 12),
                      height: 50,
                      width: 50, // Set width to make it circular
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Make it circular
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_box,
                          color: Colors.green,
                          size: 26,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pramotion',
                          style: TextStyle(
                            fontSize: 15.5,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins', // Set Poppins as the default font
                          ),
                        ),
                        Text(
                          'You booking #5599 has been suc..',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontFamily: 'Poppins', // Set Poppins as the default font

                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 5,),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),



              ],
            ),
          ),

        ],
      ),
    );
  }
}
