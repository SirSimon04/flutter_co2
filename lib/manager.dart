import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'components/constants.dart';
import 'screens/choose_room.dart';
import 'package:flutter_co2/screens/co2_screen.dart';
import 'screens/info.dart';
import 'dart:io' show Platform;
import 'package:community_material_icon/community_material_icon.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final PageStorageBucket bucket = PageStorageBucket();

  final List<Widget> pages = [
    Co2Screen(
      key: PageStorageKey("Co2-Page"),
    ),
    InformationWidget(
      key: PageStorageKey('InformationPage'),
    ),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
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
      currentIndex: _selectedIndex,
      fixedColor: kAccentColor,
      unselectedItemColor: kInactiveBottomItem,
      onTap: onItemTapped,
    );
  }

  CupertinoTabBar iosBottomTabBar() {
    return CupertinoTabBar(
      items: bottomNavigationBarItems,
      backgroundColor: kRedGew,
      currentIndex: _selectedIndex,
      activeColor: kAccentColor,
      inactiveColor: kInactiveBottomItem,
      onTap: onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageStorage(
          child: pages[_selectedIndex],
          bucket: bucket,
        ),
        bottomNavigationBar:
            Platform.isIOS ? iosBottomTabBar() : androidBottomTabBar());
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
