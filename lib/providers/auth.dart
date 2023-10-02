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

  Auth() {
  }
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
      final authRepository = Authentication();

      final response = await authRepository.signUp(email, fullname, password);



    if (response["data"] != null){
      final responseData = json.decode(response.body);
      print(responseData);
      notifyListeners();
    } else {
      print("hi2");
      // Handle the error
      print('Failed to post data: ${response.statusCode}');
      // throw HttpException(responseData['details']);
      return SnackBar(
          content: Text(
        'User already exists',
        style: GoogleFonts.nunito(
          fontSize: 16,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
          backgroundColor: Colors.red,
        ),
      ));
    }
  } catch(e) {
      print("hello");
      print("Error signing Up ${e.toString()}");

    }
    }

  // print('Post successful');

  Future resetPassword(String email, String password) async {
    print('>>>>>>email : ${email}');
    print('>>>>>>password : ${password}');
    // print('>>>>>>otp : ${Otp}');

    // final response = await authRepository.resetPassword(email, password);
    final response = await http.post(
      Uri.parse(
          'http://free-lunch.droncogene.com/api/v1/user/reset-password?email=$email&password=$password'),
      headers: <String, String>{
        'Content-Type': 'application/json;',
      },
    );

    final responseData = json.decode(response.body);
    // _token = responseData.access_token;
    print(responseData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      notifyListeners();
      return responseData;

      // print('Post successful');
    } else {
      // Handle the error
      print('Failed to post data: ${response.statusCode}');
    }
  }

  Future login(String email, String password) async {
    try {
      final response = await authRepository.signIn(email, password);

      final responseData = json.decode(response.body);
      print('ResponseDATA : >>>>>> $responseData');
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = responseData['data'];
        // Save the access token
        notifyListeners();
        if (data != null) {
          return "successsuccess";
        }
        await getUserProfile();
      } else {
        print('Failed to log in: ${response.statusCode}');
        return response
            .statusCode; // User is not valid (credentials are incorrect)
      }
    } catch (e) {
      print('Error logging in: $e');
      return "${e.toString()}";
    }
  }

  Future getUserProfile() async {
    try {
      final response = await http.get(
          Uri.parse('https://spitfire-openai.onrender.com/api/auth/@me'),
          headers: {
            'Cookie':
                'session=2597ffb6-c1cb-454f-a318-c1c53788571e.uxP4pogaa8d-L4tDWHCYvSkDpf0'
          });

      final responseData = json.decode(response.body);
      // _token = responseData.access_token;
      print(responseData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Save the user's name
        // // Retrieve the user's name
        final data = responseData['data']; // Ge
        print('>>>Admin when on home screen : ${data["is_admin"]}');
        // await setUserId(data["id"]);
        // await setAdmin(data["is_admin"] == true ? true : false);
        // await saveString("is_admin", data["is_admin"].toString());
        await setName(data["name"]);
        // await setPhoneNumber(data["phone_number"]);
        await setEmail(data["email"]);
        // await setLunchCreditBalance(int.parse(data["lunch_credit_balance"] ?? 1000));

        notifyListeners();
        if (data != null) {
          return "sucesssuccess";
        } else {
          return "";
        }

        // print('Post successful');
      } else {
        // Handle the error
        print('Failed to post data: ${response.statusCode}');
        // print(response.body);
        // throw HttpException(responseData['detail']);
        return "${response.statusCode}";
      }
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

  // Future requestWithdrawal(amount) async {
  //   String? access_token = await getString('token');
  //   print('>>>username accesstoken when on withdrawalScreen : $access_token');
  //   print('>>>user amount from form : $amount');
  //   if (amount <= 0) {
  //     throw Exception('Invalid amount: amount should greater than 0');
  //   }
  //   if (access_token != null) {
  //     final response = await http.post(
  //       Uri.parse('http://free-lunch.droncogene.com/api/v1/withdrawal/request'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json;',
  //         'Authorization': "Bearer $access_token",
  //       },
  //       body: jsonEncode(<String, String>{
  //         "amount": amount,
  //       }),
  //     );
  //
  //     final responseData = json.decode(response.body);
  //     // _token = responseData.access_token;
  //     print(responseData);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       // Save the user's name
  //       // // Retrieve the user's name
  //       final data = responseData['data']; // Ge
  //
  //       notifyListeners();
  //       return data;
  //     } else {
  //       // Handle the error
  //       print('Failed to post data: ${response.statusCode}');
  //     }
  //   }
  // }

  Future logout() async {
    try {
      final response = await authRepository.logout(email);


      final responseData = json.decode(response.body);
      print('ResponseDATA : >>>>>> $responseData');
      print(response.statusCode);

      if (response.statusCode == 200) {
        // Save the access token
        notifyListeners();
        if (responseData["message"] != null) {
          return "successsuccess";
        }
      } else {
        print('Failed to log in: ${response.statusCode}');
        return response
            .statusCode; // User is not valid (credentials are incorrect)
      }
    } catch (e) {
      print('Error logging in: $e');
      return "${e.toString()}";
    }
  }

  void _autoLogout() {}
}
