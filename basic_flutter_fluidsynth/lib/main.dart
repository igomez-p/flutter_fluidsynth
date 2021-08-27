import 'dart:io';
import 'dart:typed_data';

import 'package:basic_flutter_fluidsynth/native_fluidsynth.dart';
import 'package:basic_flutter_fluidsynth/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    initFluidsynth();

    Future.wait([loadFluidsynthFile("sndfnt.sf2")]);

    return MaterialApp(
      title: 'Flutter Fluidsynth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

Future<void> loadFluidsynthFile(String fileName) async {
  ByteData sound = await rootBundle.load('assets/sndfnt/$fileName');

  File soundFile = File('${(await getTemporaryDirectory()).path}/$fileName');

  Future.wait([soundFile.writeAsBytes(sound.buffer.asUint8List(sound.offsetInBytes, sound.lengthInBytes))])
      .then((value) => loadFluidsynth(soundFile.path));
}
