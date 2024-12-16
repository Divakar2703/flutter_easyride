import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../model/booking.dart';
import '../../provider/map_provider.dart';
import '../../utils/eve.dart';

class MapTrackingScreen extends StatefulWidget {
  Booking booking;
  MapTrackingScreen({Key? key, required this.booking}) : super(key: key);

  @override
  _MapTrackingScreenState createState() => _MapTrackingScreenState();
}

class _MapTrackingScreenState extends State<MapTrackingScreen> {
  late GoogleMapController _mapController;

  // Booking Details
  final Map<String, dynamic> rideData = {
    "id": "57",
    "book_id": "Book-00741725",
    "booking_type": "book_now",
    "pickup_address": ", Anarwala, Dehradun, Uttarakhand, 248014",
    "drop_address": ", Hathibarkala, Dehradun, Uttarakhand, 248001",
    "user_journey_distance": "2.2",
    "total_fare": "26",
    "total_wait_charge": "0",
    "grand_total": "26.4",
    "paymenttype": "COD",
    "user_name": "Ankita Kanaujiya",
    "user_mobile": "7505145405",
    "user_email": "ankitakanaujiya@gmail.com",
    "pickup_lat": "30.3683644",
    "pickup_long": "78.0516538",
    "drop_lat": "30.348644013683",
    "drop_long": "78.052923046052",
    "ride_status": "Start",
    "payment_status": "Paid",
    "entry_date": "13/12/2024 14:39 PM"
  };
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addMarkers();
    _createPolyline();
    final mapProvider = Provider.of<MapProvider>(context, listen: false);

    mapProvider.getPolyPoints(ALatitude, ALongitude, dropLat, dropLong);

  }

  void _addMarkers() {
    LatLng pickupLocation = LatLng(
      double.parse(rideData['pickup_lat']),
      double.parse(rideData['pickup_long']),
    );

    LatLng dropLocation = LatLng(
      double.parse(rideData['drop_lat']),
      double.parse(rideData['drop_long']),
    );

    _markers.add(
      Marker(
        markerId: MarkerId('pickup'),
        position: pickupLocation,
        infoWindow: InfoWindow(title: 'Pickup Location'),
      ),
    );

    _markers.add(
      Marker(
        markerId: MarkerId('drop'),
        position: dropLocation,
        infoWindow: InfoWindow(title: 'Drop Location'),
      ),
    );
  }

  void _createPolyline() {
    LatLng pickupLocation = LatLng(
      double.parse(rideData['pickup_lat']),
      double.parse(rideData['pickup_long']),
    );

    LatLng dropLocation = LatLng(
      double.parse(rideData['drop_lat']),
      double.parse(rideData['drop_long']),
    );

    Polyline polyline = Polyline(
      polylineId: PolylineId('route'),
      points: [pickupLocation, dropLocation],
      color: Colors.blue,
      width: 5,
    );

    setState(() {
      _polylines.add(polyline);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                double.parse(rideData['pickup_lat']),
                double.parse(rideData['pickup_long']),
              ),
              zoom: 14.0,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            markers: _markers,
            polylines: {
              Polyline(
                polylineId: PolylineId('route'),
                points: mapProvider.polylineCoordinates,
                width: 3,
                color: Color(0xff1937d7),
              ),
            },            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          // Bottom Sheet for Booking Details
          DraggableScrollableSheet(
            initialChildSize: 0.3, // Initial height
            minChildSize: 0.3, // Minimum height
            maxChildSize: 0.6, // Maximum height
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Booking Details',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildDetailRow('Booking ID', widget.booking.bookId),
                        _buildDetailRow('Pickup Address',widget.booking.pickupAddress),
                        _buildDetailRow('Drop Address', widget.booking.dropAddress),
                        _buildDetailRow('Distance', widget.booking.userJourneyDistance),
                        _buildDetailRow('Total Fare', widget.booking.totalFare),
                        _buildDetailRow('Grand Total', widget.booking.grandTotal),
                        _buildDetailRow('Payment Type', widget.booking.paymentStatus),
                        _buildDetailRow('Ride Status',widget.booking.rideStatus ),
                        SizedBox(height: 20),
                        Text(
                          'Passenger Details',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildDetailRow('Name', widget.booking.userName),
                        _buildDetailRow('Mobile', widget.booking.userMobile),
                        _buildDetailRow('Email', widget.booking.userEmail),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.5,
            child: Text(
              value,
              maxLines: 1,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
