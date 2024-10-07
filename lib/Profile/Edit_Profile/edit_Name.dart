import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Color kDarkBlueColor = const Color(0xFFffb917);

void editNameBottomSheet(BuildContext context) {
  // Sample list of notifications

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Set this to true

    builder: (BuildContext context) {
      return Container(
        height: 280,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0),
          ),
          color:  Color(0xfff3fdf6),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          child: Scaffold(
            body: Container(
              margin: EdgeInsets.all(16),
              child:Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Edit Name",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins', // Set Poppins as the default font

                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.black87,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),
                  Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.3
                      ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'First Name*',
                        hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins', // Set Poppins as the default font

                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric
                          (horizontal: 24.0,vertical: 11),
                        prefixIcon: Icon(Icons.person_outline_sharp,
                          color: Colors.black54,size: 20,
                        ), // Icon added here
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: Colors.grey,
                          width: 1.3
                      ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Last Name*',
                        hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins', // Set Poppins as the default font

                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric
                          (horizontal: 24.0,vertical: 11),
                        prefixIcon: Icon(Icons.person_outline_sharp,
                          color: Colors.black54,size: 20,
                        ), // Icon added here
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),
                  Container(
                    height: 42,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color:Color(0xff1937d7),
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Save Changes",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins', // Set Poppins as the default font
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
