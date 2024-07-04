import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/app_image.dart';
import 'package:redda_customer/constant/font-family.dart';
import 'package:redda_customer/constant/my_size.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/model/transcation_history_model.dart';
import 'package:redda_customer/screens/wallet/wallet_controller.dart';
import 'package:redda_customer/screens/Drop%20Location/payment/payment_controller.dart';
import 'package:redda_customer/screens/auth/signIn/signIn_controller.dart';
import 'package:redda_customer/widget/app_text_field.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';

class WalletScreen extends GetView<WalletController> {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(context, "Wallet"),
      body: GetBuilder<WalletController>(
        init: WalletController(),
        initState: (_) {},
        builder: (_) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _withdrawCard(context),
                Gap(MySize.size18!),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Transaction ',
                    style: Styles.boldBlue615,
                  ),
                ),
                Obx(() => controller.isLoading.value == true
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height / 5),
                          child: const CircularProgressIndicator(
                            color: primary,
                          ),
                        ),
                      )
                    : controller.transcationHistoryModel.isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: Get.height / 5),
                              child: Text(
                                "Data Is Empty",
                                style: Styles.boldBlue716,
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(12),
                              itemCount:
                                  controller.transcationHistoryModel.length,
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) =>
                                  AnimationConfiguration.staggeredList(
                                position: index,
                                delay: const Duration(milliseconds: 100),
                                child: SlideAnimation(
                                  duration: const Duration(milliseconds: 2500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  verticalOffset: -250,
                                  child: ScaleAnimation(
                                    duration:
                                        const Duration(milliseconds: 2500),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: transcationWallet(
                                        context,
                                        controller
                                            .transcationHistoryModel[index]),
                                  ),
                                ),
                              ),
                            ),
                          ))
              ]);
        },
      ),
    );
  }

  _withdrawCard(BuildContext context) {
    final SignInController signInController = Get.find();

    return Stack(
      children: [
        // Main Container
        Obx(() => Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(20),
              width: MySize.safeWidth,
              height: MySize.size186,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFC19F4E), // Start color
                    Color(0xFFDEC587), // End color
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Total Revenue',
                        style: Styles.boldWhite414,
                      ),
                      const Spacer(),
                      Text(
                        'Hello, ${signInController.model.fullname}',
                        style: Styles.boldWhite614,
                      ),
                    ],
                  ),
                  Gap(MySize.size5!),
                  Text(
                    "\$ ${controller.walletBalanceModel.value.customerWallet ?? 0.0}",
                    style: Styles.white720,
                  ),
                  Gap(MySize.size35!),
                  // Add your other widgets here if needed
                ],
              ),
            )),
        // Bottom Container
        Positioned(
          left: 12,
          right: 12,
          bottom: 12,
          child: InkWell(
            onTap: () => _deliver(context, controller),
            child: Container(
              height: MySize.size50,
              decoration: const BoxDecoration(
                color: primary, // Assuming primary is defined somewhere
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Center(
                  child: Text(
                "Deposite",
                textAlign: TextAlign.center,
                style: Styles.boldWhite414,
              )),
            ),
          ),
        ),
      ],
    );
  }
}

Widget transcationWallet(context, TranscationHistoryModel model) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
    margin: const EdgeInsets.only(bottom: 6),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${model.transactionId}',
              style: Styles.boldBlack612,
            ),
            Gap(MySize.size6!),
            Text(
              "${model.type}",
              style: Styles.noramalBlack411,
            ),
          ],
        ),
        Text(
          "+ \$${model.amount}",
          style: TextStyle(
            color: green,
            fontSize: 12,
            fontFamily: FontFamily.primary,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ),
  );
}

void _deliver(BuildContext context, WalletController controller) {
  final PaymentController paymentController = Get.put(PaymentController());

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        // actionsPadding: const EdgeInsets.all(0),
        insetPadding: const EdgeInsets.all(10),

        backgroundColor: white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        // title: const Text("Start Delivery"),
        child: Container(
          margin: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: primary),
              borderRadius: BorderRadius.circular(7)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(10),
              SvgPicture.asset(AppImage.GOOGLEPAY),
              const Gap(14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Enter Amount for deposite",
                  style: Styles.boldBlack612,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomTextFormFieldWidget(
                  controller: controller.amountController,
                  keyboardType: TextInputType.number,
                ),
              ),
              const Divider(),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    height: 38,
                    width: 100,
                    borderCircular: 6,
                    text: "Pay Now",
                    style: Styles.boldwhite714,
                    fun: () {
                      Navigator.of(context).pop(); // Close the dialog

                      paymentController.openCheckout(
                          rs: controller.amountController.text.toString());
                    },
                  ),
                  const Gap(12),
                  CustomButton(
                    height: 38,
                    width: 100,
                    color: const Color(0xFFE5E5E5),
                    borderCircular: 6,
                    text: "Back",
                    style: Styles.boldBlack714,
                    fun: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              ),
              const Gap(20)
            ],
          ),
        ),
      );
    },
  );
}
