import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../provider/map_provider.dart';

class MapWidget extends StatelessWidget {
  final LatLng initialPosition;
  final Set<Marker> markers;
  final List<LatLng> polylineCoordinates;
  final width;
  final mapheight;

  const MapWidget({
    required this.initialPosition,
    required this.markers,
    required this.polylineCoordinates,
    this.width,
    this.mapheight,
  });

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);

    return Stack(
      children: [
        // Map with Animated Container for dynamic resizing
        AnimatedContainer(
          width: width,
          duration: Duration(milliseconds: 300),
          height: MediaQuery.of(context).size.height *
              mapProvider.mapHeightPercentage,
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {},
            initialCameraPosition: CameraPosition(
              target: initialPosition,
              zoom: mapProvider.currentZoomLevel,
            ),
            markers: markers,
            polylines: {
              Polyline(
                polylineId: PolylineId('route'),
                points: polylineCoordinates,
                width: 3,
                color: Color(0xff1937d7),
              ),
            },
            myLocationEnabled: true,
            zoomControlsEnabled: false, // Remove default zoom controls
          ),
        ),

        // Zoom and Expand Buttons
        Positioned(
          top: 200,
          right: 10,
          child: Column(
            children: [
              FloatingActionButton(
                backgroundColor: Colors.white,
                heroTag: "zoomIn",
                onPressed: () {
                  mapProvider.toggleZoom();
                },
                mini: true,
                child: mapProvider.zooming
                    ? Icon(Icons.zoom_in_map, color: Colors.black)
                    : Icon(Icons.zoom_out_map, color: Colors.black),
              ),
              SizedBox(height: 10),
              FloatingActionButton(
                backgroundColor: Colors.white,
                heroTag: "expandMap",
                onPressed: mapProvider.toggleMapSize,
                mini: true,
                child: Icon(mapProvider.mapHeightPercentage == 0.45
                    ? Icons.expand
                    : Icons.compress),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
