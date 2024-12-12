import 'dart:async';
import 'package:flutter/material.dart';



class ProgressIndicatorPage extends StatefulWidget {
  @override
  _ProgressIndicatorPageState createState() => _ProgressIndicatorPageState();
}

class _ProgressIndicatorPageState extends State<ProgressIndicatorPage> {
  double _progress = 0.0;
  static const int totalDurationInSeconds = 1 * 120;
  int remainingTimeInSeconds = totalDurationInSeconds;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_progress < 1.0) {
          remainingTimeInSeconds--;
          _progress += 1 / totalDurationInSeconds;
        } else {
          timer?.cancel();

          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => BankSelectionDropdown()));
        }
      });
    });
  }
  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LinearProgressIndicator(
          borderRadius: BorderRadius.circular(10),
          value: _progress,
          minHeight: 8,
          backgroundColor: Colors.grey[300],
          color: Colors.blue,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              formatTime(remainingTimeInSeconds),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Min Left',
              style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
            )
          ],
        ),
      ],
    );
  }
}






