import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/pref.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/screens/auth/signIn/signIn_Screen.dart';

String? token;
Future<String?> getToken() async {
  token = await SharedPref.readString(Config.kAuth);
  print("TOKEN=========>> $token");
  return token;
}

String? userId;
Future<String?> getUserId() async {
  userId = await SharedPref.readString(Config.userId);
  print("USER_ID=========>> $userId");
  return userId;
}

void resate(BuildContext context) async {
  await SharedPref.saveString(Config.kAuth, '');
  // await SharedPref.saveString(Config.userId, '');
  Get.offAll(SignInScreen());
}

String pPolicy = "Personal Information Parcel does not require its customers to provide any personal information. The only exception is your email address which is required only if you decide to create a Parcel account with an email and password.You can always create an account with Sign in with Email and your email will not be provided to us.Your DeliveriesAny information that is related to your deliveries (e.g. tracking numbers, postcodes, tracking history) is not shared with any 3rd parties.Anonymous InformationParcel collects anonymous data about your device that does not directly identify you, such as: version of the app, version of the operating system you are running, system language, device model, timezone, country code. This information is used solely for the purpose of improving our services and is not shared with any 3rd parties.Account DeletionYou can delete your Parcel account in the app settings.Parcel EmailParcel Email service is a separate service which allows you to forward emails from merchants/carriers to your unique email address in order for the tracking numbers in these emails to be automatically recognized and added to your Parcel Account.Emails received from you this way are kept for 12 months for the purpose of improving our services. Emails are not shared with any 3rd parties.AdvertisementsIf you are not a subscriber, you will see advertisements in the iOS version of the app. Those ads are managed by Google’s AdMob system. This system was configured not to show personalized ads in Parcel. Tracking and analytic capabilities were also disabled. You can read more about Google’s Privacy policies here.Privacy Policy ChangesFrom time to time this privacy policy might be updated with minor changes. Your continued use of this app after any change in this Privacy Policy will constitute your acceptance of such change.";