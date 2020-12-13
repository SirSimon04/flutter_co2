import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'co2_screen.dart';
import 'constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: Scaffold(
        body: Co2Screen(),
        appBar: AppBar(
          backgroundColor: kRedGew,
          title: Text('CO2-School'),
          actions: [
            IconButton(
              icon: Icon(Icons.location_city),
              iconSize: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
