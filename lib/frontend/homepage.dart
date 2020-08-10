import 'package:flutter/material.dart';
import 'package:scilit/frontend/scicard.dart';
import 'bottombar.dart';
import 'settingswitch.dart';
import '../backend/scipaper.dart';

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
                SettingSwitch(
                  switchToTitles: switchToTitles,
                  switchToAbstracts: switchToAbstracts,
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

  void cardGood() {
    approvedPapers.add(allPapers[_paperIndex]);
    setState(() {
      _color = Colors.green[300];
      _paperIndex++;
    });
  }

  void cardBad() {
    rejectedPapers.add(allPapers[_paperIndex]);
    setState(() {
      _color = Colors.red[300];
      _paperIndex++;
    });
  }

  void previousCard() {
    _paperIndex--;
    if (approvedPapers.last.title == allPapers[_paperIndex].title) {
      approvedPapers.removeLast();
    } else {
      rejectedPapers.removeLast();
    }
    setState(() {});
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
