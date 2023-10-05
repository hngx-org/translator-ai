import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_ai/utils/colors.dart';
import 'package:translator_ai/utils/size_calculator.dart';

import '../../providers/auth.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;
  final String language;

  ChatMessage({required this.text, required this.isMe, required this.language});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isMe?
          Container(

            margin: const EdgeInsets.only(right: 16.0),
            child:  CircleAvatar(
              radius: 30,
              backgroundColor:   AppColors.primaryLight,
              backgroundImage:AssetImage('images/naruto.png'),
              // child: Image.asset('images/naruto.png'),
              ),
            )
          :SizedBox(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Text(
                  '$language',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary
                  ),
                ),
                // Container(
                //   width: AppConstants.screenWidth(context) * 0.5,
                //   height: sizer(false, 80, context),
                //   decoration: BoxDecoration(
                //     color: AppColors.primary,
                //     borderRadius: BorderRadius.circular(20)
                //   ),
                //   margin: const EdgeInsets.only(top: 5.0),
                //   child: Center(child: Text(text, textAlign: TextAlign.start,)),
                // ),
                ChatBubble(
                  message: text,
                  isMe: isMe,
                  language: language
                )
              ],
            ),
          ),
          isMe?SizedBox():
          Container(

            margin: const EdgeInsets.only(right: 16.0),
            child:  CircleAvatar(
              radius: 30,
              backgroundColor:   AppColors.primaryLight,
    backgroundImage:AssetImage('images/robot.jpeg'),

    ),
          )
        ],
      ),
    );
  }
}

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isMe;
  final String language;

  ChatBubble({required this.message, required this.isMe, required this.language});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  String translated = "";
  bool rebuild = true;
  //
  // bool checkCondition(int index, Auth authProvider) {
  //   while (!(index < authProvider.countLen)) {
  //     return false;
  //   }
  //
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context, listen: false);

    return Container(
      width: AppConstants.screenWidth(context),
      // height: 70,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: widget.isMe ? AppColors.primaryLight : AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: widget.isMe? Radius.circular(0.0):Radius.circular(12.0),
          topRight: widget.isMe?Radius.circular(12.0):Radius.circular(0.0),
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      child: Column(
        children: [
          Text(
            maxLines:99,
            // overflow:TextOverflow.clip,
            widget.message,
            style: TextStyle(
              fontSize: 20,
              color: AppColors.blackColor,
            ),
          ),
          // Text(
          //   (checkCondition(widget.index, authProvider))
          //       ? "${authProvider.translated[widget.index]}"
          //       : "",
          //   style: TextStyle(
          //     fontSize: 20,
          //     color: AppColors.primary,
          //   ),
          // ),
        ],
      ),
    );
  }
}
