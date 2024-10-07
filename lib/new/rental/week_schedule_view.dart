import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekScheduleView extends StatefulWidget {
  const WeekScheduleView({super.key});

  @override
  State<WeekScheduleView> createState() => _WeekScheduleViewState();
}

class _WeekScheduleViewState extends State<WeekScheduleView> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 15, minute: 5); // Default time
  List<bool> _selectedDays = List.generate(7, (index) => false); // Track the state of each day

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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
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
      height: 380, // Increased height to accommodate the list
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
                      Text(
                        'Set pickup time',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
