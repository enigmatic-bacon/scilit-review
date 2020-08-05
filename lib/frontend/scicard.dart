import 'package:flutter/material.dart';

class SciCard extends StatefulWidget {
  SciCard({Key key}) : super(key: key);

  @override
  _SciCardState createState() => _SciCardState();
}

class _SciCardState extends State<SciCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: Text('TITLE'),
          ),
        ),
      ),
    );
  }
}
