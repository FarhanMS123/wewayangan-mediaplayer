import 'dart:math';
import 'package:flutter/material.dart';

class MediaSkeletonFrame extends StatelessWidget {
  const MediaSkeletonFrame({
    required this.child,
    required this.aspect,
    super.key,
  });

  final double aspect; // = width / height
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspect,
      child: LayoutBuilder(
        builder: (_, c) {
          return Center(
            child: _MediaSkeletonFrame(
              maxWidth: c.maxWidth,
              maxHeight: c.maxHeight,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class _MediaSkeletonFrame extends StatefulWidget {
  const _MediaSkeletonFrame({
    required this.maxWidth,
    required this.maxHeight,
    required this.child,
  });

  final double maxWidth;
  final double maxHeight;
  final Widget child;

  @override
  State<_MediaSkeletonFrame> createState() => _MediaSkeletonFrameState();
}

class _MediaSkeletonFrameState extends State<_MediaSkeletonFrame> {
  bool isEditGuide = false;
  // first two-finger hold; release one finger; then move around;
  bool isGestureStart = false;

  double x = 0;
  double y = 0;
  double zoom = 1;
  double angle = 0;

  @override
  Widget build(BuildContext context) {
    // two-finger touch -> start gesture
    // one-finger / two finger move -> pan
    // two-finger pinch/stretch -> zoom
    // two-finger slide side-ways -> rotate
    // three-finger -> reset
    // release all finger -> end gesture
    return GestureDetector(
      child: Transform(
        alignment: .center,
        transform: .translationValues(x, y, 0),
        child: SizedBox(
          child: Transform(
            alignment: .center,
            transform: .rotationZ(angle * pi / 180),
            child: ConstrainedBox(
              constraints: .tight(
                Size(widget.maxWidth * zoom, widget.maxHeight * zoom),
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
