import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatefulWidget {
  final Function() notifyParentGood;
  final Function() notifyParentBad;
  final Function() goBack;
  final Function() switchToTitles;
  final Function() switchToAbstracts;

  MyBottomBar({
    Key key,
    @required this.notifyParentGood,
    @required this.notifyParentBad,
    @required this.goBack,
    @required this.switchToTitles,
    @required this.switchToAbstracts,
  }) : super(key: key);

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
        FloatingActionButton(
          onPressed: widget.goBack,
          backgroundColor: Colors.amber,
          child: Icon(Icons.history),
        ),
        CupertinoSlidingSegmentedControl(
          padding: EdgeInsets.all(8.0),
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
