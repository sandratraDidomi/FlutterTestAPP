//import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
//import 'package:flutter_application_test/core/randomWords.dart';
import 'package:flutter_application_test/page/login.dart';
//import 'package:flutter_application_test/page/user.dart';
//import 'package:flutter_application_test/utils/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _init();
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor: Colors.white12,
        highlightColor: Colors.yellow,
      ),
      //home: RandomWords(),
      //home: User(),
      home: LoginPage(),
    );
  }

  void _init() async {
    log("Initializing the app...");
    /*
    final albums = await API.requestPOST('https://jsonplaceholder.typicode.com/albums', {'title': 'test'}, null);
    log('albums = ${albums.toString()}');

    final users = await API.requestGET('https://jsonplaceholder.typicode.com/users', null);
    var x = jsonDecode(users);
    log('x count: ' + x.length.toString());
    log('x name: ' + x[0]['name']);
    log('users = ${users.toString()}');
    */
  }
}
