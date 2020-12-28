import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(
      {@required this.color,
      this.cardChild,
      this.onPress,
      @required this.edgeInsets});

  final Color color;
  final Widget cardChild;
  final Function onPress;
  final EdgeInsets edgeInsets;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: edgeInsets,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
