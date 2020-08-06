import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingSwitch extends StatefulWidget {
  final Function() switchToTitles;
  final Function() switchToAbstracts;

  SettingSwitch({
    Key key,
    @required this.switchToTitles,
    @required this.switchToAbstracts,
  }) : super(key: key);

  @override
  _SettingSwitchState createState() => _SettingSwitchState();
}

class _SettingSwitchState extends State<SettingSwitch> {
  int segmentedControlInt = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Titles"),
    1: Text("Abstracts")
  };

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
      padding: EdgeInsets.all(4.0),
      groupValue: segmentedControlInt,
      children: myTabs,
      onValueChanged: (i) {
        if (i != segmentedControlInt) {
          if (i == 0) {
            widget.switchToTitles();
          } else {
            widget.switchToAbstracts();
          }
          setState(() {
            segmentedControlInt = i;
          });
        }
      },
    );
  }
}
