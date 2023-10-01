import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_ai/ui/components/bottom_navigator.dart';

import '../../../helpers/router.dart';
import '../../../utils/colors.dart';
import '../../../utils/size_calculator.dart';
import '../../components/custom_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool _issecured = true;

  bool _isLoading = false; // Track loading state

  String? _validateEmail(String? email) {
    RegExp emailRegex =
    RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
    final isEmailvalid = emailRegex.hasMatch(email ?? '');
    if (!isEmailvalid || email == "") {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 23,
              color: Color.fromRGBO(89, 51, 8, 1),
            ),
          );
        },
      ),
      centerTitle: true,
      title: Text(
        'Sign In',
        style: GoogleFonts.nunito(
          color: const Color(0xFF583208),
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 1.0,
          letterSpacing: 0.24,
        ),
      ),
    ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Please ensure that you provide accurate information in this form to avoid any hiccups in this process. ',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.35,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Work Email Address",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // search box
                TextFormField(
                  autovalidateMode:
                  AutovalidateMode.onUserInteraction,
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailcontroller,
                  showCursor: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Please enter your email address',
                    hintStyle: TextStyle(
                      fontSize: sizer(true, 16, context),
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: _issecured,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordcontroller,
                  showCursor: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Please enter your password',
                    hintStyle: TextStyle(
                      fontSize: sizer(true, 16, context),
                      fontWeight: FontWeight.w500,
                    ),
                    suffixIcon: togglepassword(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  autovalidateMode:
                  AutovalidateMode.onUserInteraction,
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null; // Return null when there are no validation errors.
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context)
                          .pushNamed(RouteHelper.forgotPasswordRoute);
                    },
                    child:  InkWell(
                      child:  const Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito',
                            color: AppColors.blackColor),
                      ),
                      onTap: (){
                        Navigator.of(context)
                            .pushNamed(RouteHelper.forgotPasswordRoute);                        // );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    width: 150,
                    height: 51,
                    singleBigButton: true,
                    isTextBig: false,
                    color: AppColors.primary,
                    content: 'Sign In',
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteHelper.home);

                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget togglepassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _issecured = !_issecured;
        });
      },
      icon: _issecured ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
      color: const Color.fromRGBO(0, 0, 0, 1),
    );
  }
}
