import 'package:flutter/material.dart';

class CustomSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final bool flag;
  final String? text;

  const CustomSliderThumbShape(
      {this.thumbRadius = 9, required this.flag, this.text});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final rect = Rect.fromCircle(center: center, radius: thumbRadius);

    final rrect = RRect.fromRectAndRadius(
      Rect.fromPoints(
        Offset(rect.left, rect.top),
        Offset(rect.right, rect.bottom),
      ),
      Radius.circular(thumbRadius),
    );

    final fillPaint = Paint()
      ..color = sliderTheme.activeTrackColor!
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke;

    if (flag) {
      TextSpan span = new TextSpan(
        style: new TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: sliderTheme.thumbColor,
        ),
        text: text,
      );

      TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      Offset textCenter = Offset(
          center.dx - (tp.width / 2), center.dy - (2 * (tp.height / 2) + 20));
      tp.paint(canvas, textCenter);
    }

    canvas.drawRRect(rrect, fillPaint);
    canvas.drawRRect(rrect, borderPaint);
  }
}
