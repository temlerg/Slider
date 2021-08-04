import 'package:Slider/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'card_tile.dart';
import 'thumb.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slider',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage() : super();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textController = TextEditingController();
  double _volume = 10000;

  @override
  Widget build(BuildContext context) {
    _textController.value =
        _textController.value.copyWith(text: _volume.round().toString());
    return Scaffold(
        backgroundColor: Colors.black,
        body: SliderWidget(
          flag: true,
          trackHeight: 15,
          min: 500,
          max: 50000,
          text: "💰",
          minText: "500₽",
          maxText: "более 50000₽",
          volume: 10000,
        )
    );
  }
}
