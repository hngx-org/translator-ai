import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_ai/helpers/router.dart';
import 'package:translator_ai/ui/components/custom_button.dart';
import 'package:translator_ai/utils/colors.dart';
import 'package:translator_ai/utils/size_calculator.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizer(false, 30, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sizer(false, 100, context),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: sizer(false, 16, context)),
                child: Text(
                  "Verification Code",
                  style: GoogleFonts.nunito(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor),
                ),
              ),
              SizedBox(
                height: sizer(false, 16, context),
              ),
              // const VSpace(4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Enter the code sent to your email address to reset your password",
                  // style: AppTypography.text16,
                ),
              ),
              SizedBox(
                height: sizer(false, 16, context),
              ),
              OtpCodeInput(),

              SizedBox(
                height: sizer(false, 16, context),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                      width: 220,
                      height: 50,
                      color: AppColors.primary,
                      content: "Continue",
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RouteHelper.resetPasswordRoute);
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

class OtpCodeInput extends StatefulWidget {
  @override
  _OtpCodeInputState createState() => _OtpCodeInputState();
}

class _OtpCodeInputState extends State<OtpCodeInput> {
  List<String> otp = List.filled(6, '');

  void _updateOtp(int index, String value) {
    setState(() {
      otp[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            onChanged: (value) {
              _updateOtp(index, value);
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).nextFocus();
              }
            },
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
