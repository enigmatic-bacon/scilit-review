import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SciCard extends StatefulWidget {
  SciCard({Key key, @required this.text}) : super(key: key);
  final String text;

  @override
  _SciCardState createState() => _SciCardState();
}

class _SciCardState extends State<SciCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AutoSizeText(
            widget.text,
            style: TextStyle(
                color: Colors.black,
                fontSize: 36.0,
                fontWeight: FontWeight.w600),
            maxLines: 8,
          ),
        ),
      ),
    );
  }
}
