import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/address_details/address_details_controller.dart';

class AddressSearchWidget extends StatelessWidget {
  final bool? readOnly;
  final void Function(String?)? onchanged;
  final bool? enable;
  final String? errorText;
  final bool? isCollapsed;

  final double? borderRadius;
  final String? hintText;
  final String? lblTxt;
  final TextStyle? hintStyle;

  final double? hintTpadding;
  final double? hintLpadding;
  final double? hintRpadding;
  final Widget? prefixIcon;
  final double? hintBpadding;
  final Color? txtColor;
  final Color? fillColor;
  final Widget? sufixIconWidget;
  final IconData? icon;
  final Color? border;
  final GestureTapCallback? suffixTap;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  final int? minLine;
  final int? maxLine;
  final AddressDetailsController controller =
      Get.put(AddressDetailsController());
  final ValueChanged<String> onAddressSelected;

  AddressSearchWidget({
    super.key,
    required this.onAddressSelected,
    this.validator,
    this.hintText,
    this.hintStyle,
    this.onchanged,
    this.minLine,
    this.txtColor,
    this.icon,
    this.keyboardType,
    this.errorText,
    this.hintTpadding,
    this.sufixIconWidget,
    this.hintBpadding,
    this.border,
    this.hintRpadding,
    this.lblTxt,
    this.hintLpadding,
    this.fillColor,
    this.enable,
    this.maxLine,
    this.readOnly,
    this.prefixIcon,
    this.borderRadius,
    this.suffixTap,
    this.isCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                fillColor: fillColor ?? Colors.white,
                labelText: lblTxt,

                labelStyle: Styles.lable,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                filled: true,
                isDense: true,

                // suffixIconConstraints:
                //     BoxConstraints.loose(const Size.fromHeight(80)),
                prefixIcon: prefixIcon,
                errorText: errorText,

                prefixIconConstraints:
                    BoxConstraints.loose(const Size.fromWidth(80)),
                isCollapsed: isCollapsed ?? false,
                suffixIcon: GestureDetector(
                    onTap: suffixTap, child: sufixIconWidget ?? Icon(icon)),
                suffixStyle: const TextStyle(color: Colors.black),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8),
                  borderSide: BorderSide(
                    color: border ?? primary,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8),
                  borderSide: BorderSide(
                    color: border ?? primary,
                    width: 1.0,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8),
                  borderSide: BorderSide(
                    color: border ?? primary,
                    width: 1.0,
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  left: hintLpadding ?? 17.76,
                  top: hintTpadding ?? 0,
                  right: hintRpadding ?? 0.0,
                  bottom: hintBpadding ?? 0.0,
                ),

                hintText: hintText,
                hintStyle: hintStyle ?? Styles.hint412,
              ),
              controller:
                  TextEditingController(text: controller.searchQuery.value),
              onChanged: (value) {
                controller.filterAddresses(value);
              },
            )),
        Obx(() {
          if (controller.isListVisible.value) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.filteredAddresses.length,
              itemBuilder: (context, index) {
                final address = controller.filteredAddresses[index];

                return ListTile(
                  title: Text(address.address),
                  onTap: () {
                    // Pass the FetchAddressModel directly
                    onAddressSelected(address.address);
                    controller.selectAddress(address);
                  },
                );
              },
            );
          } else {
            return const SizedBox.shrink(); // Hide the list when not visible
          }
        }),
      ],
    );
  }
}
