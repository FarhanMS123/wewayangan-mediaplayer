import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wewayangan_mediapreview/app/app.dart';
import 'package:wewayangan_mediapreview/app/widgets/media_skeleton.dart';
import 'package:wewayangan_mediapreview/app/widgets/media_skeleton_frame.dart';
import 'package:wewayangan_mediapreview/video/view/video_widgets.dart';

final GetIt getIt = GetIt.instance;

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return VideoView();
  }
}

class VideoView extends StatefulWidget {
  factory VideoView({Key? key}) {
    const demoFilePath =
        'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4';
    String _filePath = '';
    if (getIt<FlavorParams>().demo) _filePath = demoFilePath;
    if (getIt<AppParams>().args.isNotEmpty &&
        getIt<AppParams>().args[0].isNotEmpty) {
      _filePath = getIt<AppParams>().args[0];
    }
    return VideoView._(
      key: key,
      filePath: _filePath,
    );
  }

  const VideoView._({
    required this.filePath,
    super.key,
  });

  final String filePath;

  @override
  State<VideoView> createState() => VideoViewState();
}

class VideoViewState extends State<VideoView> {
  late final player = Player();
  late final controller = VideoController(player);

  bool disposePlayer = false;
  bool isCurrentlyPlaying = false;
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
    if (disposePlayer) return const Text('Player Disposed');

    return Mediaskeleton(
      body: widget.filePath.isNotEmpty
          ? StreamBuilder(
              stream: player.stream.videoParams,
              builder: (context, asyncSnapshot) {
                final videoParams = player.state.videoParams;
                late double aspect;

                double? safeDivide(num? a, num? b) =>
                    (a != null && b != null) ? a / b : null;

                aspect =
                    videoParams.aspect ??
                    safeDivide(videoParams.dw, videoParams.dh) ??
                    safeDivide(videoParams.w, videoParams.h) ??
                    safeDivide(player.state.width, player.state.height) ??
                    1;

                return MediaSkeletonFrame(
                  aspect: aspect,
                  child: Video(
                    controller: controller,
                    // controls: null,
                    fill: Colors.transparent,
                  ),
                );
              },
            )
          : Container(color: Colors.white),
      controls: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 2,
            thumbShape: const LineSliderThumbShape(),
            padding: kLRPaddingMargin,
          ),
          child: StreamBuilder(
            stream: player.stream.position,
            builder: (context, asyncSnapshot) {
              return Slider(
                max: player.state.duration.inMicroseconds.toDouble(),
                value: player.state.position.inMicroseconds.toDouble(),
                secondaryTrackValue: player.state.buffer.inMicroseconds
                    .toDouble(),
                onChangeStart: (_) => player.pause(),
                onChangeEnd: (_) => isCurrentlyPlaying ? player.play() : null,
                onChanged: (value) =>
                    player.seek(Duration(microseconds: value.toInt())),
              );
            },
          ),
        ),
        Padding(
          padding: kLRPaddingMargin,
          child: StreamBuilder(
            stream: player.stream.position,
            builder: (context, asyncSnapshot) {
              return VideoPanel_Timestamp(
                player.state.position,
                player.state.duration,
              );
            },
          ),
        ),
        const Padding(
          padding: kLRPaddingMargin,
          child: VideoPanel_Control(),
        ),
        Row(
          children: [
            FilledButton.tonal(
              onPressed: () {},
              child: const Text('Rate'),
            ),
          ],
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
    final videoViewState = VideoViewState.of(context);
    final controller = videoViewState.controller;
    final player = controller.player;

    return Row(
      mainAxisAlignment: .center,
      children: [
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
        StreamBuilder(
          stream: player.stream.rate,
          builder: (_, _) => IconButton(
            icon: const Icon(Icons.fast_rewind_rounded),
            onPressed: () {
              final rate = (player.state.rate) - 0.05;
              if (rate > 0) unawaited(player.setRate(rate));
            },
          ),
        ),
        StreamBuilder(
          stream: Rx.combineLatest2(
            player.stream.rate.startWith(player.state.rate),
            player.stream.playing.startWith(player.state.playing),
            (_, _) => true,
          ),
          builder: (_, _) => TextButton.icon(
            icon: player.state.playing
                ? const Icon(Icons.pause_rounded)
                : const Icon(Icons.play_arrow_rounded),
            label: Text(
              '${double.parse(player.state.rate.toStringAsFixed(3))}x',
            ),
            onPressed: () {
              videoViewState.isCurrentlyPlaying = !player.state.playing;
              unawaited(
                player.state.playing ? player.pause() : player.play(),
              );
            },
          ),
        ),
        StreamBuilder(
          stream: player.stream.rate,
          builder: (context, asyncSnapshot) {
            return IconButton(
              icon: const Icon(Icons.fast_forward_rounded),
              onPressed: () {
                final rate = (player.state.rate) + 0.25;
                if (rate > 0) unawaited(player.setRate(rate));
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz_rounded),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget switchIconTextButton({
    required Widget icon,
    required VoidCallback onPressed,
    Widget? label,
  }) {
    if (label != null) {
      return TextButton.icon(
        icon: icon,
        label: label,
        onPressed: onPressed,
      );
    }

    return IconButton(
      icon: icon,
      onPressed: onPressed,
    );
  }
}

class VideoPanel_Timestamp extends StatelessWidget {
  const VideoPanel_Timestamp(
    this.current,
    this.length, {
    super.key,
  });

  final Duration current;
  final Duration length;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTextStyle.merge(
      style: theme.textTheme.labelSmall,
      child: Row(
        mainAxisAlignment: .center,
        spacing: kPaddingMargin,
        children: [
          Text(duration2dayseconds(current)),
          const Text('/'),
          Text(duration2dayseconds(length)),
        ],
      ),
    );
  }

  String duration2dayseconds(Duration duration) {
    final day = duration.inDays;
    final iHours = duration.inHours % 24;
    final iMins = duration.inMinutes % 60;
    final iSecs = duration.inSeconds % 60;
    final iMs = duration.inMilliseconds % 1000;
    final iMcs = duration.inMicroseconds % 1000;

    final hours = iHours.toString().padLeft(2, '0');
    final mins = iMins.toString().padLeft(2, '0');
    final secs = iSecs.toString().padLeft(2, '0');
    final ms = iMs.toString().padLeft(3, '0');
    final mcs = iMcs.toString().padLeft(3, '0');

    var timestamps = '';

    if (day > 0) timestamps += '$day:'; // 31:23:59:59
    if (duration.inHours > 0) timestamps += '$hours:'; // 23:59:59
    if (duration.inMinutes > 0) timestamps += mins; // 59:59.999
    timestamps += ':$secs';
    if (duration.inMinutes <= 59) timestamps += '.$ms';
    if (duration.inSeconds <= 59) timestamps += "'$mcs"; // :00.999'999

    return timestamps;
  }
}
