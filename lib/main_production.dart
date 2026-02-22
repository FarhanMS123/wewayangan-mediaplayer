import 'package:wewayangan_mediapreview/app/app.dart';
import 'package:wewayangan_mediapreview/bootstrap.dart';

Future<void> main(List<String> args) async {
  await bootstrap(() => const App(), args);
}
