import 'package:flutter/material.dart';

import 'chatscreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Chat Screen'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Settings Screen'),
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => SettingsScreen(),
              //   ),
              // );
            },
          ),
          // Add more ListTile widgets for additional screens here
        ],
      ),
    );
  }
}

