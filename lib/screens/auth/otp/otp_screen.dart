import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/validation.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/screens/auth/otp/otp_controller.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';
import 'package:redda_customer/widget/otp_widget.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();
  final OtpController _controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    // final arguments = Get.arguments;

    // // Extract the 'userId' from the arguments
    // final userId = arguments['userId'];
    // log(" id --  $userId");

    MySize().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: primaryWhite,
        appBar: Appbar(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MySize.getScaledSizeWidth(25)),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(MySize.size30!),
                  Text(
                    'Enter OTP',
                    style: Styles.boldBlue720,
                  ),
                  Gap(MySize.size20!),
                  Text(
                    'A One-time password will be sent to your phone.',
                    style: Styles.noramalBlack411,
                    textAlign: TextAlign.center,
                  ),
                  Gap(MySize.size30!),
                  Text(
                    'OTP',
                    style: Styles.boldBlue615,
                  ),
                  Gap(MySize.size30!),
                  OTPWidget(
                    validator: ((value) {
                      return Validator.validateMobileOtp(value!);
                    }),
                    controller: _controller.otpCon,
                  ),
                  Gap(MySize.size10!),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _controller.resendOtp();
                        },
                        child: Text(
                          'Resend?',
                          style: Styles.normalBlue612U,
                        ),
                      ),
                    ],
                  ),
                  Gap(MySize.size35!),
                  Obx(() {
                    return CustomButton(
                        isLoading: _controller.isLoading.value,
                        text: 'Submit',
                        fun: () {
                          // Get.toNamed(AppRoutes.RESATEPASSWORD);
                          if (_formKey.currentState!.validate()) {
                            _controller.verifyOtp();
                            // _controller.verifyOtp(userId: userId.toString());
                          }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => SignUpScreen()),
                          // );
                        });
                  }),
                  Gap(MySize.size24!),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.initialRoute),
                    child: Text(
                      'Back to Login Page',
                      style: Styles.normalBlue612U,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
