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
import 'add_new_card_controller.dart';

class AddNewCardScreen extends GetView<AddNewCardController> {
  const AddNewCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: appbarSmall1(
          context,
          "Add New Card",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
          child: Column(children: [
            const Divider(),
            const Gap(20),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Card Number",
                style: Styles.boldBlack614,
                textAlign: TextAlign.left,
              ),
            ),
            Gap(MySize.size6!),
            CustomTextFormFieldWidget(
              controller: TextEditingController(text: ""),
              validator: ((value) {
                return Validator.validateFirstName(value!);
              }),
              // controller: loginBloc.usernameCon,
              hintRpadding: 17.76,
              lblTxt: '',
            ),
            Gap(MySize.size12!),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Valid Through (MM/YY) ",
                style: Styles.boldBlack614,
                textAlign: TextAlign.left,
              ),
            ),
            Gap(MySize.size6!),
            Gap(MySize.size6!),
            CustomTextFormFieldWidget(
              controller: TextEditingController(text: ""),
              validator: ((value) {
                return Validator.validateFirstName(value!);
              }),
              // controller: loginBloc.usernameCon,
              hintRpadding: 17.76,
              lblTxt: '',
            ),
            Gap(MySize.size12!),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "CVV",
                style: Styles.boldBlack614,
                textAlign: TextAlign.left,
              ),
            ),
            Gap(MySize.size6!),
            CustomTextFormFieldWidget(
              controller: TextEditingController(text: ""),

              validator: ((value) {
                return Validator.validateFirstName(value!);
              }),
              // controller: loginBloc.usernameCon,
              hintRpadding: 17.76,
              lblTxt: '',
            ),
            Gap(MySize.size12!),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Name on Card",
                style: Styles.boldBlack614,
                textAlign: TextAlign.left,
              ),
            ),
            Gap(MySize.size6!),
            CustomTextFormFieldWidget(
              controller: TextEditingController(text: ""),

              validator: ((value) {
                return Validator.validateFirstName(value!);
              }),
              // controller: loginBloc.usernameCon,
              hintRpadding: 17.76,
              lblTxt: '',
            ),
            Gap(MySize.size12!),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Card Nickname",
                style: Styles.boldBlack614,
                textAlign: TextAlign.left,
              ),
            ),
            Gap(MySize.size6!),
            CustomTextFormFieldWidget(
              controller: TextEditingController(text: ""),

              validator: ((value) {
                return Validator.validateFirstName(value!);
              }),
              // controller: loginBloc.usernameCon,
              hintRpadding: 17.76,
              lblTxt: '',
            ),
            Gap(MySize.size12!),
            CustomButton(
              text: "Proceed",
              fun: () {
                Get.toNamed(AppRoutes.LINKACCOUNTSCREEN);
              },
              borderCircular: 7,
              width: double.infinity,

            height: 40,)
          ]),
        ));
  }
}
