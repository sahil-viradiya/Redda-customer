import 'package:get/get.dart';
import 'package:redda_customer/screens/wallet/wallet_screen.dart';
import 'package:redda_customer/screens/Drop%20Location/drop_screen/drop_screen.dart';
import 'package:redda_customer/screens/Drop%20Location/payment/payment_screen.dart';
import 'package:redda_customer/screens/Drop%20Location/set_drop_location/set_current_drop_location.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/address_details/address_details_screen.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/pick_up/pick_up_screen.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/set_pick_up_location/set_current_location.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/set_pick_up_location/set_pick_up_location_screen.dart';
import 'package:redda_customer/screens/add_new_card/add_new_card_screen.dart';
import 'package:redda_customer/screens/address_details_screen/add_new_address.dart';
import 'package:redda_customer/screens/edit_profile/edit_profile.dart';
import 'package:redda_customer/screens/address_details_screen/no_address_screen.dart';

import 'package:redda_customer/screens/auth/create_account/sign_up_screen.dart';
import 'package:redda_customer/screens/auth/forgot_password/forgot_otp_screen.dart';
import 'package:redda_customer/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:redda_customer/screens/auth/otp/otp_screen.dart';
import 'package:redda_customer/screens/auth/resate_password/resate_password_screen.dart';
import 'package:redda_customer/screens/auth/signIn/signIn_Screen.dart';
import 'package:redda_customer/screens/home/home_screen.dart';
import 'package:redda_customer/screens/link_account/link_account_screen.dart';
import 'package:redda_customer/screens/payment_option/payment_option.dart';
import 'package:redda_customer/services/internate_services/no_internate_screen.dart';

import '../screens/Drop Location/checkout/checkout_screen.dart';
import '../screens/Drop Location/drop_address_details/drop_address_details_screen.dart';
import '../screens/Drop Location/pick_or_send_any/pick_or_send_any_screen.dart';
import '../screens/Drop Location/set_drop_location/set_drop_location_screen.dart';

class AppRoutes {
  static const String SPLASHSCREEN = '/splash_screen';
  static const String NoInterNate = '/no_internate';

  static const String LOGIN = '/login_screen';
  static const String FORGOTPASSWORD = '/forgot_password';
  static const String FORGOTOTP = '/forgot_otp';
  static const String RESATEPASSWORD = '/resate_password';
  static const String SIGNUPSCREEN = '/create_account';
  static const String initialRoute = '/login_screen';
  static const String OTPSCREEN = '/otp_screen';
  static const String HOMESCREEN = '/home_screen';
  static const String PICKUPSCREEN = '/pickUp_screen';
  static const String SETCURRENTLOCATION = '/set_CURRENT_location';
  static const String SETCURRENTDROPTLOCATION = '/set_CURRENT_drop_location';
  static const String SETPICKUPLOCATION = '/set_pickUp_location';
  static const String SETDROPLOCATION = '/set_drop_location';
  static const String ADDRESSDETAILS = '/address_details';
  static const String DROPADDRESSDETAILS = '/drop_address_details';
  static const String DROPSCREEN = '/drop_screen';
  static const String PICKUPORSENDANYTHING = '/pickup_or_send_any';
  static const String CHECKOUT = '/checkout';
  static const String PAYMENT = '/payment';
  static const String EDIT_PROFILE = '/edit_profile';
  static const String NO_ADDRESS = '/no_address';
  static const String ADD_ADDRESS = '/add_address';
  static const String PAYMENTOPTION = '/payment_option';
  static const String ADDNEWCARD = '/add_new_card';
  static const String LINKACCOUNTSCREEN = '/link_account_screen';
  static const String WALLETSCREEN = '/wallet_screen';

  static List<GetPage> get pages => [
        GetPage(
          name: initialRoute,
          page: () => SignInScreen(),
        ),
        GetPage(
          name: NoInterNate,
          page: () => const NoInternateScreen(),
        ),
        GetPage(
          name: WALLETSCREEN,
          page: () => const WalletScreen(),
        ),
        GetPage(
          name: LINKACCOUNTSCREEN,
          page: () => const LinkAccountScreen(),
        ),
        GetPage(
          name: PAYMENTOPTION,
          page: () => const PaymentOptionScreen(),
        ),
        GetPage(
          name: ADDNEWCARD,
          page: () => const AddNewCardScreen(),
        ),
        GetPage(
          name: EDIT_PROFILE,
          page: () => const EditProfile(),
        ),
        GetPage(
          name: NO_ADDRESS,
          page: () => const NoAddressScreen(),
        ),
        GetPage(
          name: ADD_ADDRESS,
          page: () => const AddNewAddress(),
        ),
        GetPage(
          name: PICKUPORSENDANYTHING,
          page: () => const PickOrSendAnyScreen(),
        ),
        GetPage(
          name: PAYMENT,
          page: () => const PaymentScreen(),
        ),
        GetPage(
          name: CHECKOUT,
          page: () => const CheckoutScreen(),
        ),
        GetPage(
          name: DROPADDRESSDETAILS,
          page: () => DropAddressDetailsScreen(),
        ),
        GetPage(
          name: SETCURRENTDROPTLOCATION,
          page: () => const SetCurrentDropLocation(),
        ),
        GetPage(
          name: SETDROPLOCATION,
          page: () => const SetDropLocationScreen(),
        ),
        GetPage(
          name: DROPSCREEN,
          page: () => const DropScreen(),
        ),
        GetPage(
          name: FORGOTPASSWORD,
          page: () => ForgotPasswordScreen(),
        ),
        GetPage(
          name: FORGOTOTP,
          page: () => ForgotOtpScreen(),
        ),
        GetPage(
          name: RESATEPASSWORD,
          page: () => ResetPasswordScreen(),
        ),
        GetPage(
          name: SIGNUPSCREEN,
          page: () => SignUpScreen(),
        ),
        GetPage(
          name: OTPSCREEN,
          page: () => OtpScreen(),
        ),
        GetPage(
          name: HOMESCREEN,
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: PICKUPSCREEN,
          page: () => const PickUpScreen(),
        ),
        GetPage(
          name: SETPICKUPLOCATION,
          page: () => const SetPickUpLocationLocation(),
        ),
        GetPage(
          name: SETCURRENTLOCATION,
          page: () => const SetCurrentLocation(),
        ),
        GetPage(
          name: ADDRESSDETAILS,
          page: () => AddressDetailsScreen(),
        ),
      ];
}
