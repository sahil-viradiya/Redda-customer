
import 'package:get/get.dart';
import 'package:redda_customer/screens/auth/create_account/sign_up_screen.dart';
import 'package:redda_customer/screens/auth/forgot_password/forgot_otp_screen.dart';
import 'package:redda_customer/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:redda_customer/screens/auth/otp/otp_screen.dart';
import 'package:redda_customer/screens/auth/resate_password/resate_password_screen.dart';
import 'package:redda_customer/screens/auth/signIn/signIn_Screen.dart';

class AppRoutes {
  static String SPLASHSCREEN = '/splash_screen';

  static String LOGIN = '/login_screen';
  static String FORGOTPASSWORD = '/forgot_password';
  static String FORGOTOTP = '/forgot_otp';
  static String RESATEPASSWORD = '/resate_password';
  static String SIGNUPSCREEN = '/create_account';
  static String OTPSCREEN = '/otp_screen';
  static String initialRoute = '/login_screen';

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
      bindings: [
        // SplashBinding(),
      ],
    ),GetPage(
      name: FORGOTPASSWORD,
      page: () => ForgotPasswordScreen(),
      bindings: [
        // SplashBinding(),
      ],
    ),GetPage(
      name: FORGOTOTP,
      page: () => ForgotOtpScreen(),
      bindings: [
        // SplashBinding(),
      ],
    ),GetPage(
      name: RESATEPASSWORD,
      page: () => ResetPasswordScreen(),
      bindings: [
        // SplashBinding(),
      ],
    ),GetPage(
      name: SIGNUPSCREEN,
      page: () => SignUpScreen(),
      bindings: [
        // SplashBinding(),
      ],
    ),GetPage(
      name: OTPSCREEN,
      page: () => OtpScreen(),
      bindings: [
        // SplashBinding(),
      ],
    ),

  ];
}