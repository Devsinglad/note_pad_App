
import 'package:flutter/material.dart';

Widget MyText({
  final String? title,
  final TextAlign? align,
  final FontWeight? weight,
  final TextOverflow? textOverflow,
  final int? maxLines,
  final double? fontSize,
  final Function()? onTap,
  final Color? color,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Text(
      title!,
      style:
          TextStyle(
            fontSize: fontSize??15.49,
            color: color,
            fontWeight: FontWeight.w500,
          ),
      textAlign: align,
      overflow: textOverflow,
      maxLines: maxLines,
      softWrap: true,
    ),
  );
}