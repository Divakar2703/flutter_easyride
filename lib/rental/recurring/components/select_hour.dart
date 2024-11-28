import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import '../recurringbooking_provider.dart';

class SelectHour extends StatefulWidget {
  const SelectHour({super.key});

  @override
  State<SelectHour> createState() => _SelectHourState();
}

class _SelectHourState extends State<SelectHour> {
  String? selectedItem;
  int selectedIndex = 0;
  bool isExpanded = true;
  bool isDataLoaded=false;

  @override
  void initState() {
    super.initState();
    // Call fetchRecurringData once when the widget is first initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isDataLoaded) {
        fetchRecurringData('hourly'); // Default to hourly booking type
        setState(() {
          isDataLoaded = true; // Set the flag to true to prevent further reloads
        });
      }
    });
  }

  void fetchRecurringData(String bookingType) {
    final provider = Provider.of<RecurringBookingProvider>(context, listen: false);
    provider.getRecurringBooking(
      30.36581490852199,
      78.04388081621565,
      27.210052664323,
      83.891678676009,
      'asatvindia.in',
      'Dr. Shyamu medical store, Turkaha, Uttar Pradesh 274801, India', // Example pickupAddress
      '6V6V+J48, Turkaha, Uttar Pradesh 274801, India', // Example dropAddress
      "recuring", // Use dynamic booking type
      6, // Example userId
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecurringBookingProvider>(
      builder: (context, provider, child) {
        // Check if data has been loaded
        if (provider.recurringRentalResponse == null) {
          return Center(child: CircularProgressIndicator()); // Show loading indicator if response is null
        }

        final response = provider.recurringRentalResponse!;

        return Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.timelapse_rounded,
                      color: Color(0xff1937d7),
                      size: 18,
                    ),
                  ),
                ),
                Text(
                  "  Select a package",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.shade100,
                border: Border.all(
                  color: Color(0xff5168e6),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButton<String>(
                        value: selectedItem,
                        hint: Text(
                          "Select a package",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black54,
                        ),
                        isExpanded: true,
                        underline: SizedBox(),
                        items: response.km.map<DropdownMenuItem<String>>((km) {
                          // Assuming you want to display km values as package options
                          return DropdownMenuItem<String>(
                            value: "$km Hours, ${response.km} Km",
                            child: Text(
                              "$km Hours, ${response.hr} Km",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedItem = newValue;
                          });
                          fetchRecurringData('hourly'); // Fetch data when selection changes
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded; // Toggle visibility
                });
              },
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.car_crash_outlined,
                        color: Color(0xff1937d7),
                        size: 18,
                      ),
                    ),
                  ),
                  Text(
                    "  Select category",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Spacer(),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 26,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
            if (isExpanded)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryCard(0, 'assets/images/ride_car_two.png', 'Blue Classic', 'SUV', '5', '534.00', '754.00'),
                    _buildCategoryCard(1, 'assets/images/ride_car_one.png', 'Blue Premium', 'Sedan', '4', '124.00', '164.00'),
                    _buildCategoryCard(2, 'assets/images/ride_car_three.png', 'Blue Classic', 'Hatchback', '6', '864.00', '994.00'),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildCategoryCard(int index, String image, String title, String type, String seats, String price, String oldPrice) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 8, top: 10),
        padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Color(0xfff7f7fb) : Colors.grey.shade50,
          border: Border.all(
            color: isSelected ? Color(0xff6b7ee6) : Colors.grey.shade400,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,
              height: 100,
              width: 140,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff1937d7),
                fontFamily: 'Poppins',
              ),
            ),
            Row(
              children: [
                Text(
                  type,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.person_sharp,
                  size: 14,
                  color: Colors.black87,
                ),
                Text(
                  " $seats",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              children: [
                Icon(
                  Icons.currency_rupee_rounded,
                  size: 14,
                  color: Colors.green.shade700,
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  oldPrice,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.black54,
                    decorationThickness: 2.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
