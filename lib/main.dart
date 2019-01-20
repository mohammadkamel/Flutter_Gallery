import 'package:flutter/material.dart';
import './screens/home.dart'; // import screen home


void main() => runApp(Gallery());

class Gallery extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Gallery'),
    );
  }
}