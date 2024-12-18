import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/app_image.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'pick_up_controller.dart';

class PickUpScreen extends GetView<PickUpController> {
  const PickUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.SETPICKUPLOCATION);
              },
              child: _commonContainer(
                txt: "Set pick up Location",
                svgName: AppImage.PACKAGE,
                style: Styles.boldWhite614,
              ),
            ),

            _commonVerticalDivider(),
            const Gap(8),
            _commonVerticalDivider(),
            const Gap(8),

            _commonVerticalDivider(),
            const Gap(8), _commonVerticalDivider(),
            const Gap(8),
            _commonVerticalDivider(),
            const Gap(8),

            _commonVerticalDivider(),
            // Gap(8),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.DROPSCREEN);
              },
              child: _commonContainer(
                color: Colors.transparent,
                txt: "Set Drop Location",
                svgName: AppImage.ORDER,
                style: Styles.boldBlue614,
                svgColor: primary,
              ),
            ),

            const Gap(38),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Things to keep in mind",
                style: Styles.boldBlack716,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: primary),
              ),
              child: Column(
                children: [
                  _commonRow(
                      image: AppImage.INVENTORY,
                      txt: "Avoid sending expensive or fraglie items "),
                  const Gap(14),
                  _commonRow(
                      image: AppImage.BOX,
                      txt: "Items should fit in a backpack"),
                  const Gap(14),
                  _commonRow(
                      image: AppImage.NODRINKS,
                      txt: "No alcohol, illegal or restricted items"),
                  const Gap(14),
                  _commonRow(
                      image: AppImage.WATCH,
                      txt: "Avoid sending expensive or fraglie items"),
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                // height: 50,
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
                      "Delivery Charges",
                      style: Styles.lable414,
                    ),
                    const Gap(6),
                    Row(
                      children: [
                        SvgPicture.asset(AppImage.HEAT),
                        const Gap(6),
                        Text(
                          "Starting at \$50 for first 2 kms",
                          style: Styles.boldBlack614,
                        ),
                        const Gap(12),
                        SvgPicture.asset(AppImage.INFO),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  _commonContainer(
      {Color? color,
      required String svgName,
      required String txt,
      TextStyle? style,
      Color? svgColor}) {
    return Container(
      margin: const EdgeInsets.only(top: 0, left: 14, right: 14),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: primary),
        color: color ?? primary,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            svgName,
            color: svgColor,
          ),
          const Gap(10),
          Text(
            txt,
            style: style,
          )
        ],
      ),
    );
  }

  _commonRow({required String image, required String txt}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(image),
        const Gap(10),
        Expanded(
            child: Text(
          txt,
          style: Styles.lable414,
        )),
      ],
    );
  }

  _commonVerticalDivider() {
    return Container(
      margin: const EdgeInsets.only(top: 0, left: 38, right: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: primary,
      ),
      height: 5.5,
      width: 3.2,
      // margin: CustomPaddings.horizontal(),
    );
  }
}
