import 'dart:async';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:wewayangan_mediapreview/app/widgets/media_skeleton.dart';
import 'package:wewayangan_mediapreview/video/view/video_widgets.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const VideoView();
  }
}

class VideoView extends StatefulWidget {
  const VideoView({super.key});

  @override
  State<VideoView> createState() => VideoViewState();
}

class VideoViewState extends State<VideoView> {
  late final player = Player();
  late final controller = VideoController(player);

  static const mockPlayer = true;

  static VideoViewState of(BuildContext context) {
    final state = context.findAncestorStateOfType<VideoViewState>();
    if (state == null) throw Exception('VideoViewState not found in context');
    return state;
  }

  @override
  void initState() {
    super.initState();
    if (mockPlayer) {
      unawaited(
        player.open(
          Media(
            'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    unawaited(player.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Mediaskeleton(
      body: mockPlayer
          ? Video(
              controller: controller,
            )
          : Container(color: Colors.white),
      controls: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 2,
            thumbShape: const LineSliderThumbShape(),
            padding: kLRPaddingMargin,
          ),
          child: Slider(
            max: 2 * 60 * 60,
            value: 1 * 60 * 60,
            onChanged: (value) {},
          ),
        ),
        const Padding(
          padding: kLRPaddingMargin,
          child: VideoPanel_Control(),
        ),
      ],
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
    final controller = VideoViewState.of(context).controller;

    return Row(
      mainAxisAlignment: .center,
      children: [
        Padding(
          padding: kLRPaddingMargin,
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
          icon: controller.player.state.playing
              ? const Icon(Icons.pause_rounded)
              : const Icon(Icons.play_arrow_rounded),
          label: const Text('1x'),
          onPressed: () {
            unawaited(
              controller.player.state.playing
                  ? controller.player.pause()
                  : controller.player.play(),
            );
          },
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
