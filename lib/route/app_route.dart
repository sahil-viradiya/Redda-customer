
import 'package:get/get.dart';
import 'package:redda_customer/screens/Drop%20Location/checkout/checkout_binding.dart';
import 'package:redda_customer/screens/Drop%20Location/drop_address_details/drop_address_details_binding.dart';
import 'package:redda_customer/screens/Drop%20Location/drop_screen/drop_screen.dart';
import 'package:redda_customer/screens/Drop%20Location/drop_screen/drop_screen_binding.dart';
import 'package:redda_customer/screens/Drop%20Location/payment/payment_binding.dart';
import 'package:redda_customer/screens/Drop%20Location/payment/payment_screen.dart';
import 'package:redda_customer/screens/Drop%20Location/set_drop_location/set_current_drop_location.dart';
import 'package:redda_customer/screens/Drop%20Location/set_drop_location/set_drop_location_binding.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/address_details/address_details_binding.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/address_details/address_details_screen.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/pick_up/pick_up_binding.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/pick_up/pick_up_screen.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/set_pick_up_location/set_current_location.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/set_pick_up_location/set_pick_up_location_binding.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/set_pick_up_location/set_pick_up_location_screen.dart';
import 'package:redda_customer/screens/add_new_card/add_new_card_binding.dart';
import 'package:redda_customer/screens/add_new_card/add_new_card_screen.dart';
import 'package:redda_customer/screens/address_details_screen/add-new_address.dart';
import 'package:redda_customer/screens/edit_profile/edit_profile.dart';
import 'package:redda_customer/screens/address_details_screen/address_details_screen_binding.dart';
import 'package:redda_customer/screens/address_details_screen/no_address_screen.dart';

import 'package:redda_customer/screens/auth/create_account/sign_up_screen.dart';
import 'package:redda_customer/screens/auth/forgot_password/forgot_otp_screen.dart';
import 'package:redda_customer/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:redda_customer/screens/auth/otp/otp_screen.dart';
import 'package:redda_customer/screens/auth/resate_password/resate_password_screen.dart';
import 'package:redda_customer/screens/auth/signIn/signIn_Screen.dart';
import 'package:redda_customer/screens/home/home_binding.dart';
import 'package:redda_customer/screens/home/home_screen.dart';
import 'package:redda_customer/screens/link_account/link_account_binding.dart';
import 'package:redda_customer/screens/link_account/link_account_screen.dart';
import 'package:redda_customer/screens/payment_option/payment_option.dart';
import 'package:redda_customer/screens/payment_option/payment_option_binding.dart';

import '../screens/Drop Location/checkout/checkout_screen.dart';
import '../screens/Drop Location/drop_address_details/drop_address_details_screen.dart';
import '../screens/Drop Location/pick_or_send_any/pick_or_send_any_binding.dart';
import '../screens/Drop Location/pick_or_send_any/pick_or_send_any_screen.dart';
import '../screens/Drop Location/set_drop_location/set_drop_location_screen.dart';
import '../screens/edit_profile/edit_profile_binding.dart';

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
  static String SETCURRENTLOCATION = '/set_CURRENT_location';
  static String SETCURRENTDROPTLOCATION = '/set_CURRENT_drop_location';
  static String SETPICKUPLOCATION = '/set_pickUp_location';
  static String SETDROPLOCATION = '/set_drop_location';
  static String ADDRESSDETAILS = '/address_details';
  static String DROPADDRESSDETAILS = '/drop_address_details';
  static String DROPSCREEN = '/drop_screen';
  static String PICKUPORSENDANYTHING = '/pickup_or_send_any';
  static String CHECKOUT = '/checkout';
  static String PAYMENT = '/payment';
  static String EDIT_PROFILE = '/edit_profile';
  static String NO_ADDRESS = '/no_address';
  static String ADD_ADDRESS = '/add_address';
  static String PAYMENTOPTION = '/payment_option';
  static String ADDNEWCARD = '/add_new_card';
  static String LINKACCOUNTSCREEN = '/link_account_screen';

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
      name: LINKACCOUNTSCREEN,
      page: () => const LinkAccountScreen(),
      bindings:  [
        LinkAccountBinding(),
      ],
    ), GetPage(
      name: PAYMENTOPTION,
      page: () => const PaymentOptionScreen(),
      bindings:  [
        PaymentOptionBinding()
      ],
    ),GetPage(
      name: ADDNEWCARD,
      page: () => const AddNewCardScreen(),
      bindings:  [
        AddNewCardBinding()
      ],
    ),  GetPage(
      name: EDIT_PROFILE,
      page: () =>  EditProfile(),
      bindings:  [
        EditProfileBinding()
      ],
    ), GetPage(
      name: NO_ADDRESS,
      page: () => const NoAddressScreen(),
      bindings:  [
        AddAddressBinding()
      ],
    ), GetPage(
      name: ADD_ADDRESS,
      page: () => const AddNewAddress(),
      bindings:  [
        AddAddressBinding()
      ],
    ),   GetPage(
      name: PICKUPORSENDANYTHING,
      page: () => const PickOrSendAnyScreen(),
      bindings:  [
        PickOrSendAnyBinding(),
      ],
    ), GetPage(
      name: PAYMENT,
      page: () => const PaymentScreen(),
      bindings:  [
        PaymentBinding(),
      ],
    ),GetPage(
      name: CHECKOUT,
      page: () => const CheckoutScreen(),
      bindings:  [
        CheckoutBinding(),
      ],
    ),GetPage(
      name: DROPADDRESSDETAILS,
      page: () => const DropAddressDetailsScreen(),
      bindings:  [
        DropAddressDetailsBinding(),
      ],
    ),GetPage(
      name: SETCURRENTDROPTLOCATION,
      page: () => const SetCurrentDropLocation(),
      bindings:  [
        SetDropLocationBinding(),
      ],
    ), GetPage(
      name: SETDROPLOCATION,
      page: () => const SetDropLocationScreen(),
      bindings:  [
        SetDropLocationBinding(),
      ],
    ), GetPage(
      name: DROPSCREEN,
      page: () => const DropScreen(),
      bindings:  [
        DropScreenBinding(),
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
      page: () =>  HomeScreen(),
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
      page: () =>  AddressDetailsScreen(),
      bindings: [
        AddressDetailsBinding(),
      ],
    ),

  ];
}