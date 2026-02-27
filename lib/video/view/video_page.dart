import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:wewayangan_mediapreview/app/widgets/RainbowShowcase.dart';
import 'package:wewayangan_mediapreview/video/video.dart';
import 'package:yaru/yaru.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: VideoView(
        onBack: () {},
      ),
    );
  }
}

class VideoView extends StatelessWidget {
  const VideoView({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: .topCenter,
      children: [
        Container(
          color: Colors.white,
        ),
        const Positioned(
          bottom: 0,
          child: Column(
            children: [
              VideoPanel(),
            ],
          ),
        ),
      ],
    );
  }
}

class VideoExtras extends StatelessWidget {
  const VideoExtras({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const .all(8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: const .all(.circular(kYaruContainerRadius)),
      ),
      padding: const .all(8),
    );
  }
}

class VideoPanel extends StatelessWidget {
  const VideoPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(kYaruContainerRadius),
          topRight: Radius.circular(kYaruContainerRadius),
        ),
      ),
      child: IntrinsicWidth(
        child: Column(
          textDirection: .ltr,
          mainAxisAlignment: .center,
          crossAxisAlignment: .stretch,
          children: [
            const Padding(padding: .only(top: 8)),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                thumbShape: const LineSliderThumbShape(),
                padding: const .fromLTRB(8, 0, 8, 0),
              ),
              child: Slider(
                max: 2 * 60 * 60,
                value: 1 * 60 * 60,
                onChanged: (value) {},
              ),
            ),
            const Padding(
              padding: .fromLTRB(8, 0, 8, 0),
              child: VideoPanel_Control(),
            ),
            ColoredBox(
              color: Colors.black.withValues(alpha: 0.2),
              child: const Text('aaaa'),
            ),
          ],
        ),
      ),
    );
  }
}

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

class VideoPanel_Control extends StatelessWidget {
  const VideoPanel_Control({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: .center,
      children: [
        Padding(
          padding: const .fromLTRB(8, 0, 8, 0),
          child: Text(
            "991x:59:59'30",
            style: theme.textTheme.labelLarge!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            true ? Icons.volume_up_rounded : Icons.volume_off_rounded,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.fast_rewind_rounded),
          onPressed: () {},
        ),
        TextButton.icon(
          icon: const Icon(Icons.play_arrow_rounded),
          label: const Text('1x'),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.fast_forward_rounded),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz_rounded),
          onPressed: () {},
        ),
      ],
    );
  }
}

class MediaHeader extends StatelessWidget {
  const MediaHeader({
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
