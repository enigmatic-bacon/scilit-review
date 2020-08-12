import 'package:flutter/material.dart';
import 'package:scilit/backend/paperTitles.dart';
import 'package:scilit/frontend/scicard.dart';
import 'bottombar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _color = Colors.white;
  PaperBrain paperBrain = PaperBrain();
  List<String> approvedPapers = [];
  List<String> rejectedPapers = [];
  List<String> flaggedPapers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title +
            ' Paper #' +
            (paperBrain.getCurrentPaperIndex() + 1).toString() +
            '/' +
            paperBrain.getNumPapers().toString()),
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
                SciCard(
                  text: paperBrain.getCurrentPaperTitle(),
                ),
                MyBottomBar(
                  notifyParentGood: cardGood,
                  notifyParentBad: cardBad,
                  notifyParentFlag: cardFlag,
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
    setState(() {
      if (paperBrain.getNextPaper()) {
      } else {
        Alert(
                context: context,
                title: "Out of Papers",
                desc: "Have Checked All Papers")
            .show();
      }
    });
  }

  void _getPreviousPaper() {
    setState(() {
      if (paperBrain.getPreviousPaper()) {
      } else {
        Alert(
                context: context,
                title: "First Paper",
                desc: "Back to the start!")
            .show();
      }
    });
  }

  void cardGood() {
    approvedPapers.add(paperBrain.getCurrentPaperTitle());
    _setColor(Colors.green[300]);
    _getNextPaper();
  }

  void cardBad() {
    rejectedPapers.add(paperBrain.getCurrentPaperTitle());
    _setColor(Colors.red[300]);
    _getNextPaper();
  }

  void cardFlag() {
    flaggedPapers.add(paperBrain.getCurrentPaperTitle());
    _setColor(Colors.amber[300]);
    _getNextPaper();
  }

  void previousCard() {
    _getPreviousPaper();
    if (approvedPapers.isNotEmpty &&
        approvedPapers.last == paperBrain.getCurrentPaperTitle()) {
      approvedPapers.removeLast();
    } else if (rejectedPapers.isNotEmpty &&
        rejectedPapers.last == paperBrain.getCurrentPaperTitle()) {
      rejectedPapers.removeLast();
    } else if (flaggedPapers.isNotEmpty &&
        flaggedPapers.last == paperBrain.getCurrentPaperTitle()) {
      flaggedPapers.removeLast();
    }
    _setColor(Colors.grey[700]);
  }

  void resetColor() {
    setState(() {
      _color = Colors.white;
    });
  }
}
