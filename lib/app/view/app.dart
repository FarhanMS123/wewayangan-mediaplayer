import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wewayangan_mediapreview/pages/video/video.dart';
import 'package:yaru/yaru.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: .dark,
      theme: yaruLight,
      darkTheme: yaruDark,
      highContrastTheme: yaruHighContrastLight,
      highContrastDarkTheme: yaruHighContrastDark,
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
      home: const VideoPage(),
    );
  }
}
