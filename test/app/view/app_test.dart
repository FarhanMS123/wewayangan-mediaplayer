// Ignore for testing purposes
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:wewayangan_mediapreview/app/app.dart';
import 'package:wewayangan_mediapreview/pages/video/video.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(VideoPage), findsOneWidget);
    });
  });
}
