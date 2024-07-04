import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/set_pick_up_location/set_pick_up_location_controller.dart';

import 'package:redda_customer/widget/app_text_field.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';

class SetCurrentLocation extends GetView<SetPickUpLocationController> {
  const SetCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Set pick up Location",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: GestureDetector(
              onTap: () {},
              child: const CustomTextFormFieldSearch(
                enable: false,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: Icon(Icons.search),
                ),
                hintLpadding: 10,
                width: double.infinity,
                hintText: "Search for building, area, or street",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
