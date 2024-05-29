
import 'package:get/get.dart';
import 'package:redda_customer/screens/auth/create_account/sign_up_screen.dart';
import 'package:redda_customer/screens/auth/forgot_password/forgot_otp_screen.dart';
import 'package:redda_customer/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:redda_customer/screens/auth/otp/otp_screen.dart';
import 'package:redda_customer/screens/auth/resate_password/resate_password_screen.dart';
import 'package:redda_customer/screens/auth/signIn/signIn_Screen.dart';
import 'package:redda_customer/screens/home/home_binding.dart';
import 'package:redda_customer/screens/home/home_screen.dart';

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
    ),

  ];
}