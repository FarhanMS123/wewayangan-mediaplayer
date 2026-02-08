import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wewayangan_mediapreview/pages/video/video.dart';
import 'package:yaru/yaru.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const VideoView(),
    );
  }
}

class VideoView extends StatelessWidget {
  const VideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: .topCenter,
      fit: .expand,
      children: [
        Container(
          color: Colors.red,
        ),
        const Row(
          children: [],
        ),
        const Positioned(
          child: Column(
            children: [],
          ),
        ),
      ],
    );
  }
}
