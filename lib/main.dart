import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/route/app_route.dart';

import 'Utils/api_client.dart';
import 'Utils/constant.dart';
import 'Utils/pref.dart';
import 'constant/api_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    print("GLOBAL ERROR: ======> ${details.exception}");
  };

  // Check location permissions and services

  String? token = await getToken();
  String? userID = await getUserId();

  // Run the app with the retrieved token
  runApp(MyApp(token));
  Future.delayed(Duration(milliseconds: 500), () {
    checkLocationPermission();
  });
}


final dio = Dio();
final dioClient =
    DioClient('https://ride.notionprojects.tech/api/customer/', dio);
class MyApp extends StatelessWidget {
  final String? token;

  const MyApp(this.token, {super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return ScreenUtilInit(
      designSize: const Size(360, 700),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Redda customer',
          initialRoute: _getInitialRoute(),
          getPages: AppRoutes.pages,
        ),
      ),
    );
  }

  String _getInitialRoute() {
    log("message=========${token.toString()} ");
    if (token != null && token!.isNotEmpty) {
      return AppRoutes.HOMESCREEN; // Home route
    } else {
      return AppRoutes.LOGIN; // Login route
    }
  }
}




Future<void> checkLocationPermission() async {
  LocationPermission permission;

  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Show a message to the user indicating that location services are not enabled
    LocationPermission permission;

    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Show a message to the user indicating that location services are not enabled
      Future.delayed(Duration.zero, () async {
        await Get.defaultDialog(
          title: 'Location Service Disabled',
          middleText: 'Please enable location services to proceed.',
          onConfirm: () async {
            // Open location settings for the user to enable location services
            await Geolocator.openLocationSettings();
            Get.back();
          },
          textConfirm: 'Enable',
        );
      });
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, show a message to the user
        await Get.defaultDialog(
          title: 'Location Permission Denied',
          middleText: 'Please grant location permissions to proceed.',
          onConfirm: () async {
            // Open app settings for the user to enable location permissions
            await Geolocator.openAppSettings();
            Get.back();
          },
          textConfirm: 'Enable',
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, show a message to the user
      await Get.defaultDialog(
        title: 'Location Permission Denied',
        middleText: 'Please enable location permissions from settings to proceed.',
        onConfirm: () async {
          // Open app settings for the user to enable location permissions
          await Geolocator.openAppSettings();
          Get.back();
        },
        textConfirm: 'Enable',
      );
      return;
    }

    // Permissions are granted, proceed with accessing the location
  }
}

Future<bool> isLocationServiceEnabled() async {
  bool serviceEnabled;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  return serviceEnabled;
}
