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
    final details = Provider.of<TriphistryProvider>(context, listen: false);
    details.triphistryDetails();

    super.initState();
  }
  double distance = 34.0;

  @override
  Widget build(BuildContext context) {
    final details = Provider.of<TriphistryProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Trip History Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
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
                            'vehicle',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(details.triphistory?.vehicle.toString() ?? 'N/A',
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
                          Text(
                            'Entry Date',
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
                      Text(details.triphistory?.entryDate ?? 'N/A',
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
                          Text(
                            'Date of Ride',
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
                      Text(
                        'July 28th 2021 11:24 Am',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      )
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
                          Text(
                            'RideID',
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
                      Text(details.triphistory?.bookId ?? 'NA',
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
                              child: Image.network(
                                  details.triphistory?.driverImg ?? 'NA'),
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
                          Text(details.triphistory?.driverName ?? 'NA',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500)),
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
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Image.network(
                          details.triphistory?.vehicleImage ?? 'NA'),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                  ),
                  Text('Vehicle Image',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Fare',
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
                      Row(
                        children: [
                          Text(
                            details.triphistory?.totalFare ?? 'NA',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('₹')
                        ],
                      )
                    ],
                  ),
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
                          Text(
                            'Coin',
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
                      Text(
                        '0',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
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
                          Text(
                            'Ride Status',
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
                      Text(details.triphistory?.rideStatus ?? 'NA',
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
                          Text('Payment Status',
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
                      Text(details.triphistory?.paymentStatus ?? 'NA',
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
                          Text('Payment Type',
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
                      Text(details.triphistory?.paymenttype ?? 'NA',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500),),
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
                          Text('Vehicle Number',
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
                      Text(details.triphistory?.vehicalNumber ?? 'NA',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500),)
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
                          Text('Status',
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
                      Text(
                        details.triphistory?.status ?? '',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '4.51km',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Distance',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '11.0 mins',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Duration',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
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
                      details.triphistory?.pickupAddress ?? 'NA',
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
                      details.triphistory?.dropAddress ?? 'NA',
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
                      Text(
                        'I want to report an issue about a Captain',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
