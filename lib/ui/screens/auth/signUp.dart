import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_calculator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool selected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 23,
                  color: Color.fromRGBO(89, 51, 8, 1),
                ),
              );
            },
          ),
          centerTitle: true,
          title: Text(
            'Sign Up',
            style: GoogleFonts.nunito(
              color: const Color(0xFF583208),
              fontSize: sizer(true, 24, context),
              fontWeight: FontWeight.w700,
              height: 1.0,
              letterSpacing: 0.24,
            ),
          ),
        ),
        body: SafeArea(
            child: GestureDetector(
                onTap: () {
                  // Dismiss the keyboard when the user taps on the screen
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        child: const Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [],
                          ),
                        ]))))));
  }
}
