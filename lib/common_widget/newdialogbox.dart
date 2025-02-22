import 'package:flutter/material.dart';
import 'checkdialob.dart';
import 'custombutton.dart';

class SweetDialog extends StatelessWidget {
  const SweetDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              color: Colors.yellow,
            )
          ]),
          Icon(
            Icons.thumb_up,
            size: 80,
            color: Colors.green,
          ),
          SizedBox(height: 16),
          Text(
            'Great, all set!',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "Poppins"),
          ),
          SizedBox(height: 8),
          Text(
            'Your changes were successfully saved.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontFamily: "Poppins"),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => Checkdialob())),
            child: Customtbutton(
              width: 100,
              height: 30,
              text: "Continue",
            ),
          ),
        ],
      ),
    );
  }
}
// alert

class AlertDialobbox extends StatelessWidget {
  const AlertDialobbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning,
            size: 80,
            color: Colors.red,
          ),
          SizedBox(height: 16),
          Text(
            'Great, all set!',
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your changes were successfully saved.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontFamily: "Poppins"),
          ),
          SizedBox(height: 16),
          GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Checkdialob())),
              child: Container(
                child: Customtbutton(
                  backgroundColor: Colors.red,
                  width: 100,
                  height: 30,
                  text: "Try again",
                ),
              )),
        ],
      ),
    );
  }
}
