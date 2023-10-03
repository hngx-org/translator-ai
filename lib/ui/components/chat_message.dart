import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_ai/utils/colors.dart';
import 'package:translator_ai/utils/size_calculator.dart';

import '../../providers/auth.dart';

class ChatMessage extends StatelessWidget {
  final String text;

  ChatMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //
          //   margin: const EdgeInsets.only(right: 16.0),
          //   child:  CircleAvatar(
          //     radius: 30,
          //     backgroundColor:   AppColors.primaryLight
          //     ,
          //     child: Text('${authProvider.name}',style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //     ),),
          //   ),
          // ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //  Text(
                //   '${authProvider.name}',
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     color: AppColors.primary
                //   ),
                // ),
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
                ChatBubble(message: text, isMe: true)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  ChatBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.screenWidth(context),
      height: 100,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: isMe ? AppColors.primaryLight : Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? 12.0 : 0.0),
          topRight: Radius.circular(isMe ? 0.0 : 12.0),
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 23,
          color: isMe ? Colors.black : Colors.black,
        ),
      ),
    );
  }
}
