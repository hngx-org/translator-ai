import 'dart:async';

import 'package:flutter/material.dart';
import 'package:translator_ai/ui/screens/auth/onBoardingPage.dart';
import 'package:translator_ai/utils/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
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

      body: Container(
          padding: const EdgeInsets.all(20),
          // height: 876,
          color: AppColors.primaryLight,
          // color: Colors.blueAccent,

          child: Center(
              child: Column(
            children: [
              const SizedBox(height: 250,),
              const Text('Welcome to Language Chat',style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold),),
              const SizedBox(height: 30,),
              Image.asset('images/splash3.png'),
              const SizedBox(height: 30,),
              const Text('Breaking language barriers',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400),)

            ],
          ))),
    );
  }
}
