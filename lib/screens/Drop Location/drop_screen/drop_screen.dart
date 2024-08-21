import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import '../../../constant/app_image.dart';
import '../../../constant/style.dart';
import '../../Pick Up Location/set_pick_up_location/set_pick_up_location_controller.dart';
import 'drop_screen_controller.dart';

var _con = Get.put(SetPickUpLocationController());

class DropScreen extends GetView<DropScreenController> {
  const DropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DropScreenController());
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(AppRoutes.HOMESCREEN);
        return  false;
      },
      child: Scaffold(
          backgroundColor: white,
          appBar: appbarSmall1(
            context,
            "Pick up or send Anything",
          ),
          body: GetBuilder<DropScreenController>(
            init: DropScreenController(),
            initState: (_) {},
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const Gap(16),
                  Container(
                    margin: const EdgeInsets.only(top: 0, left: 14, right: 14),
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Gap(10),
                            SvgPicture.asset(
                              AppImage.PACKAGE,
                              color: primary,
                            ),
                            const Gap(10),
                            Expanded(
                              child: Text(
                                "Pick up from ${controller.pickLoc.value}",
                                overflow: TextOverflow.ellipsis,
                                style: Styles.boldBlack612,
                              ),
                            ),
                            // Spacer(),
                            Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                onPressed: () {
                                  _con.selectLocationOnMap();
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 20),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  "Change",
                                  style: Styles.boldBlue612,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          "       ${controller.pickLoc.value}",
                          style: Styles.lable411,
                        ),
                        const Divider(
                          indent: 20,
                        ),
                        Text(
                          "      ${controller.pickName.value} ${controller.pickNumber.value}",
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
                  GestureDetector(
                    onTap: () {
                      if (controller.pickLoc.value.isNotEmpty) {
                        Get.toNamed(AppRoutes.SETDROPLOCATION);
                      } else {
                        DioExceptions.showMessage(
                            Get.context!, "please Enter PickUp Location");
                      }
                    },
                    child: _commonContainer(
                      color: primary,
                      txt: "Set Drop Location",
                      svgName: AppImage.ORDER,
                      style: Styles.boldWhite614,
                      svgColor: white,
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 18),
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
              );
            },
          )),
    );
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
