import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/route/app_route.dart';
import 'rider_location_screen_controller.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

class RiderLocationScreen extends GetView<RiderLocationScreenController> {
  const RiderLocationScreen(
      {super.key,
     });
 

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RiderLocationScreenController());
    log("Currnet Lat---> ${controller.currentLat.value}");

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoutes.HOMESCREEN);
        return false;
      },
      child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            backgroundColor: primary,
            tooltip: "Go to Home",
            onPressed: () {
              Get.offAllNamed(AppRoutes.HOMESCREEN);
            },
            child: const Icon(
              Icons.home,
              color: white,
            ),
          ),
          backgroundColor: white,
          body: Obx(
            () => controller.currentLat.value == 0.0
                ? const Center(
                    child: CircularProgressIndicator(
                    color: primary,
                  ))
                : GoogleMap(
                    // myLocationButtonEnabled: true,
                    mapType: MapType.normal,
                    myLocationEnabled: false,
                    rotateGesturesEnabled: true,
                    buildingsEnabled: true,
                    fortyFiveDegreeImageryEnabled: true,
                    mapToolbarEnabled: true,
                    // scrollGesturesEnabled: false,
                    // tiltGesturesEnabled: false,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,

                    initialCameraPosition: CameraPosition(
                      zoom: CAMERA_ZOOM,
                      // tilt: CAMERA_TILT,
                      bearing: CAMERA_BEARING,

                      target: LatLng(
                        controller.currentLat.value,
                        controller.currentLng.value,  
                      ),
                    ),

                    polylines: Set<Polyline>.of(controller.polylines.values),
                    markers: Set<Marker>.of(controller.markers),
                  ),
          )),
    );
  }
}
