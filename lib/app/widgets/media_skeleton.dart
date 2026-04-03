import 'package:flutter/material.dart';
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
              if (extras != null)
                Container(
                  margin: const .all(kPaddingMargin),
                  decoration: BoxDecoration(
                    color: kBlack_04,
                    borderRadius: const .all(.circular(kYaruContainerRadius)),
                  ),
                  padding: const .all(kPaddingMargin),
                  child: extras,
                ),
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
  double x = 0;
  double y = 0;
  double zoom = .5;
  double angle = 0;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: .tight(
        Size(widget.maxWidth * zoom, widget.maxHeight * zoom),
      ),
      child: widget.child,
    );
  }
}
