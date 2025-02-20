import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:intl/intl.dart';

class HorizontalCalendar extends StatefulWidget {
  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  DateTime _selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCurrentDate());
  }

  void _scrollToCurrentDate() {
    final double itemWidth = 70.0;
    final double screenWidth = MediaQuery.of(context).size.width;

    final int currentDateIndex = 15;

    final double offset = (currentDateIndex * itemWidth) - (screenWidth / 6) + (itemWidth / 6);

    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: 30,
            itemBuilder: (context, index) {
              DateTime date = DateTime.now().add(Duration(days: index - 15));
              bool isSelected =
                  _selectedDate.day == date.day && _selectedDate.month == date.month && _selectedDate.year == date.year;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${date.day} ${DateFormat('MMM').format(date)}',
                            style: TextStyle(
                              fontSize: isSelected ? 16 : 14,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? AppColors.yellowDark : AppColors.black.withOpacity(0.5),
                            ),
                          ),
                          Text(
                            '${_getDayOfWeek(date.weekday)}',
                            style: TextStyle(
                              fontSize: isSelected ? 14 : 12,
                              color: isSelected ? AppColors.yellowDark : AppColors.black.withOpacity(0.5),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: isSelected ? AppColors.yellowDark : Colors.transparent,
                          )
                        ],
                      ),
                    ),
                    VerticalDivider(width: 0, indent: 15, endIndent: 20),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
