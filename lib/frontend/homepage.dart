import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int segmentedControlInt = 0;
  int _counter = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Titles"),
    1: Text("Abstracts")
  };

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

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
              Expanded(
                child: Card(
                  margin: EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                  ),
                ),
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: _decrementCounter,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.thumb_down),
                  ),
                  CupertinoSlidingSegmentedControl(
                    padding: EdgeInsets.all(8.0),
                    groupValue: segmentedControlInt,
                    children: myTabs,
                    onValueChanged: (i) {
                      print(i);
                    },
                  ),
                  FloatingActionButton(
                    onPressed: _incrementCounter,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.thumb_up),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
