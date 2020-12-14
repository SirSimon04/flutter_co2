import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'constants.dart';
import 'choose_room.dart';
import 'co2_screen.dart';
import 'info.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 1;
  final widgetOptions = [
    InformationWidget(),
    Co2Screen(),
    RoomPickerWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kRedGew,
        title: Text('CO2-School'),
      ),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Raumauswahl',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Übersicht',
            backgroundColor: kInactiveBottomItem,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_device_information_rounded),
            label: 'Information',
          ),
        ],
        backgroundColor: kRedGew,
        currentIndex: selectedIndex,
        fixedColor: kAccentColor,
        unselectedItemColor: kInactiveBottomItem,
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
