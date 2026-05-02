import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wewayangan_mediapreview/app/app.dart';
import 'package:yaru/yaru.dart';

const double kContainerRadius = kYaruContainerRadius;
const kPaddingMargin = 8.0;
const kLRPaddingMargin = EdgeInsetsGeometry.fromLTRB(
  kPaddingMargin,
  0,
  kPaddingMargin,
  0,
);
final Color kBlack_02 = Colors.black.withValues(alpha: 0.2);
final Color kBlack_04 = Colors.black.withValues(alpha: 0.4);

// TODO(skele-func): on screen touch, hide notif bar, navbar, and control panel
// TODO(skele-func): on edge screen touch, slide next/prev
class Mediaskeleton extends StatelessWidget {
  const Mediaskeleton({
    required this.body,
    required this.controls,
    super.key,
    this.extras,
  });

  final Widget body;
  final Widget? extras;
  final List<Widget> controls;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MediaSkeletonCubit(),
      child: Builder(
        builder: buildView,
      ),
    );
  }

  Stack buildView(BuildContext context) {
    final IsExtrasOn = context.select(
      (MediaSkeletonCubit c) => c.state.isExtrasOn,
    );

    return Stack(
      alignment: .topCenter,
      children: [
        // ? MediaSkeletonView
        // TODO(view): can scale in/out, rotate.
        Positioned.fill(
          child: Center(child: body),
        ),
        // ? MediaSkeletonHeader
        // ? MediaSkeletonPanel
        Positioned(
          bottom: 0,
          child: Column(
            children: [
              // ? MediaSkeletonPanel_Extras
              // TODO(extras): built-in scroll, and small full button
              if (extras != null && IsExtrasOn == .hide)
                MediaSkeleton_Extras(extras: extras),
              // ? MediaSkeletonPanel_Control
              Container(
                decoration: BoxDecoration(
                  color: kBlack_04,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(kContainerRadius),
                    topRight: Radius.circular(kContainerRadius),
                  ),
                ),
                padding: const .only(top: kPaddingMargin),
                child: IntrinsicWidth(
                  child: Column(
                    textDirection: .ltr,
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .stretch,
                    children: controls,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MediaSkeleton_Extras extends StatelessWidget {
  const MediaSkeleton_Extras({
    super.key,
    required this.extras,
  });

  final Widget? extras;

  @override
  Widget build(BuildContext context) {
    final IsExtrasOn = context.select(
      (MediaSkeletonCubit c) => c.state.isExtrasOn,
    );

    return Container(
      margin: const .all(kPaddingMargin),
      decoration: BoxDecoration(
        color: kBlack_04,
        borderRadius: const .all(.circular(kYaruContainerRadius)),
      ),
      padding: const .all(kPaddingMargin),
      child: extras,
    );
  }
}

class MediaSkeletonHeader extends StatelessWidget {
  const MediaSkeletonHeader({
    required this.onBack,
    super.key,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withValues(alpha: 0.3),
      child: YaruTile(
        leading: YaruIconButton(
          onPressed: onBack,
          icon: const Icon(YaruIcons.go_previous),
        ),
        title: const Text('Song Title'),
        subtitle: const Text('Filename'),
        trailing: YaruIconButton(
          onPressed: () {},
          icon: const Icon(YaruIcons.view_more),
        ),
      ),
    );
  }
}
