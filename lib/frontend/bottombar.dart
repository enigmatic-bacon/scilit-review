import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatefulWidget {
  final Function() notifyParentGood;
  final Function() notifyParentBad;

  MyBottomBar(
      {Key key,
      @required this.notifyParentGood,
      @required this.notifyParentBad})
      : super(key: key);

  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int segmentedControlInt = 0;
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
          onPressed: widget.notifyParentBad,
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
          onPressed: widget.notifyParentGood,
          backgroundColor: Colors.green,
          child: Icon(Icons.thumb_up),
        )
      ],
    );
  }
}
