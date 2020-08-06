import 'package:flutter/material.dart';
import 'package:scilit/frontend/scicard.dart';
import 'bottombar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _paperIndex = 0;
  bool _showingTitles = true;
  List<String> titles = ['TITLE 1', 'TITLE 2', 'TITLE 3'];
  List<String> abstracts = ['ABSTRACT 1', 'ABSTRACT 2', 'ABSTRACT 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _showingTitles == true
                  ? SciCard(
                      text: titles[_paperIndex],
                    )
                  : SciCard(
                      text: abstracts[_paperIndex],
                    ),
              MyBottomBar(
                notifyParentGood: cardGood,
                notifyParentBad: cardBad,
                switchToTitles: switchToTitles,
                switchToAbstracts: switchToAbstracts,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void cardGood() {
    titles.add('TITLE ${_paperIndex + 4}');
    abstracts.add('ABSTRACT ${_paperIndex + 4}');
    setState(() {
      _paperIndex++;
    });
  }

  void cardBad() {
    print('BAD');
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
