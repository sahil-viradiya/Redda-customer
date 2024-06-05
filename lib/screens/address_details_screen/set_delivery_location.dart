import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/screens/Drop%20Location/payment/payment_controller.dart';
import 'package:redda_customer/screens/address_details_screen/enter_new_address_details.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';
import '../../../constant/app_image.dart';
import '../../../constant/style.dart';

class SetDeliveryLocation extends StatelessWidget {
  const SetDeliveryLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Select delivery Location",
      ),
      body: Stack(
          alignment: Alignment.bottomCenter,

        children: [
          Container(height: Get.height,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            height: 120,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                const BoxShadow(
                  blurRadius: 8,
                  spreadRadius: 4,
                  color: Colors.black12,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppImage.LOCATION2),
                    Gap(6),
                    Expanded(
                      child: Text(
                        "Varachha",
                        style: Styles.boldBlack612,
                      ),
                    ),
                    Text(
                      "Change",
                      style: Styles.boldBlue612,
                    ),
                  ],
                ),
           
                Text("varachha, Surat, Gujrat, India",style: Styles.lable414,),
                Gap(12),
                CustomButton(
                  width: Get.width,
                  height: 35,
                  borderCircular: 6,
                  text: "Confirm Location",
                  fun: () {
                    Get.to(EnterNewAddressDetails());
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
