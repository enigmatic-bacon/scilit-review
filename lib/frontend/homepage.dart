import 'package:flutter/material.dart';
import 'package:scilit/backend/paperBrain.dart';
import 'package:scilit/frontend/scicard.dart';
import 'bottombar.dart';
import '../backend/save.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key) {
    print('BUILDING');
  }
  final String title;
  final Saver saver = Saver();

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
  void initState() {
    super.initState();
    widget.saver.readCounter().then((value) {
      setState(() {
        paperBrain.setCurrentPaperIndex(value);
        print('LOADING');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    paperBrain.setContext(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title +
                ' Paper #' +
                (paperBrain.getCurrentPaperIndex() + 1).toString() +
                '/' +
                paperBrain.getNumPapers().toString()),
            FlatButton(
              onPressed: () {
                print('SAVE');
                //paperBrain.addToCollection();
                widget.saver.save(paperBrain.getCurrentPaperIndex());
              },
              child: Text('SAVE'),
              color: Colors.white,
            )
          ],
        ),
      ),
      body: AnimatedContainer(
        color: _color,
        onEnd: resetColor,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
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
                  paperBrain: paperBrain,
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

  void cardGood() {
    print('GOOD');
    approvedPapers.add(paperBrain.getCurrentPaperTitle());
    _setColor(Colors.green[300]);
    paperBrain.getNextPaper();
  }

  void cardBad() {
    rejectedPapers.add(paperBrain.getCurrentPaperTitle());
    _setColor(Colors.red[300]);
    paperBrain.getNextPaper();
  }

  void cardFlag() {
    flaggedPapers.add(paperBrain.getCurrentPaperTitle());
    _setColor(Colors.amber[300]);
    paperBrain.getNextPaper();
  }

  void previousCard() {
    paperBrain.getPreviousPaper();
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
    _setColor(Colors.white);
  }
}
