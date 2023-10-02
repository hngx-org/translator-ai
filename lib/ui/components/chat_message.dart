import 'package:flutter/material.dart';
import 'package:translator_ai/utils/colors.dart';
class ChatMessage extends StatelessWidget {
  final String text;

  ChatMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(

            margin: const EdgeInsets.only(right: 16.0),
            child: const CircleAvatar(
              backgroundColor:   AppColors.primaryLight
              ,
              child: Text('User',style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'User',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
