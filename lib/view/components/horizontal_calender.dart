import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';
import 'package:flutter_easy_ride/view/booking/provider/book_now_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HorizontalCalendar extends StatefulWidget {
  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          child: Consumer<BookNowProvider>(
            builder: (context, v, child) => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                DateTime date = DateTime.now().add(Duration(days: index));
                bool isSelected = v.selectedDate.day == date.day &&
                    v.selectedDate.month == date.month &&
                    v.selectedDate.year == date.year;
                return GestureDetector(
                  onTap: () => v.chooseDate(date),
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
