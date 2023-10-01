import 'package:flutter/material.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset('images/splash.jpeg'),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Your Passport To Global Communication ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // const Text('Get Started Now!!!',style: TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.bold),),
                          // const SizedBox(height: 30,),
                          const Text(
                            'Your Multilingual Companion.',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Get Started Now!!!',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomButton(
                              width: sizer(true, 213, context),
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
                            height: 30,
                          ),
                          CustomButton(
                              width: sizer(true, 213, context),
                              height: 51,
                              singleBigButton: true,
                              isTextBig: false,
                              color: AppColors.primary,
                              content: 'Login',
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RouteHelper.loginRoute);
                              }),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
