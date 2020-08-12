import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyBottomBar extends StatefulWidget {
  final Function() notifyParentGood;
  final Function() notifyParentBad;
  final Function() notifyParentFlag;
  final Function() goBack;

  MyBottomBar({
    Key key,
    @required this.notifyParentGood,
    @required this.notifyParentBad,
    @required this.notifyParentFlag,
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
          onPressed: widget.goBack,
          backgroundColor: Colors.grey[800],
          child: _buildButtonInterior(Icons.history, '1'),
        ),
        FloatingActionButton(
          onPressed: widget.notifyParentBad,
          backgroundColor: Colors.red,
          child: _buildButtonInterior(Icons.thumb_down, '1'),
        ),
        FloatingActionButton(
          onPressed: widget.notifyParentFlag,
          backgroundColor: Colors.amber,
          child: _buildButtonInterior(Icons.flag, '1'),
        ),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              widget.notifyParentGood();
            });
          },
          backgroundColor: Colors.green,
          child: _buildButtonInterior(Icons.thumb_up, '1'),
        )
      ],
    );
  }

  // StreamBuilder(
  //     stream: Firestore.instance
  //         .collection('paper_titles')
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData)
  //         return const Text('Loading...');
  //       else {
  //         return Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             _buildDocument(context, snapshot.data.documents[0]),
  //             Text('2'),
  //             Text('3'),
  //             Text('4'),
  //           ],
  //         );
  //       }
  //     }),
  Column _buildButtonInterior(IconData icon, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        Text(value),
      ],
    );
  }

  Text _buildDocument(BuildContext context, DocumentSnapshot document) {
    return Text(document['Yes'].toString());
  }
}
