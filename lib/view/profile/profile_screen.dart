import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/view/home/provider/bottom_bar_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Profile/Edit_Profile/edit_Email.dart';
import '../../Profile/Edit_Profile/edit_Enumber.dart';
import '../../Profile/Edit_Profile/edit_Gender.dart';
import '../../Profile/Edit_Profile/edit_Name.dart';
import '../../Profile/Edit_Profile/edit_number.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                blurRadius: 14,
                color: AppColors.black.withOpacity(0.1),
                offset: Offset(0, 2),
              )
            ],
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () => context.read<BottomBarProvider>().changePage(0),
                    child: Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
                Text("Profile", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox()
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_sharp,
                        color: Color(0xff1937d7),
                        size: 24,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Pintu Yadav',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey.shade600,
                          size: 16,
                        ),
                        onPressed: () {
                          editNameBottomSheet(context);
                        },
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: Color(0xff1937d7),
                        size: 24,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '+91-5487934589',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey.shade600,
                          size: 16,
                        ),
                        onPressed: () {
                          editNumberBottomSheet(context);
                        },
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: Color(0xff1937d7),
                        size: 24,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                            ),
                          ),
                          Text(
                            'xyz3487@gmail.com',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey.shade600,
                          size: 16,
                        ),
                        onPressed: () {
                          editEmailBottomSheet(context);
                        },
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_search_outlined,
                        color: Color(0xff1937d7),
                        size: 24,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                            ),
                          ),
                          Text(
                            'Male',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey.shade600,
                          size: 16,
                        ),
                        onPressed: () {
                          editGenderBottomSheet(context, (String gender) {
                            // Handle the selected gender here
                          });
                        },
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: Color(0xff1937d7),
                        size: 24,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date of Birth',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Text(
                              '${DateFormat('EEEE, MMMM dd').format(_selectedDate)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                fontFamily: 'Poppins', // Set Poppins as the default font

                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey.shade600,
                          size: 16,
                        ),
                        onPressed: () {
                          //  openCalendar(context);
                        },
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6, left: 8, bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.card_membership_outlined,
                        color: Color(0xff1937d7),
                        size: 24,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mamber Since',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                            ),
                          ),
                          Text(
                            'September 23',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                            ),
                          ),
                        ],
                      ),
                      // Spacer(),
                      // Icon(Icons.arrow_forward_ios_rounded,
                      //   color: Colors.grey.shade600,size: 16,),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6, left: 8, bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.card_membership_outlined,
                        color: Color(0xff1937d7),
                        size: 24,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emergency contect',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                            ),
                          ),
                          Text(
                            '+91-47843897234',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins', // Set Poppins as the default font
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          editEnumberBottomSheet(context);
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins', // Set Poppins as the default font
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void openCalendar(BuildContext context) {
  // Add your code to open the calendar here
  // For example, you can use showDialog to display a calendar dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Calendar'),
        content: Text('Calendar content goes here'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
