import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/validation.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/screens/address_details_screen/no_address_screen.dart';
import 'package:redda_customer/widget/app_text_field.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';
import 'address_details_screen_controller.dart';

class PAddressDetailsScreen extends GetView<PAddressDetailsScreenController> {
  const PAddressDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: white,

      appBar: appbarSmall1(
        context,
        "Enter Address Details",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
        child: Column(
          children: [
            Divider(),
            Gap(20),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Name",
                style: Styles.boldBlack614,
                textAlign: TextAlign.left,
              ),
            ),
            Gap(MySize.size6!),
            CustomTextFormFieldWidget(
              controller: TextEditingController(text: "sahil"),
              validator: ((value) {
                return Validator.validateFirstName(value!);
              }),
              // controller: loginBloc.usernameCon,
              hintRpadding: 17.76,
              lblTxt: '',
            ),
            Gap(MySize.size12!),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Mobile Number",
                style: Styles.boldBlack614,
                textAlign: TextAlign.left,
              ),
            ),
            Gap(MySize.size6!),
            CustomTextFormFieldWidget(
              controller: TextEditingController(text: "9725558828"),
              validator: ((value) {
                return Validator.validateFirstName(value!);
              }),
              // controller: loginBloc.usernameCon,
              hintRpadding: 17.76,
              lblTxt: '',
            ),
            Gap(MySize.size12!),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Email Address",
                style: Styles.boldBlack614,
                textAlign: TextAlign.left,
              ),
            ),
            Gap(MySize.size6!),
            CustomTextFormFieldWidget(
              controller: TextEditingController(text: "john@gmail.com"),

              validator: ((value) {
                return Validator.validateFirstName(value!);
              }),
              // controller: loginBloc.usernameCon,
              hintRpadding: 17.76,
              lblTxt: '',
            ),

            Gap(MySize.size12!),

            CustomButton(
              height: 40,
              borderCircular: 7,
              width: double.infinity,
              text: "Update Profile",
              fun: () {
                Get.to(NoAddressScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}
