import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekScheduleView extends StatefulWidget {
  const WeekScheduleView({super.key});

  @override
  State<WeekScheduleView> createState() => _WeekScheduleViewState();
}

class _WeekScheduleViewState extends State<WeekScheduleView> {
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();

  // List to store unique time for each day
  List<TimeOfDay?> _selectedTimes = List.generate(7, (index) => null);
  List<bool> _selectedDays = List.generate(7, (index) => false);

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

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
  }

  // Time picker for each day
  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTimes[index] ?? TimeOfDay(hour: 15, minute: 0), // Default time or previously selected time
    );
    if (picked != null) {
      setState(() {
        _selectedTimes[index] = picked; // Update the selected time for the specific day
      });
    }
  }

  void _toggleDaySelection(int index) {
    setState(() {
      _selectedDays[index] = !_selectedDays[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> daysOfWeek = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 10, bottom: 2),
            child: Text(
              'Week Schedule',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                fontSize: 16.5,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            color: Colors.grey.shade200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  color: Color(0xff1937d7),
                  size: 20,
                ),
                Text(
                  "  Set Start Date",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Text(
                    '${DateFormat('EEEE, MMMM dd').format(_selectedDate)}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black54,
                  size: 14,
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey.shade200,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              itemCount: daysOfWeek.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => _toggleDaySelection(index),
                        child: Container(
                          height: 17,
                          width: 17,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _selectedDays[index]
                                  ? Color(0xff1937d7)
                                  : Colors.grey,
                            ),
                          ),
                          child: Icon(
                            Icons.check,
                            size: 14.0,
                            color: _selectedDays[index]
                                ? Color(0xff1937d7)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Text(
                        "  ${daysOfWeek[index]}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => _selectTime(context, index), // Select time for each specific day
                        child: Text(
                          _selectedTimes[index] != null
                              ? _selectedTimes[index]!.format(context) // Show selected time
                              : 'Set pickup time', // Default text when no time is selected
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              children: [
                Icon(
                  Icons.notifications_active_outlined,
                  color: Color(0xff1937d7),
                  size: 20,
                ),
                Text(
                  "  Set End Date",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _selectEndDate(context),
                  child: Text(
                    '${DateFormat('EEEE, MMMM dd').format(_selectedEndDate)}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black54,
                  size: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
