import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/router.dart';
import '../../utils/colors.dart';
import '../../utils/size_calculator.dart';
import '../components/custom_button.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent(
      {Key? key,
      this.title,
      this.description,
      this.imageSrc,
      this.dataLength,
      this.currentIndex})
      : super(key: key);
  final String? title, imageSrc, description;
  final int? dataLength;
  final double? currentIndex;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return const SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

            ],
          ),
        ),
      ),
    );
  }
}
