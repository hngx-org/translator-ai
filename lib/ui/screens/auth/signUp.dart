import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../helpers/router.dart';
import '../../../providers/auth.dart';
import '../../../utils/colors.dart';
import '../../../utils/size_calculator.dart';
import '../../components/bottom_navigator.dart';
import '../../components/custom_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _passwordVisible;
  var _confirmPasswordVisible;
  bool isLoading = false;

  var EmailController = TextEditingController();
  var FullNameController = TextEditingController();
  var PasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  bool selected = true;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  String? _validateEmail(String? email) {
    RegExp emailRegex =
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
    final isEmailvalid = emailRegex.hasMatch(email ?? '');
    if (!isEmailvalid || email == "") {
      return 'Please enter a valid email';
    }
    return null;
  }

  Future<void> _submit(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final authProvider = Provider.of<Auth>(context, listen: false);

    try {
      // Get the email and password from the input fields
      final email =
          EmailController.text; // Get the email from your TextFormField
      final password =
          PasswordController.text; // Get the password from your TextFormField
      final fullname = FullNameController.text;
      final confirmPassword =
          confirmPasswordController.text; // Get the first name

      // Call the signUp method from your provider
      await authProvider.signUp(fullname, email, password);
      setState(() {
        isLoading = false;
      });
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
    }
  }

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
                color: AppColors.primary,
              ),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: GoogleFonts.nunito(
            color: AppColors.primary,
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
            child: Form(
              key: _formkey,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Enter your personal details. ',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.35,
                              color: const Color.fromRGBO(0, 0, 0, 1),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Full Name",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a value'; // Error message to display
                            }
                            return null; // Return null if the input is valid
                          },
                          controller: FullNameController,
                          decoration: InputDecoration(
                              hintText: "Please enter your FullName",
                              hintStyle: TextStyle(
                                  fontSize: sizer(true, 16, context),
                                  fontWeight: FontWeight.w500),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // SizedBox(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Text(
                  //         "Last Name",
                  //         style: TextStyle(
                  //             fontSize: 16, fontWeight: FontWeight.w600),
                  //       ),
                  //       const SizedBox(
                  //         height: 10,
                  //       ),
                  //       TextFormField(
                  //         validator: (value) {
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter a value'; // Error message to display
                  //           }
                  //           return null; // Return null if the input is valid
                  //         },
                  //         controller: LastnameController,
                  //         decoration: InputDecoration(
                  //             hintText: "Please enter your last name",
                  //             hintStyle: TextStyle(
                  //                 fontSize: sizer(true, 16, context),
                  //                 fontWeight: FontWeight.w500),
                  //             border: const OutlineInputBorder(
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(15)))),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email Address",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: EmailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a value'; // Error message to display
                            }
                            _validateEmail(value);
                            return null; // Return null if the input is valid
                          },
                          decoration: InputDecoration(
                              hintText: "Please enter your email address",
                              hintStyle: TextStyle(
                                  fontSize: sizer(true, 16, context),
                                  fontWeight: FontWeight.w500),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Password",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            final passwordPattern =
                                r'^(?=.*[0-9])(?=.*[\W_]).{8,}$';
                            final passwordRegex = RegExp(passwordPattern);

                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            } else if (!passwordRegex.hasMatch(value)) {
                              return 'Password must match requirement.';
                            }
                            return null; // Return null if the input is valid
                          },
                          controller: PasswordController,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                              hintText: "Please enter your password",
                              hintStyle: TextStyle(
                                  fontSize: sizer(true, 16, context),
                                  fontWeight: FontWeight.w500),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //     'Password must be at least 8 characters long, contain at least one number and one special character',
                        //     style: GoogleFonts.nunito(
                        //         fontSize: sizer(true, 13, context),
                        //         color: const Color.fromARGB(255, 119, 42, 196),
                        //         fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Confirm Password",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a value'; // Error message to display
                            }
                            if (value != PasswordController.text) {
                              return 'Passwords do not match';
                            }
                            return null; // Return null if the input is valid
                          },
                          obscureText: !_confirmPasswordVisible,
                          decoration: InputDecoration(
                              hintText: "Please re-enter your password",
                              hintStyle: TextStyle(
                                  fontSize: sizer(true, 16, context),
                                  fontWeight: FontWeight.w500),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _confirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _confirmPasswordVisible =
                                        !_confirmPasswordVisible;
                                  });
                                },
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text(
                        //   "Phone number",
                        //   style: TextStyle(
                        //       fontSize: 16, fontWeight: FontWeight.w600),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // TextFormField(
                        //   keyboardType: TextInputType.phone,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter a value'; // Error message to display
                        //     }
                        //     return null; // Return null if the input is valid
                        //   },
                        //   controller: PhoneController,
                        //   decoration: InputDecoration(
                        //       hintText: "Please enter your phone number",
                        //       hintStyle: TextStyle(
                        //           fontSize: sizer(true, 16, context),
                        //           fontWeight: FontWeight.w500),
                        //       border: const OutlineInputBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(15)))),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: CustomButton(
                              width: sizer(true, 213, context),
                              height: 51,
                              singleBigButton: true,
                              isTextBig: false,
                              color: AppColors.primary,
                              content: 'Sign Up',
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RouteHelper.loginRoute);
                                // _submit(context);
                              }),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
