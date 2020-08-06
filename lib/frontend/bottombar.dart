import 'package:flutter/material.dart';

class MyBottomBar extends StatefulWidget {
  final Function() notifyParentGood;
  final Function() notifyParentBad;
  final Function() goBack;

  MyBottomBar({
    Key key,
    @required this.notifyParentGood,
    @required this.notifyParentBad,
    @required this.goBack,
  }) : super(key: key);

  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
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
        FloatingActionButton(
          onPressed: widget.notifyParentGood,
          backgroundColor: Colors.green,
          child: Icon(Icons.thumb_up),
        )
      ],
    );
  }
}
