import 'package:flutter/material.dart';

import 'Mytext.dart';



class CustomBtn extends StatelessWidget {
  const CustomBtn({
    Key? key,
    this.title,
    this.buttonColor,
    this.textColor,
    this.onPressed,
    this.borderColor,
    this.height,
    this.width,
    this.radius,
    this.font,
  }) : super(key: key);

  final String? title;
  final Color? buttonColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final Color? borderColor;
  final BorderRadius? radius;
  final TextStyle? font;

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: buttonColor ?? Colors.white,
            borderRadius: radius ?? BorderRadius.circular(20.6),
            border: Border.all(color: borderColor ?? Colors.transparent)),
        child: Center(
          child: MyText(
            title: title ?? '',
            align: TextAlign.center,
          ),
        ),
      ),
    );
  }
}