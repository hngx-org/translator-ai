import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hngx_openai/repository/openai_repository.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/languages.g.dart';
import 'package:provider/provider.dart';
import 'package:translator_ai/ui/components/loader/overlayLoader.dart';
import 'package:translator_ai/ui/screens/bottom_nav_bar/Subscription.dart';
import '../../helpers/router.dart';
import '../../providers/auth.dart';
import '../../utils/colors.dart';
import '../../utils/size_calculator.dart';
import '../components/chat_message.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<ChatMessage> _messages = [];
  List<ChatMessage> _translated = [];

  List<String> translated = [];
  Language toLanguage = Languages.french;
  Language fromLanguage = Languages.english;
  late LanguagePickerDropdownController controllerFrom;
  late LanguagePickerDropdownController controllerTo;
  String translatedText = "";
  int counter = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerFrom = LanguagePickerDropdownController(fromLanguage);
    controllerTo = LanguagePickerDropdownController(toLanguage);
    // setMessages();
  }

  void setMessages() {
    final authProvider = Provider.of<Auth>(context, listen: false);
    _messages = authProvider.messages;
    _translated = authProvider.translated;
  }

  Future _sendPrompt(BuildContext context, text, Auth authProvider) async {
    // print("${authProvider.translated}");

    try {
      final response = await authProvider.generatePrompt(context, text);

      // setState(() {
      //   translatedText = response;
      //   _translated.insert(0, ChatMessage(text: response, isMe: false,));
      // });
      await authProvider.setTranslatedMessage(response);
      authProvider.setLoading(false);
      LoadingOverlay.of(context).hide();
      setState(() {});
      print(">>>list2 ${authProvider.translated}");
    } catch (e) {}
  }

  Future<void> _handleSubmittedMessage(String text, Auth authProvider) async {
    if (text.isNotEmpty) {
      _messageController.clear();
      // setState(() {
      //
      // });

      // setState(() {
      //   _messages.insert(0, ChatMessage(text: text, isMe: true,));
      //   counter++;
      // });
      authProvider.setMessage(text);
      authProvider.setLoading(true);

      print(">>>list1 ${authProvider.messages}");
      LoadingOverlay.of(context).show();
      await _sendPrompt(context, text, authProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "images/splash2.svg",
              ),
            ),
            Text(
              'Translate',
              style: GoogleFonts.nunito(
                color: AppColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.0,
                letterSpacing: 0.24,
              ),
            ),
            SizedBox(
              width: 30,
            )
          ],
        )),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(7)),
                    child: LanguagePickerDropdown(
                        initialValue: controllerFrom.value,
                        controller: controllerFrom,
                        onValuePicked: (Language language) {
                          authProvider.setfromLanguage(language.name);
                          setState(() {
                            fromLanguage = language;
                            controllerFrom.value = language;
                          });
                        }),
                  ),
                  IconButton(
                    onPressed: () async {
                       authProvider
                          .setfromLanguage(controllerTo.value.name.toString());
                       authProvider
                          .settoLanguage(controllerFrom.value.name.toString());
                      setState(() {
                        var temp = controllerFrom.value;
                        controllerFrom.value = controllerTo.value;
                        fromLanguage = controllerTo.value;
                        controllerTo.value = temp;
                        toLanguage = temp;
                      });

                    },
                    icon: const Icon(
                      Icons.compare_arrows_sharp,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                  Container(
                    width: 150,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(7)),
                    child: LanguagePickerDropdown(
                        initialValue: controllerTo.value,
                        controller: controllerTo,
                        onValuePicked: (Language language) {
                          authProvider.settoLanguage(language.name);
                          setState(() {
                            toLanguage = language;
                            controllerTo.value = language;
                          });
                        }),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: authProvider.messages.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      authProvider.messages[index],

                      // ( index + 1  > authProvider.translated.length && index == 0)
                      //     ? SizedBox(
                      //         height: 50,
                      //         width: 50,
                      //         child: CircularProgressIndicator(
                      //           color: AppColors.primary,
                      //         ),
                      //       )
                      //     : authProvider.translated[index],
                      // ( index + 1  > authProvider.translated.length)
                      //     ? FullQuoteBottomSheet(isLoading: _isLoading)
                      // :
                      authProvider.translated[index]
                    ],
                  );
                },
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer(authProvider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer(Auth authProvider) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        // margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _messageController,
                // onSubmitted: _handleSubmittedMessage,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  print("<<<<<credits ${authProvider.credits}");
                  authProvider.credits > 0
                      ? _handleSubmittedMessage(
                          _messageController.text, authProvider)
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Credits Finished"),
                              content: Text("Your free 3 credits are used up."),
                              actions: <Widget>[
                                // "OK" Button
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                    // Add your logic for the "OK" button here
                                  },
                                  child: Text("OK"),
                                ),

                                // "Cancel" Button
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog

                                    // Navigator.push(context, MaterialPageRoute(
                                    //     builder: (context) => SubscriptionScreen()));
                                    // Navigator.pushNamed(context, RouteHelper.)
                                    // Add your logic for the "Cancel" button here
                                  },
                                  child: Text("Subscribe"),
                                ),
                              ],
                            );
                          });
                  // showDialog(context: context, builder: (context ) =>
                  // Center(child: Container(
                  //   height: 200, width: 200,
                  //     child: Text ("Sorry your credits are over"))),
                  //  )
                  ;
                })
          ],
        ),
      ),
    );
  }
}
