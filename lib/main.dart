import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/route/app_route.dart';

import 'Utils/api_client.dart';
import 'Utils/constant.dart';
import 'Utils/pref.dart';
import 'constant/api_key.dart';

void main() async{
  // if (defaultTargetPlatform == TargetPlatform.android) {
  //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  // }
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    print("GLOBAL ERROR: ======> ${details.exception}");
  };



  String? token = await getToken();
  String? userID = await getUserId();

  // Run the app with the retrieved token
  runApp(MyApp(token));
}

final dio = Dio();
final dioClient =
    DioClient('https://ride.notionprojects.tech/api/customer/', dio);

class MyApp extends StatelessWidget {
  const MyApp(String? token, {super.key});

  // This widget is the root of your application.
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
}
String _getInitialRoute() {
  // Replace with your actual token checking logic
   getToken();
  log("message=========${token.toString()} ");
  if (token != null && token.toString().isNotEmpty||token!='') {
    return AppRoutes.HOMESCREEN; // Home route
  } else {
    return AppRoutes.LOGIN; // Login route
  }
}


