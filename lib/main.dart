import 'package:flutter/material.dart';
import 'package:my_game_library/screens/game_library.dart';
import 'package:my_game_library/themes/styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Game Library",
      home: GameLibrary(),
      theme: appTheme(),
    );
  } 
}

