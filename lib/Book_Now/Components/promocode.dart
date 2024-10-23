
import 'package:flutter/material.dart';

import 'confirm_vehicle.dart';

final Color kDarkBlueColor = const Color(0xff1937d7);

void openPromocodeBottomSheet(BuildContext context) {
  // Sample list of notifications

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        height: 230,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
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
                        "Promo Code",
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

                  Text(
                    "You get 25% off & 10 coins cashback!",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins', // Set Poppins as the default font

                        color: Colors.green
                    ),
                  ),

                  SizedBox(height: 15,),
                  Container(
                    height: 42.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: Colors.grey,
                          width: 1.3
                      ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Input promo code',
                        hintStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Poppins', // Set Poppins as the default font

                            fontSize: 15,
                            fontWeight: FontWeight.w400
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric
                          (horizontal: 24.0,vertical: 11),
                        prefixIcon: Icon(Icons.confirmation_num,
                          color: Colors.black54,size: 20,
                        ), // Icon added here
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      openConfirmVehicleBottomSheet(context);
                    },
                    child: Container(
                      height: 44,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kDarkBlueColor
                      ),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Book Vehicle",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins', // Set Poppins as the default font

                              fontSize: 16.0,
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
          ),
        ),
      );
    },
  );
}
