import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:wewayangan_mediapreview/pages/video/video.dart';
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
      alignment: .topLeft,
      children: [
        Container(
          color: Colors.blueGrey,
        ),
        ColoredBox(
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
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            color: Colors.black.withValues(alpha: 0.3),
            padding: const .all(8),
          ),
        ),
      ],
    );
  }
}
