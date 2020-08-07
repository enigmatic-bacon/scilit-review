import 'package:flutter/material.dart';
import 'package:scilit/frontend/scicard.dart';
import 'bottombar.dart';
import 'settingswitch.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class SciPaper {
  SciPaper(this.text, this.abstract);
  String text;
  String abstract;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _paperIndex = 0;
  bool _showingTitles = true;
  List<SciPaper> allPapers = [SciPaper('TITLE 1', 'ABSTRACT 1')];
  List<SciPaper> approvedPapers = [];
  List<SciPaper> rejectedPapers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_showingTitles == true)
                SciCard(
                  text: allPapers[_paperIndex].text,
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
    );
  }

  void cardGood() {
    allPapers.add(
        SciPaper('TITLE ${_paperIndex + 1}', 'ABSTRACT ${_paperIndex + 1}'));
    approvedPapers.add(allPapers[_paperIndex]);
    print(approvedPapers);
    setState(() {
      _paperIndex++;
    });
  }

  void cardBad() {
    allPapers.add(
        SciPaper('TITLE ${_paperIndex + 1}', 'ABSTRACT ${_paperIndex + 1}'));
    rejectedPapers.add(allPapers[_paperIndex]);
    print(rejectedPapers);
    setState(() {
      _paperIndex++;
    });
  }

  void previousCard() {
    setState(() {
      _paperIndex--;
    });
  }

  void switchToTitles() {
    setState(() {
      _showingTitles = true;
    });
    print('TITLES');
  }

  void switchToAbstracts() {
    setState(() {
      _showingTitles = false;
    });
    print('ABSTRACTS');
  }
}
