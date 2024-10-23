import 'package:flutter/material.dart';
import '../screens/drive_finding_screen.dart';

final Color kDarkBlueColor = const Color(0xff1937d7);

void openConfirmVehicleBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true, // Set this to true

    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        height: 290,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Scaffold(
            body: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/user.jpeg'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rohit Sharma',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black87,
                                fontFamily:
                                    'Poppins', // Set Poppins as the default font
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: kDarkBlueColor,
                                  size: 18,
                                ),
                                Text(
                                  '4.7',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade600,
                                    fontFamily:
                                        'Poppins', // Set Poppins as the default font

                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: kDarkBlueColor,
                          radius: 22,
                          child: Icon(
                            Icons
                                .call, // Replace Icons.person with the desired icon
                            size: 24,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              AssetImage('assets/images/user.jpeg'),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              AssetImage('assets/images/user.jpeg'),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              AssetImage('assets/images/user.jpeg'),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '25 Recommended',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily:
                                'Poppins', // Set Poppins as the default font

                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/car_one.png',
                          width: 60,
                          height: 50,
                          //  color: selectedRow == index ? Colors.white : Colors.black87,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DISTANCE',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily:
                                    'Poppins', // Set Poppins as the default font

                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '0.2 km',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily:
                                    'Poppins', // Set Poppins as the default font

                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TIME',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily:
                                    'Poppins', // Set Poppins as the default font

                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '2 min',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily:
                                    'Poppins', // Set Poppins as the default font

                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PRICE',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily:
                                    'Poppins', // Set Poppins as the default font

                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Rs 25.00',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily:
                                    'Poppins', // Set Poppins as the default font

                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => PaymentScreen()));
                    },
                    child: Container(
                      margin: EdgeInsets.all(16),
                      height: 44,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: kDarkBlueColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DriveFindingScreen()));
                            },
                            child: Text(
                              "Confirm",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily:
                                    'Poppins', // Set Poppins as the default font

                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openCalendar(BuildContext context) {
  // Add your code to open the calendar here
  // For example, you can use showDialog to display a calendar dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
            height: 290.0, // Set the height here
            decoration: BoxDecoration(
              color: Colors.white, // Change background color here
              borderRadius:
                  BorderRadius.circular(10.0), // Add border radius here
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Icon(
                    Icons.check_circle,
                    size: 120,
                    color: kDarkBlueColor,
                  ),
                ),
                Text(
                  "Booking Successful",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins', // Set Poppins as the default font

                    color: Colors.black87,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "You booking has been confirmed.\nDriver will pickup you in 2 minutes.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins', // Set Poppins as the default font

                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily:
                            'Poppins', // Set Poppins as the default font

                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                      height: 41,
                      width: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Done",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kDarkBlueColor,
                        fontFamily:
                            'Poppins', // Set Poppins as the default font

                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            )),
      );
    },
  );
}
