  import 'package:flutter/material.dart';
  import 'package:gap/gap.dart';
  import 'package:get/get.dart';
  import 'package:redda_customer/constant/app_color.dart';
  import 'package:redda_customer/constant/app_image.dart';
  import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/screens/link_account/verify_link_account.dart';
  import 'package:redda_customer/widget/app_text_field.dart';
  import 'package:redda_customer/widget/auth_app_bar_widget.dart';
  import 'package:redda_customer/widget/custom_button.dart';
  import 'link_account_controller.dart';

class LinkAccountScreen extends GetView<LinkAccountController> {
  const LinkAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Link Mobikwik Account",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Enter mobile number to link Mobikwik account",
                    style: Styles.boldBlack616,
                  ),
                ),
                Image(
                  image: AssetImage(AppImage.MOBIKWIK),
                  width: 60,
                  height: 60,
                ),
              ],
            ),
            Gap(8),
            Text(
              "If you don’t have an account, we will create for you.",
              style: Styles.lable414,
            ),
            Gap(8),
            CustomTextFormFieldWidget(),
            Gap(8),
            CustomButton(
              text: "Confirm and Proceed",
              fun: () {
                Get.to(VerifyLinkAccount());
              },
              borderCircular: 7,
              width: double.infinity,

              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
