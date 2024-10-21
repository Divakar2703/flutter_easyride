import 'package:flutter/material.dart';

class VehicleListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String time;
  final String assetPath;
  final bool isSelected;
  final VoidCallback onTap;

  VehicleListItem({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.time,
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call the onTap function passed from the parent
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
           // color: isSelected ? Color(0xff1937d7) : Colors.transparent, // Background color based on selection
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.transparent, // Border color based on selection
              width: 2, // Width of the border
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Image.network(
                assetPath,
                width: 60,
                height: 50,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",                      color: isSelected ? Colors.blue : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Poppins",
                      color: isSelected ? Colors.blue : Colors.grey.shade500,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    " ₹$price",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",                      color: isSelected ? Colors.blue : Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Poppins",                      color: isSelected ? Colors.blue : Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15),
              InkWell(
                  onTap: (){
                    _showFareInfo(context);
                  },
                  child: Icon(Icons.info_outline,color: Colors.blue,))
            ],
          ),
        ),
      ),
    );
  }

  void _showFareInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
              //  mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cab Name with Image at the top
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 22, // Big text for cab name
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Image.network(
                        assetPath,
                        width: 60,
                        height: 50,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Description of the cab
                  Text(
                    'A comfortable and reliable cab for your journey.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Cab Quality Details (comfort, pocket-friendly, etc.)
                  // Text(
                  //   'Quality',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black87,
                  //   ),
                  // ),
                 // SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildQualityChip(Icons.directions_car, 'Comfort Hatch'),
                      _buildQualityChip(Icons.attach_money, 'Pocket Friendly'),
                     // _buildQualityChip(Icons.credit_card, 'Cashless Ride'),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Fare Breakdown
                  Text(
                    'Total Fare Breakdown',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Fare Row (Total Price)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Base Fare',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      Text(
                        '₹$price',
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Discount Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      Text(
                        '-₹50', // Example discount amount
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Tax Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Taxes & Charges',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      Text(
                        '₹30', // Example tax amount
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Final Price
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Fare',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '₹${ - 50 + 30}', // Example final price calculation
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Close Button
                  Center(
                    child: ElevatedButton(
                      onPressed:(){

                      },// Disable button if date and time not selected
                      child: Text('Got it',style: TextStyle(fontFamily: "Poppins",fontSize: 14,color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1937d7),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        textStyle: TextStyle(fontSize: 15,color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// Helper Widget to Build Quality Chips
  Widget _buildQualityChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 15, color: Colors.blue),
      label: Text(label),
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(color: Colors.black87,fontSize: 12),
    );
  }

}
