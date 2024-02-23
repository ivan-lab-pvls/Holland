import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'game/GameScreen.dart';
import 'onBoarding/OnBoardingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  OnBoardingScreen(),
    );
  }
}
