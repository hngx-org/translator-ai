import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/size_calculator.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String content;
  final VoidCallback onTap;
  final bool isTextBig, singleBigButton;
  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.content,
    required this.onTap,
    this.isTextBig = true,
    this.singleBigButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 60,
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            // side: const BorderSide(width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          // shadows: const [
          //   BoxShadow(
          //     color: Colors.black,
          //     blurRadius: 0,
          //     offset: Offset(2, 2),
          //     spreadRadius: 0,
          //   ),
          // ],
        ),
        child: Center(
          child: Text(
            content,
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: isTextBig
                  ? 14
                  : singleBigButton
                      ? sizer(true, 15, context)
                      : 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
