import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/validation.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/screens/Drop%20Location/drop_screen/drop_screen_controller.dart';
import 'package:redda_customer/widget/app_text_field.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';

import '../../../widget/location.dart';
import 'drop_address_details_controller.dart';

class DropAddressDetailsScreen extends GetView<DropAddressDetailsController> {
  DropAddressDetailsScreen({super.key});

  final _formKey = GlobalKey<FormState>();
    
  @override
  Widget build(BuildContext context) {
    final List<dynamic>? arguments = Get.arguments;

   double latitude = double.parse(arguments?[0]?.toString() ?? '0.0');
    double longitude = double.parse(arguments?[1]?.toString() ?? '0.0');

    List text = ["Home", "Work", "Other"];
    Get.put(DropAddressDetailsController());
    return Scaffold(
        backgroundColor: white,
        appBar: appbarSmall1(
          context,
          "Enter Address Details",
        ),
        body: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: GetBuilder<DropAddressDetailsController>(
                init: DropAddressDetailsController(),
                initState: (_) {},
                builder: (_) {
                  return ListView(children: [
                    Container(
                      height: 160,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: primary),
                      ),
                      child:  GetLocationScreen(lat: latitude, lng: longitude,),
                    ),
                    //=============Address================
                    const Gap(18),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Enter Address",
                        style: Styles.boldBlack614,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Gap(MySize.size4!),

                    CustomTextFormFieldWidget(
                      keyboardType: TextInputType.name,
                      validator: ((value) {
                        return Validator.validateAddress(value!);
                      }),
                      controller: controller.dropAddCon,
                      hintRpadding: 17.76,
                    ),
                    Gap(MySize.size12!),
                    //=============Landmark================
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Landmark (Optional)",
                        style: Styles.boldBlack614,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Gap(MySize.size4!),
                    CustomTextFormFieldWidget(
                      keyboardType: TextInputType.name,
                      controller: controller.dropLandCon,
                      hintRpadding: 17.76,
                    ),
                    //=============Sender's Name================

                    Gap(MySize.size12!),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Reciver’s Name",
                        style: Styles.boldBlack614,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Gap(MySize.size4!),
                    //=============Sender’s Mobile Number================

                    CustomTextFormFieldWidget(
                      keyboardType: TextInputType.name,
                      validator: ((value) {
                        return Validator.senderName(value!);
                      }),
                      controller: controller.dropSenderCon,
                      hintRpadding: 17.76,
                    ),
                    Gap(MySize.size12!),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Reciver’s Mobile Number",
                        style: Styles.boldBlack614,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Gap(MySize.size4!),
                    CustomTextFormFieldWidget(
                      keyboardType: TextInputType.phone,
                      validator: ((value) {
                        return Validator.validateMobile(value!);
                      }),
                      controller: controller.dropMobileCon,
                      hintRpadding: 17.76,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: primary,
                          visualDensity: const VisualDensity(horizontal: -4),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          side: const BorderSide(color: primary),
                          value: true,
                          onChanged: (bool? value) {},
                        ),
                        Text(
                          ' Add to Saved Address ',
                          style: Styles.hint610,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 34,
                      // width:
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // controller.selectedIndex.value = index;
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Obx(() {
                              return CustomButton(
                                color: controller.selectedIndex.value == index
                                    ? primary
                                    : Colors.white,
                                height: 24,
                                borderSide: const BorderSide(
                                  color: primary,
                                ),
                                width: Get.width / 3.5,
                                borderCircular: 5,
                                text: text[index],
                                style: controller.selectedIndex.value != index
                                    ? Styles.boldBlack614
                                    : Styles.boldWhite614,
                                fun: () {
                                  controller.selectedIndex.value = index;
                                  controller.addressType.value = text[index];
                                  print(
                                      "--------------------->${controller.addressType.value}");
                                },
                              );
                            }),
                          );
                        },
                      ),
                    ),
                    Gap(MySize.size16!),

                    Obx(() => CustomButton(
                          isLoading: controller.isLoading.value,
                          width: double.infinity,
                          height: 35,
                          borderCircular: 7,
                          text: "Proceed",
                          fun: () {
                            if (_formKey.currentState!.validate()) {
                              DropScreenController dropScreenCon = Get.find();

                              controller
                                  .tempRide(
                                      pickLat: dropScreenCon.pickLat.value,
                                      pickLng: dropScreenCon.pickLng.value,
                                      pickUpAddress:
                                          dropScreenCon.pickLoc.value,
                                      senderLandMark:
                                          dropScreenCon.pickLand.value,
                                      senderName: dropScreenCon.pickName.value,
                                      senderMobileNo:
                                          dropScreenCon.pickNumber.value,
                                      dropLat: controller.dropLat.value,
                                      dropLng: controller.dropLng.value,
                                      reciverAddress:
                                          controller.dropAddCon.text,
                                      reciverLandmark:
                                          controller.dropLandCon.text,
                                      reciverName:
                                          controller.dropSenderCon.text,
                                      reciverMobileNo:
                                          controller.dropMobileCon.text,
                                      addressType: controller.addressType.value)
                                  .then((val) {
                                Get.toNamed(AppRoutes.PICKUPORSENDANYTHING,
                                    arguments: {
                                      'dropAdd': controller.dropAddCon.text,
                                      'dropLand': controller.dropLandCon.text,
                                      'dropSend': controller.dropSenderCon.text,
                                      'dropMobile':
                                          controller.dropMobileCon.text,
                                      'dropLat':
                                          controller.dropLat.value.toString(),
                                      'dropLng':
                                          controller.dropLng.value.toString(),
                                      'addresStatus':
                                          controller.addressType.value
                                    });
                              });
                            }
                          },
                        )),
                    Gap(MySize.size30!),
                  ]);
                },
              )),
        ));
  }
}
