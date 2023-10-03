import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:translator_ai/helpers/router.dart';
import 'package:translator_ai/ui/components/custom_button.dart';
import 'package:translator_ai/utils/colors.dart';
import 'package:translator_ai/utils/size_calculator.dart';

import '../../../providers/auth.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isLoading = false;

  Future<String> _profile(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final authProvider = Provider.of<Auth>(context, listen: false);

    try {
      // Call the signUp method from your provider
      final userData = await authProvider.getUserProfile();
      setState(() {
        _isLoading = false;
      });
      if (userData == "successsuccess") {
        return "success";
      } else {
        return "";
      }
    } catch (error) {
      // Handle the error, e.g., show an error message
      print(error);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Something went wrong: $error'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        ),
      );
      return "${error.toString()}";
    }
  }

  Future<String> _submit(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final authProvider = Provider.of<Auth>(context, listen: false);

    try {
      // Call the signUp method from your provider
      final userData = await authProvider.logout();
      setState(() {
        _isLoading = false;
      });
      if (userData == "successsuccess") {
        return "success";
      } else {
        return "";
      }
    } catch (error) {
      // Handle the error, e.g., show an error message
      print(error);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Something went wrong: $error'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        ),
      );
      return "${error.toString()}";
    }
  }

  Future<void> getProfile() async {
    await _profile(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sizer(false, 30, context),
          ),
          child: Column(
            children: [
              SizedBox(
                height: sizer(false, 24, context),
              ),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: sizer(false, 80, context),
                      width: sizer(true, 80, context),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.whiteColor, width: 2)),
                      child: Image.asset("images/naruto.png"),
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
              SizedBox(
                height: sizer(false, 24, context),
              ),
              Text(
                "${authProvider.name}",
                // "Mubarak",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.blackColor),
              ),
              Text(
                "${authProvider.email}",
                // " mubarak@gmail.com",
                style: GoogleFonts.nunito(
                    fontSize: 14, color: AppColors.blackColor),
              ),
              SizedBox(
                height: sizer(false, 24, context),
              ),
              CustomButton(
                  height: sizer(false, 50, context),
                  width: sizer(true, 220, context),
                  color: AppColors.primary,
                  content: "Logout",
                  onTap: () async {
                    // Navigator.of(context).pushNamed(RouteHelper.loginRoute);
                    try {
                      final res = await _submit(context);
                      if (res == "success") {
                        Navigator.pushReplacementNamed(
                            context, RouteHelper.loginRoute);
                      } else {}
                    } catch (e) {
                      print("$e");
                    }
                  }),
              SizedBox(
                height: sizer(false, 34, context),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),

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
                    icon: Icons.chat,
                    text: "FAQ",
                    onTap: () {
                      Navigator.pushNamed(context, RouteHelper.faqRoute);
                    },
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
