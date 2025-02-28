import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easy_ride/utils/colors.dart';

class CommonTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextInputType? keyBoardType;
  final TextEditingController? con;
  final bool? readOnly;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final bool? isDense;
  final Function()? onEditingComplete;
  final Function(String)? onChanged;
  final String? labelText;
  final Widget? suffix;
  final Color? suffixColor;
  final Color? fillColor;
  final void Function()? suffixOnTap;
  final Widget? prefixIcon;
  final double? constraintHeight;
  final TextStyle? labelStyle;
  final String? hintText;
  final String? headerLabel;
  final TextStyle? hintStyle;
  final InputBorder? focusedBorder;
  final TextStyle? style;
  final double? borderRadius;
  final Color? borderColor;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  CommonTextField({
    super.key,
    this.keyBoardType,
    this.con,
    this.validator,
    this.readOnly,
    this.onTap,
    this.inputFormatters,
    this.obscureText,
    this.isDense,
    this.onEditingComplete,
    this.onChanged,
    this.labelText,
    this.suffix,
    this.suffixColor,
    this.fillColor,
    this.suffixOnTap,
    this.prefixIcon,
    this.constraintHeight,
    this.labelStyle,
    this.hintText,
    this.headerLabel,
    this.hintStyle,
    this.focusedBorder,
    this.style,
    this.borderRadius,
    this.borderColor,
    this.border,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerLabel != null) ...[
          Text(
            headerLabel ?? "",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 5),
        ],
        TextFormField(
          controller: con,
          keyboardType: keyBoardType,
          validator: validator,
          readOnly: readOnly ?? false,
          onTap: onTap,
          enabled: true,
          obscureText: obscureText ?? false,
          inputFormatters: inputFormatters,
          cursorColor: AppColors.yellow,
          cursorErrorColor: Colors.red,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: style,
          decoration: InputDecoration(
            fillColor: fillColor,
            contentPadding: contentPadding,
            filled: fillColor != null ? true : false,
            constraints: BoxConstraints(maxHeight: constraintHeight ?? double.infinity),
            isDense: true,
            hintText: hintText,
            hintStyle: hintStyle,
            labelStyle: labelStyle,
            labelText: labelText,
            prefixIcon: prefixIcon,
            focusedBorder: border ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.yellow),
                  borderRadius: BorderRadius.circular(borderRadius ?? 10),
                ),
            enabledBorder: border ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor ?? AppColors.black.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(borderRadius ?? 10),
                ),
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10)),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10)),
            suffixIcon: suffix != null
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(onTap: suffixOnTap, child: suffix),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
