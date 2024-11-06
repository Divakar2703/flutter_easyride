
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/triphistry_provider.dart';

class HistryDetails extends StatefulWidget {
  const HistryDetails({super.key});

  @override
  State<HistryDetails> createState() => _HistryDetailsState();
}

class _HistryDetailsState extends State<HistryDetails> {
  late TriphistryProvider tripdetails;

  @override
  void initState() {
    // Provider.of<TriphistryProvider>(context, listen: false)
    //     .gethistryDetails;

    tripdetails = Provider.of<TriphistryProvider>(context, listen: false);
    tripdetails.getallhistry();

    super.initState();
  }

  double distance = 34.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Trip Histry Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Service Type',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Auto',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500))
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text('Date of Ride',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('July 28th 2021 11:24 Am',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500))
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text('RideID',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('RD16273456787655678',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500))
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: Container(
                            width: 80,
                            height: 80,
                            child: Image.asset(
                              'assets/images/driver1.jpg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Rajnesh Kumar',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('You rated',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500)),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text('Fare',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('₹23.0',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text('Coin',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('0',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('4.51km',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500)),
                      Text('Distance',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                  Column(
                    children: [
                      Text('11.0 mins',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500)),
                      Text('Duration',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.green),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Noida sector 16 India ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ],
            ),
            Row(children: [
              Column(children: [Container(child: Icon(Icons.more_vert))])
            ]),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 3),
                Expanded(
                  child: Text(
                    'New Delhi West   Delhi India',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Support',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 80,
                              height: 2,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        SizedBox(width: 202),
                        Text(
                          'Invice',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('Ride Safety',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Billing Related issues',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('I want to report an issue about a Captain',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

