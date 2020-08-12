import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scilit/backend/paperBrain.dart';

class MyBottomBar extends StatefulWidget {
  final Function() notifyParentGood;
  final Function() notifyParentBad;
  final Function() notifyParentFlag;
  final Function() goBack;
  final PaperBrain paperBrain;

  MyBottomBar(
      {Key key,
      @required this.notifyParentGood,
      @required this.notifyParentBad,
      @required this.notifyParentFlag,
      @required this.goBack,
      @required this.paperBrain})
      : super(key: key);

  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  Map<String, dynamic> snapshots = new Map();
  List<int> choices = [];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FloatingActionButton(
          onPressed: () {
            setState(() {
              widget.goBack();
            });
          },
          backgroundColor: Colors.grey[800],
          child: Icon(Icons.history),
        ),
        FloatingActionButton(
          onPressed: () {
            choices.add(0);
            setState(() {
              widget.notifyParentBad();
            });
          },
          backgroundColor: Colors.red,
          child: _buildButtonInterior(Icons.thumb_down, 'No'),
        ),
        FloatingActionButton(
          onPressed: () {
            choices.add(1);
            setState(() {
              widget.notifyParentFlag();
            });
          },
          backgroundColor: Colors.amber,
          child: _buildButtonInterior(Icons.flag, 'Maybe'),
        ),
        FloatingActionButton(
          onPressed: () {
            choices.add(2);
            setState(() {
              widget.notifyParentGood();
            });
          },
          backgroundColor: Colors.green,
          child: _buildButtonInterior(Icons.thumb_up, 'Yes'),
        )
      ],
    );
  }

  Column _buildButtonInterior(IconData icon, String field) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        StreamBuilder(
            stream: Firestore.instance.collection('paper_titles').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return const Text('0');
              else {
                snapshots[field] = snapshot;

                return _buildDocument(
                    context,
                    snapshot.data
                        .documents[widget.paperBrain.getCurrentPaperIndex()],
                    field);
              }
            }),
      ],
    );
  }

//TODO FIND A WAY TO CALL THIS
  void saveData() {
    for (int i = 0; i < widget.paperBrain.getCurrentPaperIndex(); ++i) {
      switch (choices[i]) {
        case 0:
          _incrementField(i, 'No');
          break;
        case 1:
          _incrementField(i, 'Maybe');
          break;
        case 2:
          _incrementField(i, 'Yes');
          break;
        default:
      }
    }
  }

  Future<void> _incrementField(int index, String field) async {
    setState(() {
      Firestore.instance.runTransaction((transaction) async {
        if (snapshots[field] == null || !snapshots[field].hasData) {
          return;
        }
        print(widget.paperBrain.getCurrentPaperIndex());
        DocumentSnapshot freshSnap = snapshots[field].data.documents[index];
        await transaction
            .update(freshSnap.reference, {field: freshSnap[field] + 1});
      });
    });
  }

  Text _buildDocument(
      BuildContext context, DocumentSnapshot document, String field) {
    return Text(document[field].toString());
  }
}
