import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wewayangan_mediapreview/app/app.dart';

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

class _MediaSkeletonFrame extends StatelessWidget {
  const _MediaSkeletonFrame({
    required this.maxWidth,
    required this.maxHeight,
    required this.child,
  });

  final double maxWidth;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final (x, y, zoom, angle) = context.select(
      (MediaSkeletonCubit c) => (
        c.state.x,
        c.state.y,
        c.state.zoom,
        c.state.angle,
      ),
    );

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
                Size(maxWidth * zoom, maxHeight * zoom),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
