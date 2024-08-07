import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/validation.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/widget/app_text_field.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';
import 'package:redda_customer/widget/location.dart';
import 'package:redda_customer/widget/search_drop_down_widget.dart';
import 'address_details_controller.dart';

class AddressDetailsScreen extends GetView<AddressDetailsController> {
  AddressDetailsScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final AddressDetailsController addressController =
      Get.put(AddressDetailsController());

  // Future<List> fetchData() async {
  //   await Future.delayed(const Duration(milliseconds: 3000));
  //   List list = [];
  //   // String inputText = myController.text;
  //   List jsonList = [
  //     {'label': '$inputText Item 1', 'value': 30},
  //     {'label': '$inputText Item 2', 'value': 31},
  //     {'label': '$inputText Item 3', 'value': 32},
  //   ];
  //   // create a list of 3 objects from a fake json response
  //   list.add(TestItem.fromJson(jsonList[0]));
  //   list.add(TestItem.fromJson(jsonList[1]));
  //   list.add(TestItem.fromJson(jsonList[2]));
  //   return list;
  // }

  @override
  Widget build(BuildContext context) {
    final List<dynamic>? arguments = Get.arguments;
    double latitude = double.parse(arguments?[0]?.toString() ?? '0.0');
    double longitude = double.parse(arguments?[1]?.toString() ?? '0.0');
    return Scaffold(
        backgroundColor: white,
        appBar: appbarSmall1(
          context,
          "Enter Address Details",
        ),
        body: GetBuilder<AddressDetailsController>(
          init: AddressDetailsController(),
          initState: (_) {},
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _map(latitude, longitude),
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
                      //==============
                      AddressSearchWidget(
                        controller: addressController,
                        searchController: controller.searchCon,
                        onAddressSelected: (value) {
                          log("selected val $value");
                          FocusScope.of(context).unfocus();
                        },
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
                        controller: addressController.landCon,
                        keyboardType: TextInputType.name,

                        // controller: signUpBloc.lnameCon,
                        hintRpadding: 17.76,
                      ),
                      //=============Sender's Name================

                      Gap(MySize.size12!),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Sender’s Name",
                          style: Styles.boldBlack614,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Gap(MySize.size4!),
                      //=============Sender’s Mobile Number================

                      CustomTextFormFieldWidget(
                        controller: addressController.sendersName,
                        keyboardType: TextInputType.name,
                        validator: ((value) {
                          return Validator.senderName(value!);
                        }),
                        // controller: signUpBloc.lnameCon,
                        hintRpadding: 17.76,
                      ),
                      Gap(MySize.size12!),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Sender’s Mobile Number",
                          style: Styles.boldBlack614,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Gap(MySize.size4!),
                      CustomTextFormFieldWidget(
                        controller: addressController.sendersMobileNo,
                        keyboardType: TextInputType.number,
                        validator: ((value) {
                          return Validator.validateMobile(value!);
                        }),
                        // controller: signUpBloc.lnameCon,
                        hintRpadding: 17.76,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() => Checkbox(
                                activeColor: primary,
                                visualDensity:
                                    const VisualDensity(horizontal: -4),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                side: const BorderSide(color: primary),
                                value: controller.saveAddressValue.value,
                                onChanged: (bool? value) {
                                  controller.saveAddressValue.value = value!;
                                },
                              )),
                          Text(
                            ' Add to Saved Address ',
                            style: Styles.hint610,
                          ),
                        ],
                      ),
                      Gap(MySize.size4!),

                      CustomButton(
                        width: double.infinity,
                        height: 35,
                        borderCircular: 7,
                        text: "Proceed",
                        fun: () {
                          // controller.addAddress();
                          print(latitude);
                          if (_formKey.currentState!.validate()) {
                            if (controller.saveAddressValue.value) {
                              controller.saveAddress();
                            }
                            Get.offNamedUntil('/drop_screen',
                                (Route<dynamic> route) => route.isFirst,
                                arguments: {
                                  'address': controller.searchCon.text,
                                  'landmark': controller.landCon.text,
                                  'senderName': controller.sendersName.text,
                                  'senderMo': controller.sendersMobileNo.text,
                                  'lat': latitude,
                                  'lng': longitude,
                                });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  Container _map(double latitude, double longitude) {
    return Container(
      height: 160,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primary),
      ),
      child: GetLocationScreen(
        lat: latitude,
        lng: longitude,
      ),
    );
  }
}
