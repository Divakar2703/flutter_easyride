import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/utils/colors.dart';

class CustomTimePicker extends StatefulWidget {
  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  final FixedExtentScrollController _hourController = FixedExtentScrollController();
  final FixedExtentScrollController _minuteController = FixedExtentScrollController();
  final FixedExtentScrollController _periodController = FixedExtentScrollController();

  int _selectedHour = 12;
  int _selectedMinute = 0;
  String _selectedPeriod = 'AM';

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    _selectedHour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    _selectedMinute = now.minute;
    _selectedPeriod = now.hour < 12 ? 'AM' : 'PM';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hourController.jumpToItem(_selectedHour - 1);
      _minuteController.jumpToItem(_selectedMinute);
      _periodController.jumpToItem(_selectedPeriod == 'AM' ? 0 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hour picker
            _buildTimePicker(
              controller: _hourController,
              items: List.generate(12, (index) => (index + 1).toString().padLeft(2, '0')),
              selectedIndex: _selectedHour - 1,
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedHour = index + 1;
                });
              },
            ),
            SizedBox(width: 10),
            // Minute picker
            _buildTimePicker(
              controller: _minuteController,
              items: List.generate(60, (index) => index.toString().padLeft(2, '0')),
              selectedIndex: _selectedMinute,
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedMinute = index;
                });
              },
            ),
            SizedBox(width: 10),
            // AM/PM picker
            _buildTimePicker(
              controller: _periodController,
              items: ['AM', 'PM'],
              selectedIndex: _selectedPeriod == 'AM' ? 0 : 1,
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedPeriod = index == 0 ? 'AM' : 'PM';
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimePicker({
    required FixedExtentScrollController controller,
    required List<String> items,
    required int selectedIndex,
    required Function(int) onSelectedItemChanged,
  }) =>
      Container(
        height: 150,
        width: 60,
        child: ListWheelScrollView(
          controller: controller,
          itemExtent: 40,
          perspective: 0.01,
          diameterRatio: 2.0,
          onSelectedItemChanged: onSelectedItemChanged,
          children: items
              .map(
                (item) => Center(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: items[selectedIndex] == item ? 20 : 18,
                      fontWeight: FontWeight.bold,
                      color:
                          items[selectedIndex] == item ? AppColors.yellowDark : AppColors.borderColor.withOpacity(0.2),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
}
