import 'dart:developer';

import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/app_image.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/widget/app_text_field.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/search_location_on_map_for_drop_screen.dart';

import '../../../widget/custom_button.dart';
import '../../../widget/search_location_on_map_screen.dart';
import 'set_drop_location_controller.dart';

class SetDropLocationScreen extends GetView<SetDropLocationController> {
  const SetDropLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Set Drop Location",
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 14, right: 14),
        child: Column(
          children: [
            const Divider(),
            CustomTextFormFieldSearch(
              controller: controller.locationController,
              // readOnly: true,
              enable: true,

              hintLpadding: 10,
              width: double.infinity,
              hintText: "Search for building, area, or street",
              onchanged: (p0) {
                controller.onSearchChanged();
              },
            ),

            // const Gap(10),
            GestureDetector(
                onTap: () {
                  Get.to(() => const SearchLocationOnMapForDropScreen());
                },
                child: _commonContainer(
                    txt: "Use current Location",
                    svgName: AppImage.LOCATION2,
                    style: Styles.boldBlue614,
                    color: white)),
            const Gap(10),

            Expanded(
                child: Obx(
              () => AnimationList(
                children: List.generate(controller.suggestions.length, (index) {
                  var address = controller.suggestions[index];
                  return GestureDetector(
                    onTap: () {
                      log("selected location index ${controller.suggestions[index]['place_id']}");
                      controller.getLatLong(
                          controller.suggestions[index]['place_id']);
                      controller.locationController.text =
                          controller.suggestions[index]['description'];
                      controller.suggestions.clear();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Column(
                        children: [
                          const Gap(4),
                          Container(
                            width: double.infinity,
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 18,
                                      left: 0,
                                      bottom: 18,
                                      top: 18,
                                    ),
                                    child: Text(
                                      controller.suggestions[index]
                                          ['description'],
                                      style: Styles.boldBlack612,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(8),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            )),

            CustomButton(
              width: Get.width,
              // height: 35,
              borderCircular: 6,
              text: "Confirm Location",
              fun: () async {
                Get.toNamed(AppRoutes.DROPADDRESSDETAILS, arguments: [
                  controller.selectedDropLat.toString(),
                  controller.selectedDropLng.toString()
                ]);

                // await getAddress();
                // Get.toNamed(AppRoutes.ADDRESSDETAILS,arguments: [controller.selectedPlaceLat.value,controller.selectedPlaceLng.value]);
              },
            ),
            const Gap(30),
          ],
        ),
      ),
    );
  }

  _commonContainer(
      {Color? color,
      required String svgName,
      required String txt,
      TextStyle? style,
      Color? svgColor}) {
    return Container(
      height: 45,
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
          ),
          const Spacer(),
          SvgPicture.asset(
            AppImage.RIGHTARROW,
            color: svgColor,
          ),
        ],
      ),
    );
  }
}
