import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/constant.dart';
import 'package:redda_customer/Utils/validation.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/screens/address_details_screen/address_details_screen_controller.dart';
import 'package:redda_customer/widget/app_text_field.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';
import 'package:redda_customer/widget/location.dart';

class EnterNewAddressDetails extends GetView<AddressController> {

  const EnterNewAddressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    List text = ["Home", "Work", "Other"];
    return Scaffold(
        backgroundColor: white,
        appBar: appbarSmall1(
          context,
          "Enter Address Details",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: ListView(
            children: [
              Container(
                height: 160,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: primary),
                ),
                child: const GetLocationScreen(),
              ),
              //=============Address================
              const Gap(18),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "House / Flat / Block No.",
                  style: Styles.boldBlack614,
                  textAlign: TextAlign.left,
                ),
              ),
              Gap(MySize.size4!),

              CustomTextFormFieldWidget(
                controller: controller.house,
                keyboardType: TextInputType.name,
                validator: ((value) {
                  return Validator.validateLastName(value!);
                }),
                hintRpadding: 17.76,
              ),
              Gap(MySize.size12!),
              //=============Landmark================
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Appartment / Road / Area",
                  style: Styles.boldBlack614,
                  textAlign: TextAlign.left,
                ),
              ),
              Gap(MySize.size4!),
              CustomTextFormFieldWidget(
                controller: controller.area,
                keyboardType: TextInputType.name,
                validator: ((value) {
                  return Validator.validateLastName(value!);
                }),
                // controller: signUpBloc.lnameCon,
                hintRpadding: 17.76,
              ),
              //=============Sender's Name================

              Gap(MySize.size12!),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Direction to reach",
                  style: Styles.boldBlack614,
                  textAlign: TextAlign.left,
                ),
              ),
              Gap(MySize.size4!),
              //=============Sender’s Mobile Number================

              CustomTextFormFieldWidget(
                controller: controller.direction,
                maxLine: 5,
                minLine: 5,
                keyboardType: TextInputType.name,
                validator: ((value) {
                  return Validator.validateLastName(value!);
                }),
                // controller: signUpBloc.lnameCon,
                hintRpadding: 17.76,
              ),
              // Gap(MySize.size!),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: primary,
                    visualDensity: const VisualDensity(horizontal: -4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                              ?
                          Styles.boldBlack614
                              :
                          Styles.boldWhite614,
                          fun: () {
                            controller.selectedIndex.value = index;
                            controller.addressType.value = text[index];
                            print("--------------------->${controller.addressType.value}");
                          },
                        );
                      }),
                    );
                  },
                ),
              ),
              Gap(MySize.size16!),

              GestureDetector(
                onTap: () {},
                child: CustomButton(
                  width: double.infinity,
                  height: 35,
                  borderCircular: 7,
                  text: "Add Address",
                  fun: () {
                    //getToken();
                    controller.addAddress();
                  },
                ),
              ),
              Gap(MySize.size30!),
            ],
          ),
        ));
  }
}
