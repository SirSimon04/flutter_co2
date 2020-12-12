import 'package:flutter/material.dart';
import 'co2_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        body: Co2Screen(),
        appBar: AppBar(
          title: Text('CO2-School'),
        ),
      ),
    );
  }
}
