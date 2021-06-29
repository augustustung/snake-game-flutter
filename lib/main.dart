import 'package:flutter/material.dart';
import 'package:myapp/provider/auth.dart';
import 'package:myapp/screens/rank.dart';
import 'package:myapp/screens/snake_screen.dart';
import 'screens/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
    // routes: {
    //   '/a': (BuildContext context) => Rank.rou,
    //   '/b': (BuildContext context) => SnakeGame(Duration, null),
    //   '/c': (BuildContext context) => MyPage(title: 'page C'),
    // },

  ));
}
