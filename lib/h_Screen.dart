import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
            heightFactor: 0.28, // Full height
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
                      'History',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins', // Set Poppins as the default font
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Oct 15,2023',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8,),

                          Icon(Icons.arrow_drop_down,
                            color: Colors.white,size: 22,),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Material(
                  elevation: 4,
                    borderRadius: BorderRadius.circular(10),

                    child: Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,

                    ),

               child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.do_not_disturb_on_total_silence,
                              color: Color(0xff1937d7),
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '347, Swift Village',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontFamily: 'Poppins', // Set Poppins as the default font
                                fontWeight: FontWeight.w500,
                              ),
                            ),// Icon added he
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '347, Swift Village',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontFamily: 'Poppins', // Set Poppins as the default font
                                fontWeight: FontWeight.w500,
                              ),
                            ),// Icon added he
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(
                          thickness: 1.3,
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              color: Colors.grey,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Rs. 75.00',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontFamily: 'Poppins', // Set Poppins as the default font

                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Spacer(),
                            Text(
                              'Confirm',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff1937d7),
                                fontFamily: 'Poppins', // Set Poppins as the default font
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                              size: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10),

                  child: Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,

                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.do_not_disturb_on_total_silence,
                              color: Color(0xff1937d7),
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '347, Swift Village',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontFamily: 'Poppins', // Set Poppins as the default font
                                fontWeight: FontWeight.w500,
                              ),
                            ),// Icon added he
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '347, Swift Village',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontFamily: 'Poppins', // Set Poppins as the default font
                                fontWeight: FontWeight.w500,
                              ),
                            ),// Icon added he
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(
                          thickness: 1.3,
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              color: Colors.grey,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Rs. 75.00',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontFamily: 'Poppins', // Set Poppins as the default font

                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Spacer(),
                            Text(
                              'Confirm',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff1937d7),
                                fontFamily: 'Poppins', // Set Poppins as the default font
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                              size: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10),

                  child: Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,

                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.do_not_disturb_on_total_silence,
                              color: Color(0xff1937d7),
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '347, Swift Village',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontFamily: 'Poppins', // Set Poppins as the default font
                                fontWeight: FontWeight.w500,
                              ),
                            ),// Icon added he
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '347, Swift Village',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontFamily: 'Poppins', // Set Poppins as the default font
                                fontWeight: FontWeight.w500,
                              ),
                            ),// Icon added he
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(
                          thickness: 1.3,
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              color: Colors.grey,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Rs. 75.00',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontFamily: 'Poppins', // Set Poppins as the default font

                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Spacer(),
                            Text(
                              'Confirm',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff1937d7),
                                fontFamily: 'Poppins', // Set Poppins as the default font
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                              size: 14,
                            ),
                          ],
                        ),
                      ],
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
