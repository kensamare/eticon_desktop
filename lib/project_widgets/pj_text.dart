import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PjText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;

  const PjText(
      {Key? key, required this.text, this.color, this.fontSize = 14, this.fontWeight, this.height}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: color,
        fontSize: fontSize!,
        height: height
      ),
    );
  }
}
  