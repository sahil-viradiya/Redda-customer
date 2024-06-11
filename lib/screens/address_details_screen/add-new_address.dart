import 'package:animation_list/animation_list.dart';
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

import 'address_details_screen_controller.dart';

class AddNewAddress extends GetView<AddressController> {
   const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController controller = Get.put(AddressController());
    return GetBuilder<AddressController>(builder: (logic) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Addresses",
      ),
      body: Obx(
      () => controller.isLoading == true
      ? const Center(child: CircularProgressIndicator(color: primary,)):
      controller.getAddressModel!.data! ==null?noAddress(context)
          :  Column(
            children: [
              const Divider(),
              Expanded(
                child: AnimationList(children: List.generate(controller.getAddressModel!.data!.length, (index) {
                        var address = controller.getAddressModel!.data![index];
                        return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [

                    const Gap(10),
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
                                    controller.getAddressModel!.data![index].addressType.toString(),
                                    style: Styles.boldBlack612,
                                  ),
                                ),
                                Text(
                                  controller.getAddressModel!.data![index].address.toString(),
                                  style: Styles.lable411,
                                ),
                                Gap(6),
                                Text(
                                  "Mobile Number:  ${controller.getAddressModel!.data![index].mobileNo.toString()}",
                                  style: Styles.lable411,
                                ),
                                Gap(6),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Get.to(const SetDeliveryLocation());
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
                      }),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  height: 40,
                  borderCircular: 7,
                  width: double.infinity,
                  text: "ADD NEW ADDRESS",
                  fun: () {
                    Get.to(const EnterNewAddressDetails());
                  },
                ),
              )
            ],
          )
    ),); });
  }
}


Widget noAddress(BuildContext context) {
  return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(20),
          Text(
            "No Any address Added.---",
            style: Styles.boldBlack616,
          ),
          Text(
            "No Any address Added.Kindly add new address to below button.",
            style: Styles.lable414,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          CustomButton(
            height: 40,
            borderCircular: 7,
            width: double.infinity,
            text: "ADD NEW ADDRESS",
            fun: () {
              Get.to(AddNewAddress());
            },
          )
        ],
      ),
    );
}