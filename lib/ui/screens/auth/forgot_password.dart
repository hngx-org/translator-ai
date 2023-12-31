import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_ai/helpers/router.dart';
import 'package:translator_ai/ui/components/custom_button.dart';
import 'package:translator_ai/utils/colors.dart';
import 'package:translator_ai/utils/size_calculator.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ),
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: sizer(false, 30, context)),
            child: Column(
              children: [
                Text(
                  "Forgot Your Password?",
                  style: GoogleFonts.nunito(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                ),
                SizedBox(height: sizer(false, 15, context)),
                Text(
                  "Enter the Email Address associated with your account",
                  style: GoogleFonts.nunito(
                      fontSize: sizer(true, 16, context),
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor),
                  maxLines: 3,
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: "Enter your email address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizer(false, 30, context),
                ),
                CustomButton(
                    width: sizer(true, 212, context),
                    // i have a question here
                    height: sizer(false, 50, context),
                    color: AppColors.primary,
                    content: "Verify Email",
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteHelper.passwordRecoveryRoute);
                    })
              ],
            ),
          ),
        ));
  }
}
