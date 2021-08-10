import 'package:Slider/thumb.dart';
import 'package:flutter/material.dart';

import 'card_tile.dart';

const Color kDefaultActiveColor = Color(0xff861089);
const Color kDefaultInactiveColor = Color(0xffBF86C0);
const Color kDefaultThumbColor = Colors.white;

class SliderWidget extends StatefulWidget {
  // text input
  final TextEditingController textController;
  final double min;
  final double max;

  // start volume
  double? volume;

  // color to point
  final Color? activeColor;

  //color after point
  final Color? inactiveColor;

  //height slider
  final double trackHeight;

  //do we need to use text above the point
  final bool flag;

  //text above point
  final String? text;

  //text min volume
  final String minText;

  //text max volume
  final String maxText;

  //point border color
  final Color? thumbColor;

  SliderWidget(
      {Key? key,
      required this.textController,
      this.inactiveColor,
      this.activeColor,
      this.thumbColor,
      required this.min,
      required this.max,
      this.text,
      required this.flag,
      this.volume,
      required this.maxText,
      required this.minText,
      required this.trackHeight})
      : super(key: key);

  @override
  _SliderWidget createState() => _SliderWidget();
}

class _SliderWidget extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.volume == null) {
      widget.volume = widget.min;
    }
    if (widget.textController.value.text.isEmpty ||
        (double.parse(widget.textController.value.text) <= widget.max &&
            double.parse(widget.textController.value.text) >= widget.min) ||
        (widget.volume! < widget.max && widget.volume! > widget.min))
      widget.textController.value = widget.textController.value
          .copyWith(text: widget.volume!.round().toString());

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.all(30)),
          CardTile.card(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: Column(children: [
                    Padding(padding: const EdgeInsets.only(top: 25)),
                    SliderTheme(
                      data: SliderThemeData(
                          activeTrackColor:
                              widget.activeColor ?? kDefaultActiveColor,
                          inactiveTrackColor:
                              widget.inactiveColor ?? kDefaultInactiveColor,
                          trackHeight: widget.trackHeight,
                          thumbColor: widget.thumbColor ?? kDefaultThumbColor,
                          thumbShape: CustomSliderThumbShape(
                              flag: widget.flag, text: widget.text)),
                      child: Slider(
                        min: widget.min,
                        max: widget.max,
                        value: widget.volume!,
                        onChanged: (value) {
                          setState(() {
                            widget.volume = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(padding: const EdgeInsets.all(4.0)),
                            Expanded(
                              child: Text(
                                widget.minText,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.maxText,
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Padding(padding: const EdgeInsets.all(4.0)),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ))
                  ]))),
          Card(
              margin: EdgeInsets.only(left: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 250, maxHeight: 80),
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
                  ])))
        ]);
  }
}
