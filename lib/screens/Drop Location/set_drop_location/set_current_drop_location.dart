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

class SetCurrentDropLocation extends StatelessWidget {
  const SetCurrentDropLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Set Drop Location",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(
              "Top result in Surat",
              style: Styles.boldBlack716,
            ),
          ),
          Expanded(
            child: AnimatedList(
              initialItemCount: 25,
              shrinkWrap: true,
              itemBuilder: (context, index, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.DROPADDRESSDETAILS);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 14,vertical: 8),
                      padding: EdgeInsets.all(14),
                      decoration: ShapeDecoration.fromBoxDecoration(
                        BoxDecoration(
                          border: Border.all(color: primary),
                          color: white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppImage.LOCATION,color: primary,height: 14,width: 10,),
                              Gap(8),
                              Text(
                                "Ahmedabad",
                                style: Styles.boldBlack616,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              "Ahmedabad, Gujrat, India",
                              style: Styles.lable414,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
