import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hng_authentication/authentication.dart';
import 'package:hngx_openai/repository/openai_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator_ai/ui/components/bottom_navigator.dart';
import 'package:translator_ai/ui/components/loader/overlayLoader.dart';

import '../core/models/http_exception.dart';
import '../ui/components/chat_message.dart';
import '../utils/colors.dart';

//remember to change to with
class Auth extends ChangeNotifier {
  int? _userId;
  String? _email;
  String? _name;
  String? _fromLanguage = "English";
  String? _toLanguage = "French";
  String? _translated_message;
  int? _credits;
  List<ChatMessage> _messages = [];
  List<ChatMessage> _translated = [];
  bool _isLoading = false;

  final authRepository = Authentication();
  final openAI = OpenAIRepository();

  get name => _name;
  get email => _email;
  get fromLanguage => fromLanguage;
  get toLanguage => toLanguage;
  // get translatedMessage => _translated_message;
  get credits => _credits;
  get translated => _translated;
  get messages => _messages;
  get isLoading => _isLoading;
  // get countLen => _translated.length;
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

  Future reduceSetCredits() async {
    _credits = credits - 1;
    notifyListeners();
  }

  Future setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> setTranslatedMessage(String value) async {
    _translated.insert(
        0,
        ChatMessage(
          text: value,
          isMe: false,
          language: _toLanguage!,
        ));
    // _translated_message = value;
    notifyListeners();
    return true;
  }

  Future<bool> setMessage(String value) async {
    _messages.insert(
        0, ChatMessage(text: value, isMe: true, language: _fromLanguage!));
    // _translated_message = value;
    notifyListeners();
    return true;
  }

  Future<bool> setUserId(int value) async {
    _userId = value;
    notifyListeners();
    return true;
  }

  Future<bool> setfromLanguage(String value) async {
    _fromLanguage = value;
    notifyListeners();
    return true;
  }

  Future<bool> settoLanguage(String value) async {
    _toLanguage = value;
    notifyListeners();
    return true;
  }

  Future<bool> setCredits(int value) async {
    _credits = value;
    notifyListeners();
    return true;
  }

  Future signUp(String fullname, String email, String password) async {
    try {
      final response = await authRepository.signUp(email, fullname, password);
      // if (response != null){
      print(response?.email);
      _messages = [];
      _translated = [];
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
    } catch (e) {
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
      await setCredits(response.credits);
      await saveString("cookie", response.cookie);
      notifyListeners();

      return "successsuccess";
      // }
      // } else {
      //   print('Failed to log in: ${response.statusCode}');
      //   return response
      //       .statusCode; // User is not valid (credentials are incorrect)
      // }
    } catch (e) {
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

  // clearString(String key) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove(key);
  // }
  //
  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  String extractSessionToken(String inputString) {
    // Define a regular expression pattern to match the session token
    RegExp regex = RegExp(r'session=([^;]+)');

    // Use the firstMatch method to find the first match in the input string
    Match? match = regex.firstMatch(inputString);

    // Check if a match was found
    if (match != null) {
      // Extract the captured group (session token)
      String sessionToken = match.group(1)!;
      return sessionToken;
    } else {
      // Return an empty string or handle the absence of a session token as needed
      return "";
    }
  }

  Future generatePrompt(context, String userInput) async {
    LoadingOverlay.of(context).show();

    String? cookie = await getString("cookie");
    print(",,,,,,cookie1 $cookie");
    String session = extractSessionToken(cookie!);
    session = "session=$session";
    print(",,,,,,cookie2 $session");
    print(",,,,,,fromLanguage $_fromLanguage");
    print(",,,,,,toLanguage $_toLanguage");

    String prompt =
        "Translate the following $_fromLanguage text to $_toLanguage : $userInput";
    print(",,,,,,prompt $prompt");

    try {
      final response = await openAI.getChat(prompt, session!);
      List<String> parts = response.split(':');
      if (response.startsWith('M')) {
        if (parts.length == 2) {
          String message = parts[1].trim();
          print("${message}");
          reduceSetCredits();
          // await setTranslatedMessage(message);

          notifyListeners();

          return message;
        }
      } else {
        print("errrrrrrrrrrrrr${response}");
        // reduceSetCredits();
        // await setTranslatedMessage(message);
        // LoadingOverlay.of(context).hide();
        notifyListeners();

        return response;
      }
    } catch (e) {
      // LoadingOverlay.of(context).hide();

      showSnackbar(context, Colors.red, e.toString());
      return "hiiii${e.toString()}";
    }
  }

  Future logout() async {
    try {
      await authRepository.logout(email);

      notifyListeners();
      return "successsuccess";
    } catch (e) {
      print('Error logging out: $e');

      return "${e.toString()}";
    }
  }
}
