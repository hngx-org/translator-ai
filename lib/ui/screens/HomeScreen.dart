import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/languages.g.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';
import '../../utils/colors.dart';
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
  Language toLanguage = Languages.french;
  Language fromLanguage = Languages.english;
  late LanguagePickerDropdownController controllerFrom;
  late LanguagePickerDropdownController controllerTo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerFrom = LanguagePickerDropdownController(toLanguage);
    controllerTo = LanguagePickerDropdownController(fromLanguage);
  }

  void _handleSubmittedMessage(String text) {
    if (text.isNotEmpty) {
      _messageController.clear();
      setState(() {
        _messages.insert(0, ChatMessage(text: text));
      });
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
                      setState(() {
                        var temp = controllerFrom.value;
                        controllerFrom.value = controllerTo.value;
                        fromLanguage = controllerTo.value;
                        controllerTo.value = temp;
                        toLanguage = temp;
                      });
                      await authProvider
                          .setfromLanguage(controllerTo.value.name.toString());
                      await authProvider
                          .settoLanguage(controllerFrom.value.name.toString());
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
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
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
                onSubmitted: _handleSubmittedMessage,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmittedMessage(_messageController.text),
            ),
          ],
        ),
      ),
    );
  }
}
