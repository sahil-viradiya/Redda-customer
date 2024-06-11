import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/app_image.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/screens/address_details_screen/enter_new_address_details.dart';
import 'package:redda_customer/screens/address_details_screen/set_delivery_location.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';

class AddNewAddress extends StatelessWidget {
  const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Addresses",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Divider(),
            Gap(20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 18),
                    child: SvgPicture.asset(
                      AppImage.LOCATION,
                      height: 14,
                      width: 14,
                      color: primary,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, top: 18),
                          child: Text(
                            'Home',
                            style: Styles.boldBlack612,
                          ),
                        ),
                        Text(
                          "98, Rajhans Society, Varachha, Surat,Gujrat 395010, India.",
                          style: Styles.lable411,
                        ),
                        Gap(6),
                        Text(
                          "Mobile Number:  +1 98756 23698",
                          style: Styles.lable411,
                        ),
                        Gap(6),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to(SetDeliveryLocation());
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(40, 35),

                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              child: Text(
                                "Edit",
                                style: Styles.boldBlue612,
                              ),
                            ), TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(54, 0),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              child: Text(
                                "Delete",
                                style: Styles.boldBlue612,
                              ),
                            ), TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(35, 35),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              child: Text(
                                "Share",
                                style: Styles.boldBlue612,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(14),
            CustomButton(
              height: 40,
              borderCircular: 7,
              width: double.infinity,
              text: "ADD NEW ADDRESS",
              fun: () {
                Get.to(EnterNewAddressDetails());
              },
            )
          ],
        ),
      ),
    );
  }
}
