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
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  GlobalKey<Co2ScreenState> _globalKey = GlobalKey();

  int selectedIndex = 0;
  final widgetOptions = [
    Co2Screen(),
    InformationWidget(),
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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        appBar: AppBar(
          backgroundColor: kRedGew,
          title: Text('CO2-School'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.business,
                color: Colors.white,
              ),
              onPressed: () {
                //TODO Implementation of reload
                Navigator.pushNamed(context, '/roomPicker');
              },
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
