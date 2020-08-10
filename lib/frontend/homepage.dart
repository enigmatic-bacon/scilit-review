import 'package:flutter/material.dart';
import 'package:scilit/frontend/scicard.dart';
import 'bottombar.dart';
import '../backend/scipaper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _color = Colors.white;
  int _paperIndex = 0;
  bool _showingTitles = true;
  List<SciPaper> allPapers = generateSciPapers();
  List<SciPaper> approvedPapers = [];
  List<SciPaper> rejectedPapers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedContainer(
        color: _color,
        onEnd: resetColor,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_showingTitles == true)
                  SciCard(
                    text: allPapers[_paperIndex].title,
                  )
                else
                  SciCard(
                    text: allPapers[_paperIndex].abstract,
                  ),
                MyBottomBar(
                  notifyParentGood: cardGood,
                  notifyParentBad: cardBad,
                  goBack: previousCard,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setColor(Color color) {
    setState(() {
      _color = color;
    });
  }

  void _getNextPaper() {
    if (_paperIndex < allPapers.length - 1) {
      ++_paperIndex;
    } else {
      Alert(
              context: context,
              title: "Out of Papers",
              desc: "Have Checked All Papers")
          .show();
    }
  }

  void _getPreviousPaper() {
    if (_paperIndex > 0) {
      --_paperIndex;
    } else {
      Alert(context: context, title: "First Paper", desc: "Back to the start!")
          .show();
    }
  }

  void cardGood() {
    approvedPapers.add(allPapers[_paperIndex]);
    _setColor(Colors.green[300]);
    _getNextPaper();
  }

  void cardBad() {
    rejectedPapers.add(allPapers[_paperIndex]);
    _setColor(Colors.red[300]);
    _getNextPaper();
  }

  void previousCard() {
    _getPreviousPaper();
    if (approvedPapers.last.title == allPapers[_paperIndex].title) {
      approvedPapers.removeLast();
    } else {
      rejectedPapers.removeLast();
    }
    _setColor(Colors.amber[300]);
  }

  void switchToTitles() {
    setState(() {
      _showingTitles = true;
    });
  }

  void switchToAbstracts() {
    setState(() {
      _showingTitles = false;
    });
  }

  void resetColor() {
    setState(() {
      _color = Colors.white;
    });
  }
}
