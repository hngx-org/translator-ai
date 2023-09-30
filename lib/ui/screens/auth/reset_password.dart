import 'package:flutter/material.dart';
import 'package:translator_ai/ui/components/custom_button.dart';
import 'package:translator_ai/utils/colors.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                'Reset Password',
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ),
              const SizedBox(height: 15),
              const Text(
                'Now you can reset your new password',
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor),
              ),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'New Password',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _confirmNewPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm New Password',
                ),
              ),
              SizedBox(height: 16.0),
              const SizedBox(height: 20),
              CustomButton(
                  width: 12,
                  // i have a question here
                  height: 12,
                  color: AppColors.blackColor,
                  content: "Reset Password",
                  onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
