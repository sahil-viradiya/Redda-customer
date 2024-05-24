import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/widget/app_text_field.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';

  class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});


  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: primaryWhite,
      appBar: Appbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MySize.getScaledSizeWidth(25)),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(MySize.size30!),
              Text(
                'Reset Password',
                style: Styles.boldBlue720,
              ),
              Gap(MySize.size20!),
              Text(
                'Welcome to Genie! We are here to help with your work requirements',
                style: Styles.noramalBlack411,
                textAlign: TextAlign.center,
              ),
              Gap(MySize.size30!),
              Align(
                alignment: Alignment.topLeft,
                child:
                Text("Password",style: Styles.boldBlack614,textAlign: TextAlign.left,),

              ),
              Gap(MySize.size4!),

              CustomTextFormFieldWidget(
                // lblTxt: AppString.resetPassword,
              ),
              Gap(MySize.size12!),
              Align(
                alignment: Alignment.topLeft,
                child:
                Text("Confirm Password",style: Styles.boldBlack614,textAlign: TextAlign.left,),

              ),
              Gap(MySize.size4!),
              CustomTextFormFieldWidget(
                // lblTxt: AppString.confirmPassword,
              ),
              Gap(MySize.size24!),
              CustomButton(
                  text: 'Submit',
                  fun: () {
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );*/
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
    );
  }
}