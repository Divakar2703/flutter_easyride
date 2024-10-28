import 'package:flutter/material.dart';

class RideOptions extends StatelessWidget {
  const RideOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                  left: 135,
                  right: 135,
                ),
                child: Divider(
                  thickness: 2,
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Someone Taking Ride with EasyRide',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.person),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Myself',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 240,
                ),
                Icon(
                  Icons.radio_button_checked,
                  color: Colors.green,
                )
              ],
            ),
            ListTile(
              leading: Icon(
                Icons.add,
                color: Colors.blue,
              ),
              title: Text(
                'Add new ride',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 150),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff1937d7),
                    ),
                    child: Text(
                      'Done',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}
