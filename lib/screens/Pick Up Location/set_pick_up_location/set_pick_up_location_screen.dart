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
import 'set_pick_up_location_controller.dart';

class SetPickUpLocationLocation extends GetView<SetPickUpLocationController> {
  const SetPickUpLocationLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Set pick up Location",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            const Divider(),

            GestureDetector(
                onTap: () {
                  // Get.toNamed(AppRoutes.SETCURRENTLOCATION);
                  controller.selectLocationOnMap();

                },
                child: _commonContainer(
                    txt: "Use current Location",
                    svgName: AppImage.LOCATION2,
                    style: Styles.boldBlue614,
                    color: white)),
            const Gap(10),

             CustomTextFormFieldSearch(
               controller: controller.controller,
               // readOnly: true,
               enable: true,
               // prefixIcon: Padding(
               //   padding: EdgeInsets.symmetric(horizontal: 14.0),
               //   child: Icon(Icons.search),
               // ),
               hintLpadding: 10,
               width: double.infinity,
               hintText: "Enter Manual Location",
               onchanged: (p0) {
                 controller.onSearchChanged();
               },
             ),
            Expanded(
              child: Obx(() => AnimationList(children: List.generate(controller.suggestions.length, (index) {
                var address = controller.suggestions[index];
                return Padding(
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
                                padding: const EdgeInsets.only(right: 18,left: 0,bottom: 18,top: 18,
                                    ),
                                child: Text(
                                  controller.suggestions[index]['description'],
                                  style: Styles.boldBlack612,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(8),
                      /*CustomButton(
                      height: 40,
                      borderCircular: 7,
                      width: double.infinity,
                      text: "ADD NEW ADDRESS",
                      fun: () {
                        Get.to(const EnterNewAddressDetails());
                      },
                    )*/
                    ],
                  ),
                );
              }),),)
            ),
          /*  Expanded(
              child: Obx(() => Card(
                elevation: 5,
                child: ListView.builder(
                  itemCount: controller.suggestions.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(controller.suggestions[index]['description']),
                          onTap: () {
                            // Handle place selection
                          },
                        ),
                        Divider(color: primary,),
                      ],
                    );
                  },
                ),
              ),),
            ),*/
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
      // margin: const EdgeInsets.only(top: 0, left: 14, right: 14),
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
