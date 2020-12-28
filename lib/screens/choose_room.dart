import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_co2/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class RoomPickerWidget extends StatefulWidget {
  @override
  _RoomPickerWidgetState createState() => _RoomPickerWidgetState();
}

class _RoomPickerWidgetState extends State<RoomPickerWidget> {
  String selectedRoom = 'A102';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String room in roomList) {
      var newItem = DropdownMenuItem(
        child: Text(room),
        value: room,
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      items: dropDownItems,
      value: selectedRoom,
      onChanged: (value) {
        setState(() {
          selectedRoom = value;
        });

        //TODO: give selectedRoom back to co2_screen and call getData
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> dropDownItems = [];

    for (String room in roomList) {
      var newItem = DropdownMenuItem(
        child: Text(room),
        value: room,
      );
      dropDownItems.add(newItem);
    }

    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            selectedRoom = roomList[selectedIndex];
          });
        },
        children: dropDownItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kRedGew,
        title: Text('Raumauswahl'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Wähle einen Raum aus',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Container(
              child: Platform.isIOS ? iOSPicker() : androidDropdown(),
            )
          ],
        ),
      ),
    );
  }
}
