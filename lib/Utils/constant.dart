import 'package:redda_customer/Utils/pref.dart';
import 'package:redda_customer/constant/api_key.dart';

String? token;
Future<String?> getToken() async {
  token  = await SharedPref.readString(Config.kAuth);
  print("TOKEN=========>> $token");
  return token;
}
String? userId;
Future<String?> getUserId() async {
  userId  = await SharedPref.readString(Config.userId);
  print("USER_ID=========>> $userId");
  return userId;
}