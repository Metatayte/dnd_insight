import 'package:flutter/material.dart';
import './random_words.dart';

//Default main call for Flutter apps
void main() => runApp(MyApp());

//Stateless meaning it is immutable ;)
class MyApp extends StatelessWidget {
  // @override is implied but nice to explicitly declare it
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomWords(),
      theme: ThemeData(primaryColor: Colors.deepPurple[800]),
    );
  }
}
