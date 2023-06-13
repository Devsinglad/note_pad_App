
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String? val)? onchanged;
  final Function(String? val)? onsaved;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Color? fillColor;
  final EdgeInsetsGeometry? cPadding;
  final List<TextInputFormatter>? textInputFormatter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  bool obscureText = false;
  bool readonly = false;

  CustomTextFormField(
      {Key? key,
      this.validator,
      this.controller,
      this.textInputType,
      required this.obscureText,
      this.onchanged,
      this.onsaved,
      this.textInputAction,
      this.hintText,
      this.cPadding,
      this.textInputFormatter,
      required this.readonly,
      this.suffixIcon,
      this.prefixIcon,
      this.fillColor,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: textInputType,
        textAlign: textAlign ?? TextAlign.start,
        inputFormatters: textInputFormatter,
        textInputAction: textInputAction ?? TextInputAction.next,
        validator: validator,
        onChanged: onchanged,
        onSaved: onsaved,
        readOnly: readonly,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          contentPadding:
              cPadding, //?? const EdgeInsets.symmetric(horizontal: 10),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.white,
          ),
          fillColor: fillColor ?? Colors.white10,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.6)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.6)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          prefixIcon: prefixIcon,
          suffix: suffixIcon,
        ),
      ),
    );
  }
}