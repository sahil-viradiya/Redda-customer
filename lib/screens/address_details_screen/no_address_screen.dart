import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/screens/address_details_screen/add-new_address.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';

class NoAddressScreen extends StatelessWidget {
  const NoAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Addresses",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),

        child: Column(
          children: [
            Divider(),
            Gap(20),
            Text(
              "No Any address Added.",
              style: Styles.boldBlack616,
            ),
            Text(
              "No Any address Added.Kindly add new address to below button.",
              style: Styles.lable414,
              textAlign: TextAlign.center,
            ),
            Gap(20),

            CustomButton(
              height: 40,
              borderCircular: 7,
              width: double.infinity,
              text: "ADD NEW ADDRESS",
              fun: () {
                Get.to(AddNewAddress());
              },
            )
          ],
        ),
      ),
    );
  }
}
