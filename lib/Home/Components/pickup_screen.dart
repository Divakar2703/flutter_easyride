import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Home/Components/select_vehicle.dart';

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3fdf6),
      appBar: AppBar(
        backgroundColor: Color(0xff1937d7),
        title: Text('Pickup',
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
      body:Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Pickup location',
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                      prefixIcon: Icon(
                        Icons.location_on_rounded,
                        color: Colors.green.shade800,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.grey.shade500,
                    size: 24.0, // Adjust the size as needed
                  ),
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Drop location',
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                      prefixIcon: Icon(
                        Icons.location_on_rounded,
                        color: Colors.red.shade700,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SelectVehicle()));
            },
            child: Row(
              children: [
                Container(
                  width: 160,
                  height: 35,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: Colors.grey.shade300
                    )
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 20,color: Colors.black54,),

                      SizedBox(width: 6,),
                      Text(
                        "Select on map",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Poppins', // Set Poppins as the default font

                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(
            thickness: 1.5,
            color: Colors.grey.shade300,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined,
                  color: Colors.grey.shade800,size: 20,),
                SizedBox(width: 5,),
                Text(
                  'Kota Juction,RIDDHI SIDHHI NAGAR...',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    fontFamily: 'Poppins', // Set Poppins as the default font

                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined,
                  color: Colors.grey.shade800,size: 20,),
                SizedBox(width: 5,),
                Text(
                  'Chittorgarh, Tilak nagar, 13A Road',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    fontFamily: 'Poppins', // Set Poppins as the default font

                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),

          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SelectVehicle()));
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
                    "Select vehical",
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
    );
  }
}
