import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hng_authentication/authentication.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/models/http_exception.dart';
import '../utils/colors.dart';

//remember to change to with
class Auth extends ChangeNotifier {
  int? _userId;
  String? _email;
  String? _name;
   final authRepository = Authentication();


  get name => _name;
  get email => _email;

  int? get userId {
    return _userId;
  }

  Future<bool> setName(String value) async {
    _name = value;
    notifyListeners();
    return true;
  }

  Future<bool> setEmail(String value) async {
    _email = value;
    notifyListeners();
    return true;
  }

  Future<bool> setUserId(int value) async {
    _userId = value;
    notifyListeners();
    return true;
  }

  Future signUp(String fullname, String email, String password) async {

    try{
      final response = await authRepository.signUp(email, fullname, password);
      // if (response != null){
      print(response?.email);
      notifyListeners();
      return "successsuccess";
    // } else {
      print("hi2");
      // Handle the error
      // throw HttpException(responseData['details']);
      //return
      //   SnackBar(
      //     content: Text(
      //   'User already exists',
      //   style: GoogleFonts.nunito(
      //     fontSize: 16,
      //     color: AppColors.primary,
      //     fontWeight: FontWeight.w500,
      //     backgroundColor: Colors.red,
      //   ),
      // ));
   // }
  } catch(e) {
      print("Error signing Up ${e.toString()}");
      return "${e.toString()}";

    }
    }

  // print('Post successful');

  // Future resetPassword(String email, String password) async {
  //   print('>>>>>>email : ${email}');
  //   print('>>>>>>password : ${password}');
  //   // print('>>>>>>otp : ${Otp}');
  //
  //   // final response = await authRepository.resetPassword(email, password);
  //   final response = await http.post(
  //     Uri.parse(
  //         'http://free-lunch.droncogene.com/api/v1/user/reset-password?email=$email&password=$password'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json;',
  //     },
  //   );
  //
  //   final responseData = json.decode(response.body);
  //   // _token = responseData.access_token;
  //   print(responseData);
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     notifyListeners();
  //     return responseData;
  //
  //     // print('Post successful');
  //   } else {
  //     // Handle the error
  //     print('Failed to post data: ${response.statusCode}');
  //   }
  // }

  Future login(String email, String password) async {
    try {
      final response = await authRepository.signIn(email, password);
      // await getUserProfile();
      await setName(response.name);
      await setEmail(response.email);
        notifyListeners();

      return "successsuccess";
      // }
      // } else {
      //   print('Failed to log in: ${response.statusCode}');
      //   return response
      //       .statusCode; // User is not valid (credentials are incorrect)
      // }
    } catch ( e) {
      print('Error logging in: $e');
      return "${e.toString()}";
    }
  }

  Future getUserProfile() async {
    try {
      final response = await authRepository.getUser();

        print('>>>Admin when on home screen : ${response["name"]}');

        await setName(response["name"]);
        await setEmail(response["email"]);

        notifyListeners();


        // print('Post successful');

    } catch (e) {
      print('Error logging in: $e');
      return "${e.toString()}";
    }
  }

  saveString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  clearString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }



  Future logout() async {
    try {
      await authRepository.logout(email);
      notifyListeners();

    } catch (e) {
      print('Error logging in: $e');

      return "${e.toString()}";
    }
  }


}
