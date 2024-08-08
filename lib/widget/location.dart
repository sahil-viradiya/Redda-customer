import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetLocationScreen extends StatelessWidget {
  const GetLocationScreen({
    super.key,
    required this.lat,
    required this.lng,
  });
  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      // myLocationButtonEnabled: true,
      compassEnabled: true,
      mapToolbarEnabled: true,
      buildingsEnabled: true,
      liteModeEnabled: false,
      // Make sure liteModeEnabled is set to false
      rotateGesturesEnabled: true,
      zoomGesturesEnabled: true,
      webGestureHandling: WebGestureHandling.greedy,
      // This is for web platforms
      scrollGesturesEnabled: true,
      // Enable scroll gestures
      tiltGesturesEnabled: true,
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(target: LatLng(lat, lng), zoom: 17),
      markers: <Marker>{
        Marker(
          markerId: const MarkerId('needleNew'),
          position: LatLng(lat, lng), // Use the updated position here.
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        ),
      },
    );
  }
}
