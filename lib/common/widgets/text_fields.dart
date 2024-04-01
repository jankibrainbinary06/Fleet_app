import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/fonts.dart';
import 'package:new_project/utils/string_res.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    this.hintText,
    this.isNumberPlat,
    this.controller,
    this.isSuffixIcon,
    this.onSuffixTap,
    this.isVisible,
    this.borderRadius,
    this.inputType,
    this.isReadOnly,
    this.onTap,
    this.onChanged,
    this.focusNode,
    this.suffixIcon,
  });
  final String? hintText;
  final bool? isVisible;
  final bool? isNumberPlat;
  final VoidCallback? onSuffixTap;
  final TextEditingController? controller;
  final bool? isSuffixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;
  final TextInputType? inputType;
  final bool? isReadOnly;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType ?? TextInputType.visiblePassword,
      controller: controller,
      obscureText: isVisible ?? false,
      readOnly: isReadOnly ?? false,
      onTap: onTap,
      onChanged: onChanged,
      focusNode: focusNode,
        inputFormatters:((isNumberPlat ?? false) ==true) ?[
          UpperCaseTextFormatter(),
        ]:[],
maxLength: (isNumberPlat ?? false) ==true?10:null,
      style: const TextStyle(
          color: ColorRes.black, fontSize: 16, fontFamily: Fonts.medium),
      decoration: InputDecoration(
          hintMaxLines: 1,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          filled: true,
          hintText: hintText ?? "",
          suffixIcon: isSuffixIcon == true
              ? suffixIcon ??
                  GestureDetector(
                    onTap: onSuffixTap,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(right: 15, top: 13),
                      child: Text(
                        isVisible ?? true ? Strings.show : Strings.hide,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: ColorRes.appPrimary,
                            fontSize: 16,
                            fontFamily: Fonts.medium),
                      ),
                    ),
                  )
              : const SizedBox(),
          hintStyle: const TextStyle(
            color: ColorRes.cBDBDBD,
            fontSize: 15.5,
            fontFamily: Fonts.medium,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: ColorRes.cE8E8E8),
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: ColorRes.cE8E8E8),
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: ColorRes.cE8E8E8),
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: ColorRes.cE8E8E8),
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          fillColor: ColorRes.cF6F6F6),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}