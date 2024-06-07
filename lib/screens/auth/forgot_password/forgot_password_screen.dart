import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/validation.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/widget/app_text_field.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final ForgotPasswordController _controller =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
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
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => ResetPasswordScreen()),
                      // );
                    },
                    child: Text(
                      'Forgot Password',
                      style: Styles.boldBlue720,
                    ),
                  ),
                  Gap(MySize.size20!),
                  Text(
                    'Welcome to Sos! We are here to help with your work requirements',
                    style: Styles.noramalBlack411,
                    textAlign: TextAlign.center,
                  ),
                  Gap(MySize.size30!),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Email",
                      style: Styles.boldBlack614,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Gap(MySize.size4!),
                  CustomTextFormFieldWidget(
                    controller: _controller.emailCon,
                    validator: (value) {
                      return Validator.validateEmails(value!);
                    },
                  ),
                  Gap(MySize.size24!),
                  Obx(() {
                    return CustomButton(
                        isLoading: _controller.isLoading.value,
                        text: 'Submit',
                        fun:  _controller.isLoading.value!=true
                            ?() {
                                if (_formKey.currentState!.validate()) {
                                  _controller.forgotPassword();
                                }
                              }
                            : (){});
                  }),
                  Gap(MySize.size24!),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.initialRoute);
                    },
                    child: Text(
                      'Back to Login Page',
                      style: Styles.normalBlue612U,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
