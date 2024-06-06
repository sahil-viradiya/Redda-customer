import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redda_customer/route/app_route.dart';

import 'Utils/api_client.dart';


void main() {
  // if (defaultTargetPlatform == TargetPlatform.android) {
  //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  // }
  FlutterError.onError = (FlutterErrorDetails details){
    print("GLOBAL ERROR: ======> ${details.exception}");
  };


  runApp(const MyApp());
}
final dio = Dio();
final dioClient = DioClient('https://ride.notionprojects.tech/api/customer/', dio);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

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
          initialRoute: AppRoutes.initialRoute,
          getPages: AppRoutes.pages,
        ),
      ),
    );
  }
}