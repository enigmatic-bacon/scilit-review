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
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FloatingActionButton(
          onPressed: widget.goBack,
          backgroundColor: Colors.grey[800],
          child: Icon(Icons.history),
        ),
        FloatingActionButton(
          onPressed: widget.notifyParentBad,
          backgroundColor: Colors.red,
          child: _buildButtonInterior(Icons.thumb_down, 'No'),
        ),
        FloatingActionButton(
          onPressed: widget.notifyParentFlag,
          backgroundColor: Colors.amber,
          child: _buildButtonInterior(Icons.flag, 'Maybe'),
        ),
        FloatingActionButton(
          onPressed: () {
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
                return const Text('Loading...');
              else {
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

  Text _buildDocument(
      BuildContext context, DocumentSnapshot document, String field) {
    return Text(document[field].toString());
  }
}
