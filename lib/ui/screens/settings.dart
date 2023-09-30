import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator_ai/helpers/router.dart';
import 'package:translator_ai/ui/components/custom_button.dart';
import 'package:translator_ai/utils/colors.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 24),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.whiteColor, width: 2)),
                        child: Icon(
                          Icons.person,
                          size: 50,
                        )
                        // decoration: const BoxDecoration(
                        //     image: DecorationImage(
                        //         image: AssetImage('assets/images/account.png'))),
                        ),
                    Positioned(
                        bottom: -13,
                        right: -13,
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.whiteColor,
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.blackColor,
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "AbdulRasak Mubarak",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                "RasakMubarak09@gmail.com",
                style: TextStyle(fontSize: 20, color: AppColors.blackColor),
              ),
              CustomButton(
                  width: 80,
                  height: 80,
                  color: AppColors.blackColor,
                  content: "Edit Profile",
                  onTap: () {}),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: AppColors.primary,
                    // width: Sizer.screenWidth,
                    child: Text('Account',
                        style: TextStyle(
                            fontSize: 20, color: AppColors.blackColor)),
                  ),
                  SizedBox(height: 20),
                  SettingBox(
                    icon: Icons.lock,
                    text: "Forget Password",
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteHelper.forgotPasswordRoute);
                    },
                  ),
                  SettingBox(
                    icon: Icons.lock,
                    text: "Reset Password",
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteHelper.resetPasswordRoute);
                    },
                  ),
                  SettingBox(
                    icon: Icons.lock,
                    text: "FAQ",
                    onTap: () {},
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class SettingBox extends StatelessWidget {
  const SettingBox({
    Key? key,
    required this.icon,
    this.onTap,
    required this.text,
  }) : super(key: key);

  final Function()? onTap;
  final String text;
  final IconData icon; // Changed the type from String to IconData

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: Sizer.screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Row(
          children: [
            Icon(
              icon, // Pass the icon property to IconData constructor
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 20, color: AppColors.blackColor),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Icon(
              Icons.arrow_right,
              size: 24,
              color: AppColors.blackColor,
            )
          ],
        ),
      ),
    );
  }
}
