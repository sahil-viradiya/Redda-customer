import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/app_image.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';
import 'package:redda_customer/widget/otp_widget.dart';

class VerifyLinkAccount extends StatelessWidget {
  const VerifyLinkAccount({super.key});

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
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Enter OTP received on 1324567890",
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
            const Gap(14),
            const Align(
              alignment: Alignment.center,
              child: OTPWidget(),
            ),
            const Gap(14),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
                child: Text(
                  'Resend?',
                  style: Styles.normalBlue612U,
                ),
              ),
            ),
            const Gap(34),
            CustomButton(
              text: "Verify and Link Account",
              fun: () {
                // Get.to(const Wallet());
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
