import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wewayangan_mediapreview/video/video.dart';
import 'package:yaru/yaru.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: .dark,
      darkTheme:
          ThemeData.dark(
            useMaterial3: true,
          ).copyWith(
            colorScheme: .fromSeed(
              brightness: .dark,
              seedColor: Colors.grey[900]!,
              onSurface: Colors.white,
              onSurfaceVariant: Colors.white,
            ),
            textTheme: const TextTheme().apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
          PointerDeviceKind.trackpad,
        },
      ),
      home: const Material(
        type: .transparency,
        child: VideoPage(),
      ),
    );
  }
}
