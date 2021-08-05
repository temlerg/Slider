import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final TextEditingController textController;
  double? volume;
  final double min;
  final double max;

  InputWidget(
      {Key? key,
      required this.volume,
      required this.max,
      required this.min,
      required this.textController})
      : super(key: key);

  @override
  _InputWidget createState() => _InputWidget();
}

class _InputWidget extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(left: 16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250, maxHeight: 80),
            child: Row(children: [
              Padding(padding: const EdgeInsets.only(left: 16)),
              Expanded(
                  child: Text(
                "мне ок",
                style: TextStyle(fontSize: 18),
              )),
              Padding(padding: const EdgeInsets.only(left: 16)),
              Expanded(
                  flex: 2,
                  child: TextField(
                    controller: widget.textController,
                    onChanged: (value) {
                      setState(() {
                        if (double.parse(value) <= widget.min) {
                          widget.volume = widget.min;
                        } else if (double.parse(value) >= widget.max) {
                          widget.volume = widget.max;
                        } else {
                          widget.volume = double.parse(value);
                          widget.textController.value.copyWith(
                              text: widget.volume!.round().toString());
                        }
                      });
                    },
                    decoration: InputDecoration(
                        counterStyle: TextStyle(fontSize: 18),
                        border: InputBorder.none),
                  ))
            ])));
  }
}
