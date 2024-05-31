import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/validation.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/widget/app_text_field.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';

import 'drop_address_details_controller.dart';

class DropAddressDetailsScreen extends GetView<DropAddressDetailsController> {
  const DropAddressDetailsScreen({Key? key}) : super(key: key);

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
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: ListView(
            children: [
              Container(
                height: 160,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: primary),
                ),
              ),
              //=============Address================
              Gap(18),
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
                  return Validator.validateLastName(value!);
                }),
                // controller: signUpBloc.lnameCon,
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
                  "Sender’s Name",
                  style: Styles.boldBlack614,
                  textAlign: TextAlign.left,
                ),
              ),
              Gap(MySize.size4!),
              //=============Sender’s Mobile Number================

              CustomTextFormFieldWidget(
                keyboardType: TextInputType.name,
                validator: ((value) {
                  return Validator.validateLastName(value!);
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
                keyboardType: TextInputType.name,
                validator: ((value) {
                  return Validator.validateLastName(value!);
                }),
                // controller: signUpBloc.lnameCon,
                hintRpadding: 17.76,
              ),
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
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: CustomButton(
                        color: index < 1 ? Colors.white : primary,
                        height: 24,
                        borderSide: BorderSide(color: index > 1 ? Colors.white : primary,),
                        width: Get.width / 3.5,
                        borderCircular: 5,
                        text: text[index],
                        style: index < 1
                            ? Styles.boldBlue614
                            : Styles.boldWhite614,
                        fun: () {},
                      ),
                    );
                  },
                ),
              ),
              Gap(MySize.size10!),

              GestureDetector(
                onTap: () {
                },
                child: CustomButton(
                  width: double.infinity,
                  height: 35,
                  borderCircular: 7,
                  text: "Proceed",
                  fun: () {
                    Get.toNamed(AppRoutes.PICKUPORSENDANYTHING);

                  },
                ),
              ),
              Gap(MySize.size30!),

            ],
          ),
        ));
  }
}
