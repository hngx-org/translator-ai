import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_ai/ui/screens/auth/onBoardingPage.dart';
import 'package:translator_ai/utils/colors.dart';

import '../../../utils/size_calculator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, () async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const OnBoardingScreen()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              height: AppConstants.screenHeight(context),
              width: AppConstants.screenWidth(context),
              color: AppColors.primary,
              // color: Colors.blueAccent,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome '
                    'to Language Chat',
                    style: GoogleFonts.nunito(
                      color: AppColors.whiteColor,
                      fontSize: sizer(true, 28, context),
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                      letterSpacing: 0.24,
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    radius: 150,
                    backgroundColor: AppColors.primaryLight,
                    child: SizedBox(
                        height: 150,
                        width: 150,
                        child: SvgPicture.asset("images/splash2.svg")),
                  ),
                  // Image.asset('images/splash3.png'),
                  const SizedBox(
                    height: 30,
                  ),


                  CircleAvatar(
                    radius: 80,
                    backgroundColor: AppColors.primaryLight,
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: SvgPicture.asset("images/splash3.svg")),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    'Breaking Language Barrier',
                    style: GoogleFonts.nunito(
                      color: AppColors.whiteColor,
                      fontSize: sizer(true, 23, context),
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                      letterSpacing: 0.24,
                    ),
                  ),
                ],
              ))),
    );
  }
}
