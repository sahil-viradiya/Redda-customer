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

import 'set_drop_location_controller.dart';


class SetDropLocationScreen extends GetView<SetDropLocationController> {
    const SetDropLocationScreen({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: white,
        appBar: appbarSmall1(
            context,
            "Set Drop Location",
        ),
        body: Column(
            children: [
                const Divider(),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: CustomTextFormFieldSearch(
                        prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.0),
                            child: Icon(Icons.search),
                        ),
                        hintLpadding: 10,
                        width: double.infinity,
                        hintText: "Search for building, area, or street",
                    ),
                ),
                const Gap(10),
                GestureDetector(
                    onTap: () {
                        Get.toNamed(AppRoutes.SETCURRENTDROPTLOCATION);
                    },
                    child: _commonContainer(
                        txt: "Use current Location",
                        svgName: AppImage.LOCATION2,
                        style: Styles.boldBlue614,
                        color: white))
            ],
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
