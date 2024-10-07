import 'package:flutter/material.dart';

final Color kDarkBlueColor = const Color(0xFFffb917);

void editGenderBottomSheet(BuildContext context,
    Function(String) onGenderChanged) {
  String selectedGender = ''; // Variable to store selected gender

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 210,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              color:  Color(0xfff3fdf6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Scaffold(
                body: Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Edit Gender",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Poppins', // Set Poppins as the default font

                              fontWeight: FontWeight.w500,
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

                      SizedBox(height: 10,),
                      Container(
                        height: 40.0,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: Colors.grey,
                              width: 1.3
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: selectedGender,
                          onChanged: (newValue) {
                            setState(() {
                              selectedGender = newValue!;
                            });
                          },
                          items: <String>['', 'Male', 'Female']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: () {
                          if (selectedGender.isNotEmpty) {
                            onGenderChanged(selectedGender);
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please select a gender'),
                            ));
                          }
                        },
                        child: Container(
                          height: 42,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color(0xff1937d7),
                          ),
                          child: Center(
                            child: Text(
                              "Save Changes",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Poppins', // Set Poppins as the default font

                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
    },
  );
}
