import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu
        ),
        title: Text(
          'App'
        ),
        actions: [
          Icon(
            Icons.notification_important
          ),
          Icon(
            Icons.search
          ),
        ],
      ),
    );
  }
}