import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:wewayangan_mediapreview/app/app.dart';
import 'package:wewayangan_mediapreview/app/widgets/media_skeleton.dart';
import 'package:wewayangan_mediapreview/video/view/video_widgets.dart';

final GetIt getIt = GetIt.instance;

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const VideoView();
  }
}

class VideoView extends StatefulWidget {
  const VideoView({
    super.key,
  });

  String get filePath {
    const demoFilePath =
        'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4';
    if (getIt<FlavorParams>().demo) return demoFilePath;
    if (getIt<AppParams>().args.isNotEmpty &&
        getIt<AppParams>().args[0].isNotEmpty) {
      return getIt<AppParams>().args[0];
    }
    return '';
  }

  @override
  State<VideoView> createState() => VideoViewState();
}

class VideoViewState extends State<VideoView> {
  late final player = Player();
  late final controller = VideoController(player);

  bool disposePlayer = false;
  static const mockPlayer = true;

  static VideoViewState of(BuildContext context) {
    final state = context.findAncestorStateOfType<VideoViewState>();
    if (state == null) throw Exception('VideoViewState not found in context');
    return state;
  }

  @override
  void initState() {
    super.initState();
    if (widget.filePath.isNotEmpty && !disposePlayer) {
      unawaited(
        player.open(Media(widget.filePath)),
      );
    }
  }

  @override
  void dispose() {
    if (!disposePlayer) unawaited(player.dispose());
    disposePlayer = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!disposePlayer) return const Text('Player Disposed');

    return Mediaskeleton(
      body: widget.filePath.isNotEmpty
          ? Video(
              controller: controller,
              controls: null,
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
    final player = controller.player;

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
        StreamBuilder(
          stream: player.stream.volume,
          builder: (_, _) {
            return IconButton(
              icon: Icon(
                player.state.volume > 0
                    ? Icons.volume_up_rounded
                    : Icons.volume_off_rounded,
              ),
              onPressed: () {
                unawaited(
                  player.state.volume > 0
                      ? player.setVolume(0)
                      : player.setVolume(100),
                );
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.fast_rewind_rounded),
          onPressed: () {},
        ),
        StreamBuilder(
          stream: player.stream.playing,
          builder: (_, _) => TextButton.icon(
            icon: player.state.playing
                ? const Icon(Icons.pause_rounded)
                : const Icon(Icons.play_arrow_rounded),
            label: const Text('1x'),
            onPressed: () {
              unawaited(
                player.state.playing ? player.pause() : player.play(),
              );
            },
          ),
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
