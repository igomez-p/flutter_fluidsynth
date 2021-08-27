import 'package:basic_flutter_fluidsynth/native_fluidsynth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String _noteName(int n) {
      switch(n)
      {
        case 0: return "C";
        case 1: return "C#";
        case 2: return "D";
        case 3: return "D#";
        case 4: return "E";
        case 5: return "F";
        case 6: return "F#";
        case 7: return "G";
        case 8: return "G#";
        case 9: return "A";
        case 10: return "A#";
        case 11: return "B";
      }
  }

  Widget _row(int n)
  {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () { noteOn(0, 60+n, 127); },
            tooltip: 'MIDI note '+(60+n).toString(),
            child: Text(_noteName(n)),
          ),
          FloatingActionButton(
            onPressed: () { noteOn(0, 60+n+1, 127); },
            tooltip: 'MIDI note '+(60+n+1).toString(),
            child: Text(_noteName(n+1)),
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('FLUTTER FLUIDSYNTH')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _row(0),
            _row(2),
            _row(4),
            _row(6),
            _row(8),
            _row(10),
          ],
        ),
      ),

    );
  }
}
