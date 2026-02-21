import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
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
        Positioned(
          // left: 0,
          // right: 0,
          bottom: 0,
          child: Column(
            children: [
              Container(
                margin: const .all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: const .all(.circular(kYaruContainerRadius)),
                ),
                padding: const .all(8),
              ),
              Container(
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
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        const Text(
                          '9999:59:59.999',
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(
                            true
                                ? Icons.volume_up_rounded
                                : Icons.volume_off_rounded,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MediaHeader extends StatelessWidget {
  const MediaHeader({
    super.key,
    required this.onBack,
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
