import 'package:bayoum_store_app/helper/fontthemes.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.onTap,
  });

  final String text;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: screenWidth,
          height: screenHeight,
          child: Center(
            child: Text(text, style: CustomFontStyle.veryLarg),
          ),
        ),
      ),
    );
  }
}
