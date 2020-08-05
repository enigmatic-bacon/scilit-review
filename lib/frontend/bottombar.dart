import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatefulWidget {
  MyBottomBar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int segmentedControlInt = 1;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Titles"),
    1: Text("Abstracts")
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FloatingActionButton(
          onPressed: null,
          backgroundColor: Colors.red,
          child: Icon(Icons.thumb_down),
        ),
        CupertinoSlidingSegmentedControl(
          padding: EdgeInsets.all(8.0),
          groupValue: segmentedControlInt,
          children: myTabs,
          onValueChanged: (i) {
            setState(() {
              segmentedControlInt = i;
            });
          },
        ),
        FloatingActionButton(
          onPressed: null,
          backgroundColor: Colors.green,
          child: Icon(Icons.thumb_up),
        )
      ],
    );
  }
}
