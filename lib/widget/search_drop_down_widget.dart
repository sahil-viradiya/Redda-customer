import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/style.dart';


class AddressSearchWidget extends StatelessWidget {
   final controller;
  final bool? readOnly;
  final void Function(String?)? onChanged;
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
  final Widget? suffixIconWidget;
  final IconData? icon;
  final Color? border;
  final GestureTapCallback? suffixTap;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? searchController;
  final int? minLine;
  final int? maxLine;
  final ValueChanged<String> onAddressSelected;

  const AddressSearchWidget({
    super.key,
    required this.controller, // Make the controller required
    required this.onAddressSelected,
    this.validator,
    this.hintText,
    this.searchController,
    this.hintStyle,
    this.onChanged,
    this.minLine,
    this.txtColor,
    this.icon,
    this.keyboardType,
    this.errorText,
    this.hintTpadding,
    this.suffixIconWidget,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          readOnly: readOnly ?? false,
          enabled: enable ?? true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: keyboardType,
          controller: searchController,
          decoration: InputDecoration(
            fillColor: fillColor ?? Colors.white,
            labelText: lblTxt,
            labelStyle: Styles.lable,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            isDense: true,
            prefixIcon: prefixIcon,
            errorText: errorText,
            prefixIconConstraints:
                BoxConstraints.loose(const Size.fromWidth(80)),
            isCollapsed: isCollapsed ?? false,
            suffixIcon: GestureDetector(
                onTap: suffixTap, child: suffixIconWidget ?? Icon(icon)),
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
          onChanged: (value) {
            controller.filterAddresses(value);
            onChanged?.call(value);
          },
          validator: validator,
        ),
        const Gap(4),
        Obx(() {
          if (controller.isListVisible.value) {
            return Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: controller.filteredAddresses.length,
                itemBuilder: (context, index) {
                  final address = controller.filteredAddresses[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      style: ListTileStyle.drawer,
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -4),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      title: Text(address.address),
                      onTap: () {
                        onAddressSelected(address.address);
                        controller.selectAddress(address);
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
