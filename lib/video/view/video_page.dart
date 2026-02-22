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
        // RainbowShowcase(),
        const Positioned(
          // left: 0,
          // right: 0,
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
      padding: const .all(8),
      child: Column(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 2,
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(
              max: 2 * 60 * 60,
              value: 1 * 60 * 60,
              padding: const .all(0),
              onChanged: (value) {},
            ),
          ),
          const VideoPanel_Control(),
        ],
      ),
    );
  }
}

class VideoPanel_Control extends StatelessWidget {
  const VideoPanel_Control({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: .center,
      children: [
        Padding(
          padding: const .fromLTRB(8, 0, 8, 0),
          child: Text(
            '991x:59:59.999',
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
