
import 'package:get/get.dart';
import 'package:redda_customer/screens/address_details/address_details_binding.dart';
import 'package:redda_customer/screens/address_details/address_details_screen.dart';
import 'package:redda_customer/screens/auth/create_account/sign_up_screen.dart';
import 'package:redda_customer/screens/auth/forgot_password/forgot_otp_screen.dart';
import 'package:redda_customer/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:redda_customer/screens/auth/otp/otp_screen.dart';
import 'package:redda_customer/screens/auth/resate_password/resate_password_screen.dart';
import 'package:redda_customer/screens/auth/signIn/signIn_Screen.dart';
import 'package:redda_customer/screens/home/home_binding.dart';
import 'package:redda_customer/screens/home/home_screen.dart';
import 'package:redda_customer/screens/pick_up/pick_up_binding.dart';
import 'package:redda_customer/screens/pick_up/pick_up_screen.dart';
import 'package:redda_customer/screens/set_pick_up_location/set_current_location.dart';
import 'package:redda_customer/screens/set_pick_up_location/set_pick_up_location_binding.dart';
import 'package:redda_customer/screens/set_pick_up_location/set_pick_up_location_screen.dart';

class AppRoutes {
  static String SPLASHSCREEN = '/splash_screen';

  static String LOGIN = '/login_screen';
  static String FORGOTPASSWORD = '/forgot_password';
  static String FORGOTOTP = '/forgot_otp';
  static String RESATEPASSWORD = '/resate_password';
  static String SIGNUPSCREEN = '/create_account';
  static String initialRoute = '/login_screen';
  static String OTPSCREEN = '/otp_screen';
  static String HOMESCREEN = '/home_screen';
  static String PICKUPSCREEN = '/pickUp_screen';
  static String SETPICKUPLOCATION = '/set_pickUp_location';
  static String SETCURRENTLOCATION = '/set_CURRENT_location';
  static String ADDRESSDETAILS = '/address_details';

  static List<GetPage> pages = [
    // GetPage(
    //   name: splashScreen,
    //   page: () => const SplashScreen(),
    //   bindings: [
    //     SplashBinding(),
    //   ],

    GetPage(
      name: initialRoute,
      page: () => SignInScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),GetPage(
      name: FORGOTPASSWORD,
      page: () => ForgotPasswordScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),GetPage(
      name: FORGOTOTP,
      page: () => ForgotOtpScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),GetPage(
      name: RESATEPASSWORD,
      page: () => ResetPasswordScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),GetPage(
      name: SIGNUPSCREEN,
      page: () => SignUpScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),GetPage(
      name: OTPSCREEN,
      page: () => OtpScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),GetPage(
      name: HOMESCREEN,
      page: () => const HomeScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),GetPage(
      name: PICKUPSCREEN,
      page: () => const PickUpScreen(),
      bindings: [
        PickUpBinding(),
      ],
    ),GetPage(
      name: SETPICKUPLOCATION,
      page: () => const SetPickUpLocationLocation(),
      bindings: [
        SetPickUpLocationBinding(),
      ],
    ),GetPage(
      name: SETCURRENTLOCATION,
      page: () => const SetCurrentLocation(),
      bindings: [
        SetPickUpLocationBinding(),
      ],
    ),GetPage(
      name: ADDRESSDETAILS,
      page: () => const AddressDetailsScreen(),
      bindings: [
        AddressDetailsBinding(),
      ],
    ),

  ];
}