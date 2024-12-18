import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/constant.dart';
import 'package:redda_customer/Utils/validation.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/services/notification/notification_handler.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/screens/auth/signIn/signIn_controller.dart';
import 'package:redda_customer/widget/app_text_field.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';

class SignInScreen extends GetView<SignInController> {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  @override
  final SignInController controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
      controller.getDeviceType(context);

    MySize().init(
      context,
    );

    return WillPopScope(
      onWillPop: () async {
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(MySize.size30!),
                    Text(
                      'Welcome Back',
                      style: Styles.boldBlue720,
                    ),
                    Gap(MySize.size20!),
                    Text(
                      'Welcome to Redda! We are here to help with your work requirements',
                      style: Styles.noramalBlack411,
                      textAlign: TextAlign.center,
                    ),
                    Gap(MySize.size30!),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        alignment: Alignment.center,
                        height: MySize.size30,
                        width: MySize.size78,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Text(
                          'Sign In',
                          textAlign: TextAlign.center,
                          style: Styles.boldWhite615,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: MySize.getScaledSizeWidth(16)),
                          child: Container(
                            height: MySize.size28,
                            width: MySize.size1,
                            color: black,
                          )),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.SIGNUPSCREEN);
                        },
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: Styles.noramalBlack615,
                        ),
                      ),
                    ]),
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
                      controller: controller.emailCon,
                      keyboardType: TextInputType.emailAddress,
                      validator: ((value) {
                        return Validator.validateEmails(value!);
                      }),
                      // controller: loginBloc.usernameCon,
                      hintRpadding: 17.76,
                      lblTxt: '',
                    ),
                    Gap(MySize.size12!),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Password",
                        style: Styles.boldBlack614,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Gap(MySize.size4!),

                    CustomPasswordTextFormFieldWidget(
                      controller: controller.passCon,
                      validator: ((value) {
                        return Validator.validatePassword(value!);
                      }),
                      // controller: loginBloc.passCon,
                      lblTxt: '',
                      obscureText: true,
                      suffixTap: () {},
                    ),
                    Gap(MySize.size12!),
                    //---------------------------------------check box-----------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor: primary,
                              visualDensity:
                                  const VisualDensity(horizontal: -4),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              side: const BorderSide(color: primary),
                              // value: boolValue,
                              onChanged: (bool? value) {},
                              value: false,
                            ),
                            Text(
                              'Remember Me',
                              style: Styles.normalBlue610,
                            ),
                          ],
                        ),
                        //-----------------------------------Forgot Password--------------------------
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.FORGOTPASSWORD);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 28,
                            // color: Colors.red,
                            child: Text(
                              'Forgot password?',
                              style: Styles.normalBlue610U,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(MySize.size10!),
                    //-------------------------------------sign in button------------------
                    Obx(() {
                      return CustomButton(
                          isLoading: controller.isLoading.value,
                          text: 'Sign In',
                          fun: () {
                            if (_formKey.currentState!.validate()) {
                              debugPrint("TOKEN____________$token");
                              controller.signIn( deviceToken: fmcToken,
                                      deviceType: controller.deviceType.value);
                              // Get.toNamed(AppRoutes.HOMESCREEN);
                            }
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => BottomBarScreen()),
                            // );
                          });
                    }),
                    Gap(MySize.size24!),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.SIGNUPSCREEN);
                      },
                      child: Text(
                        'Create an Account',
                        style: Styles.normalBlue612U,
                      ),
                    ),
                    Gap(MySize.size24!),
                    // Row(
                    //   children: [
                    //     const Expanded(
                    //       child: DottedLine(
                    //         direction: Axis.horizontal,
                    //         alignment: WrapAlignment.center,
                    //         //lineLength: double.infinity,
                    //         lineThickness: 1.0,
                    //         dashLength: 4.0,
                    //         dashColor: Colors.black,
                    //         dashRadius: 0.0,
                    //         dashGapLength: 4.0,
                    //         dashGapColor: Colors.transparent,
                    //         dashGapRadius: 0.0,
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: MySize.getScaledSizeWidth(16.00)),
                    //       child: Text(
                    //         'OR',
                    //         style: Styles.noramalBlack416,
                    //       ),
                    //     ),
                    //     const Expanded(
                    //       child: DottedLine(
                    //         direction: Axis.horizontal,
                    //         alignment: WrapAlignment.center,
                    //         //lineLength: double.infinity,
                    //         lineThickness: 1.0,
                    //         dashLength: 4.0,
                    //         dashColor: Colors.black,
                    //         dashRadius: 0.0,
                    //         dashGapLength: 4.0,
                    //         dashGapColor: Colors.transparent,
                    //         dashGapRadius: 0.0,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Gap(MySize.size10!),
                    // Container(
                    //   alignment: Alignment.center,
                    //   height: MySize.size50,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(3.0),
                    //     border: Border.all(
                    //       color: primary,
                    //     ),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       SvgPicture.asset(
                    //         AppImage.FACEBOOK,
                    //         fit: BoxFit.fill,
                    //       ),
                    //       Text(
                    //         ' Login With Facebook',
                    //         style: Styles.boldBlue712,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Gap(MySize.size10!),
                    // Container(
                    //   alignment: Alignment.center,
                    //   height: MySize.size50,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(3.0),
                    //     border: Border.all(
                    //       color: primary,
                    //     ),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       SvgPicture.asset(
                    //         AppImage.GOOGLE,
                    //         fit: BoxFit.fill,
                    //       ),
                    //       Text(
                    //         ' Login With Google',
                    //         style: Styles.boldBlue712,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Gap(MySize.size30!),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class DynamicTextFieldRow extends StatefulWidget {
  const DynamicTextFieldRow({super.key});

  @override
  _DynamicTextFieldRowState createState() => _DynamicTextFieldRowState();
}

class _DynamicTextFieldRowState extends State<DynamicTextFieldRow> {
  int textFieldCount = 1;

  void addTextField() {
    setState(() {
      textFieldCount++;
    });
  }

  void removeTextField() {
    if (textFieldCount > 1) {
      setState(() {
        textFieldCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: addTextField,
          child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 12),
          ),
        ),
        const SizedBox(width: 5),
        Text(textFieldCount.toString()),
        const SizedBox(width: 5),
        InkWell(
          onTap: removeTextField,
          child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
            child: const Icon(Icons.remove, color: Colors.white, size: 12),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: textFieldCount,
            itemBuilder: (context, index) {
              return TextField(
                decoration: InputDecoration(
                  hintText: 'Text Field ${index + 1}',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
