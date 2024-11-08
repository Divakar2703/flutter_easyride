import 'package:flutter/material.dart';

class CabTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Color? fillColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final String? lableText;
  final onTab;
  final onChange;

  const CabTextFormField({
    Key? key,
    this.controller,
    this.onChange,
    this.onTab,
    this.hintText,
    this.fillColor = Colors.transparent,
    this.fontSize,
    this.fontWeight,
    this.textColor = Colors.black,
    this.borderColor = Colors.blue,
    this.keyboardType,
    this.obscureText = false,
    this.maxLength,
    this.onChanged,
    this.validator,
    this.lableText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: fillColor,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor!),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor!),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor!, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Poppins',
          fontWeight: fontWeight ?? FontWeight.w400,
          color: textColor,
        ),
      ),
    );
  }
}
