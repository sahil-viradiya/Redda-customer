import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/screens/Drop%20Location/drop_address_details/drop_address_details_controller.dart';
import 'package:redda_customer/screens/Drop%20Location/drop_screen/drop_screen_controller.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';
import '../../../constant/app_image.dart';
import '../../../constant/style.dart';
import '../../../widget/poly_line.dart';
import 'pick_or_send_any_controller.dart';

class PickOrSendAnyScreen extends GetView<PickOrSendAnyController> {
  const PickOrSendAnyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dropScreenCon = Get.put(DropScreenController());
    final controller = Get.put(PickOrSendAnyController());
    final DropAddressDetailsController dropAddScreenCon = Get.find();
    final PickOrSendAnyController picOrSendAny = Get.find();
    final data = Get.arguments ?? {};
    // log("final location ${arguments}");
    return Scaffold(
        backgroundColor: white,
        appBar: appbarSmall1(
          context,
          "Pick up or send Anything",
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            const Gap(16),
            Container(
              margin: const EdgeInsets.only(top: 0, left: 14, right: 14),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: white,
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Gap(10),
                      SvgPicture.asset(
                        AppImage.PACKAGE,
                        color: primary,
                      ),
                      const Gap(10),
                      Text(
                        "Pick up from ${dropScreenCon.pickLoc.value}",
                        style: Styles.boldBlack612,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Change",
                          style: Styles.boldBlue612,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "       ${dropScreenCon.pickLoc.value}",
                    style: Styles.lable411,
                  ),
                  const Divider(
                    indent: 20,
                  ),
                  Text(
                    "      ${dropScreenCon.pickName.value} ${dropScreenCon.pickNumber.value}",
                    style: Styles.lable411,
                  )
                ],
              ),
            ),
            // _commonVerticalDivider(),
            const Gap(8),
            // _commonVerticalDivider(),
            const Gap(8),
            //
            // _commonVerticalDivider(),
            // Gap(8), _commonVerticalDivider(),
            // Gap(8),
            // _commonVerticalDivider(),
            // Gap(8),
            //
            // _commonVerticalDivider(),
            // Gap(8),
            Container(
              margin: const EdgeInsets.only(top: 0, left: 14, right: 14),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: white,
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Gap(10),

                      SvgPicture.asset(
                        AppImage.ORDER,
                        color: primary,
                      ),
                      const Gap(10),
                      Text(
                        "Deliver to ${dropAddScreenCon.rideDetailsModel.value.addressType} ",
                        style: Styles.boldBlack612,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Change",
                          style: Styles.boldBlue612,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "       ${dropAddScreenCon.rideDetailsModel.value.reciverAddress}",
                    style: Styles.lable411,
                  ),
                  const Divider(
                    indent: 20,
                  ),
                  Text(
                    "      ${dropAddScreenCon.rideDetailsModel.value.reciverName ?? ""} ${dropAddScreenCon.rideDetailsModel.value.reciverMobileNo ?? ""}",
                    style: Styles.lable411,
                  )
                ],
              ),
            ),
            const Gap(38),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Obx(() => Row(
                      children: [
                        Text(
                          "Distance -",
                          style: Styles.lable614,
                        ),
                        Text(
                          " ${dropAddScreenCon.tempRideMdel.value.totalDistance} km", //distance.toStringAsFixed(2)} km
                          style: Styles.boldBlack614,
                        ),
                        const Spacer(),
                        Text(
                          "Dlivery in -",
                          style: Styles.lable614,
                        ),
                        Text(
                          " ${dropAddScreenCon.tempRideMdel.value.totalTime} mins",
                          style: Styles.boldBlack614,
                        )
                      ],
                    ))),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 230,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: primary),
                ),
                child: GetLocationPolyLineScreen(
                  dropLat:
                      double.tryParse(data['dropLat']?.toString() ?? '0.0') ??
                          0.0,
                  dropLng:
                      double.tryParse(data['dropLng']?.toString() ?? '0.0') ??
                          0.0,
                  pickLat: dropScreenCon.pickLat.value.toDouble(),
                  pickLng: dropScreenCon.pickLng.value.toDouble(),
                ),
              ),
            ),

            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              height: 125,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 4,
                    color: Colors.black12,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Estimated Pick up in ${dropAddScreenCon.tempRideMdel.value.totalTime} mins",
                    style: Styles.boldBlack614,
                  ),
                  const Gap(6),
                  Text(
                    "${dropAddScreenCon.tempRideMdel.value.totalDistance} kms | Delivery in ${dropAddScreenCon.tempRideMdel.value.totalTime} mins",
                    style: Styles.lable414,
                  ),
                  const Gap(6),
                  Obx(() {
                    return CustomButton(
                      isLoading: controller.isLoading.value,
                      width: Get.width,
                      height: 35,
                      borderCircular: 6,
                      text: "Checkout",
                      fun: () {
                        Get.toNamed(AppRoutes.CHECKOUT);

                        // controller.ride();
                      },
                    );
                  })
                ],
              ),
            )
          ],
        ));
  }
}
