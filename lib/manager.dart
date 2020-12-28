import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'components/constants.dart';
import 'screens/choose_room.dart';
import 'screens/co2_screen.dart';
import 'screens/info.dart';
import 'dart:io' show Platform;
import 'package:community_material_icon/community_material_icon.dart';

class HomePage extends StatefulWidget {
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

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
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
  ];

  BottomNavigationBar androidBottomTabBar() {
    return BottomNavigationBar(
      items: bottomNavigationBarItems,
      backgroundColor: kRedGew,
      currentIndex: selectedIndex,
      fixedColor: kAccentColor,
      unselectedItemColor: kInactiveBottomItem,
      onTap: onItemTapped,
    );
  }

  CupertinoTabBar iosBottomTabBar() {
    return CupertinoTabBar(
      items: bottomNavigationBarItems,
      backgroundColor: kRedGew,
      currentIndex: selectedIndex,
      activeColor: kAccentColor,
      inactiveColor: kInactiveBottomItem,
      onTap: onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kRedGew,
          title: Text('CO2-School'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                CommunityMaterialIcons.reload,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar:
            Platform.isIOS ? iosBottomTabBar() : androidBottomTabBar());
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
