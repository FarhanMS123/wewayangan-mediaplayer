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
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: Theme.of(context).iconTheme.copyWith(
          color: Colors.white,
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      child: Stack(
        alignment: .topLeft,
        children: [
          Container(
            color: Colors.blueGrey,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: .topCenter,
                end: .bottomCenter,
                colors: [
                  Colors.black,
                  Color(0x01000000),
                ],
              ),
            ),
            child: YaruTile(
              leading: YaruIconButton(
                onPressed: onBack,
                icon: const Icon(
                  YaruIcons.go_previous,
                ),
              ),
              title: const Text('Song Title'),
              subtitle: const Text('Filename'),
              trailing: YaruIconButton(
                onPressed: () {},
                icon: const Icon(YaruIcons.view_more),
              ),
            ),
          ),
          // Row(
          //   children: [
          //     ,
          //   ],
          // ),
          // const Positioned(
          //   child: Column(
          //     children: [],
          //   ),
          // ),
        ],
      ),
    );
  }
}
