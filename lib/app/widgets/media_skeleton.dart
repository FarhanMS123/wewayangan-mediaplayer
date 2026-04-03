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
        body,
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

class MediaSkeletonFrame extends StatefulWidget {
  const MediaSkeletonFrame({
    required this.ratio,
    required this.builder,
    super.key,
  });

  final double ratio; // = width / height
  final WidgetBuilder builder;

  @override
  State<MediaSkeletonFrame> createState() => _MediaSkeletonFrameState();
}

class _MediaSkeletonFrameState extends State<MediaSkeletonFrame> {
  bool hasInit = false;
  late double init_vw;
  late double init_vh;

  late double width;
  late double height;
  late double top = 0;
  late double left = 0;

  double zoom = 1;
  double angle = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, c) {
        // h1 . r = w1
        // if true;
        final isLessWidth = c.maxHeight * widget.ratio < c.maxWidth;
        width = isLessWidth
            ? c.maxHeight * widget.ratio * zoom
            : c.maxWidth * zoom;
        height = isLessWidth
            ? c.maxHeight * zoom
            : c.maxWidth * zoom / widget.ratio;

        if (!hasInit) {
          init_vw = c.maxWidth;
          init_vh = c.maxHeight;
          top = c.maxHeight / 2 - height;
          left = c.maxWidth / 2 - width;
          hasInit = true;
        }

        return Positioned(
          top: top + (c.maxHeight - init_vh) / 2,
          left: left + (c.maxWidth - init_vw) / 2,
          width: width,
          height: height,
          child: ConstrainedBox(
            constraints: .tight(Size(width, height)),
            child: widget.builder(context),
          ),
        );
      },
    );
  }
}
