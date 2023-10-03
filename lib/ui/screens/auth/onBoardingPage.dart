import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_ai/helpers/router.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_calculator.dart';
import '../../components/custom_button.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),

                  SizedBox(
                    child: Text(
                      'Your multi-lingual companion',
                      style: GoogleFonts.nunito(
                        color: AppColors.blackColor,
                        fontSize: sizer(true, 25, context),
                        fontWeight: FontWeight.w700,
                        height: 1.0,
                        letterSpacing: 0.24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Hello',
                        style: GoogleFonts.nunito(
                          color: Colors.green,
                          fontSize: sizer(true, 17, context),
                          fontWeight: FontWeight.w700,
                          height: 1.0,
                          letterSpacing: 0.24,
                        ),
                      ),
                      Text(
                        'Bonjour',
                        style: GoogleFonts.nunito(
                          color: Colors.red,
                          fontSize: sizer(true, 17, context),
                          fontWeight: FontWeight.w700,
                          height: 1.0,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 200,
                      width: 200,
                      child: SvgPicture.asset("images/onboard4.svg")),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        ' Ndịnụọma',
                        style: GoogleFonts.nunito(
                          color: AppColors.primary,
                          fontSize: sizer(true, 17, context),
                          fontWeight: FontWeight.w700,
                          height: 1.0,
                          letterSpacing: 0.24,
                        ),
                      ),
                      Text(
                        'Ẹ kú àárọ́',
                        style: GoogleFonts.nunito(
                          color: AppColors.blackColor,
                          fontSize: sizer(true, 17, context),
                          fontWeight: FontWeight.w700,
                          height: 1.0,
                          letterSpacing: 0.24,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 60,
                  ),

                  // const SizedBox(height: 20,),
                  // const Text(
                  //   'Your Multilingual Companion.',
                  //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(
                  //   height:20,
                  // ),
                  // const Text('Get Started Now!!!',style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold),),
                  // const SizedBox(height: 30,),

                  const Text(
                    'Get Started Now!!!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: AppColors.text1,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                      width: sizer(true, 313, context),
                      height: 51,
                      singleBigButton: true,
                      isTextBig: false,
                      color: AppColors.primary,
                      content: 'Create an Account',
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RouteHelper.signUpRoute);
                      }),
                  SizedBox(
                    height: 60,
                  ),
                  CustomButton(
                      width: sizer(true, 313, context),
                      height: 51,
                      singleBigButton: true,
                      isTextBig: false,
                      color: AppColors.primary,
                      content: 'Login',
                      onTap: () {
                        Navigator.of(context).pushNamed(RouteHelper.loginRoute);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
