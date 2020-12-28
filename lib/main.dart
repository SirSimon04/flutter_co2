import 'package:flutter_co2/screens/choose_room.dart';

import 'manager.dart';
import 'package:flutter/material.dart';

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
        routes: {'/roomPicker': (context) => RoomPickerWidget()},
        title: 'CO2',
        home: HomePage());
  }
}
