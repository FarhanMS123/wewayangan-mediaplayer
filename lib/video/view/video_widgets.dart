import 'package:flutter/material.dart';

class LineSliderThumbShape extends SliderComponentShape {
  const LineSliderThumbShape();
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(4, 16);
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
    final paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.white
      ..style = PaintingStyle.fill;
    // Fixed size: 4px width, 16px height with 2px corner radius
    final rect = Rect.fromCenter(
      center: center,
      width: 3,
      height: 20,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(6)),
      paint,
    );
  }
}
