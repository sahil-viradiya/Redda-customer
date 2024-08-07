import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/services/internate_services/dependency_injection.dart';
import 'package:redda_customer/services/location_services.dart';

import 'Utils/api_client.dart';
import 'Utils/constant.dart';
import 'services/notification/notification_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessagingHandler();
  DependencyInjection.init();

  String? token = await getToken();
  String? userID = await getUserId();

  // Run the app with the retrieved token
  runApp(MyApp(token));

  Future.delayed(const Duration(milliseconds: 500), () {
    // checkLocationPermission();
  });
}

final dio = Dio();
final dioClient = DioClient('https://ride.notionprojects.tech/api/rider/', dio);

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
      Get.put(LocationController());

      return AppRoutes.HOMESCREEN; // Home route
    } else {
      return AppRoutes.LOGIN; // Login route
    }
  }
}

