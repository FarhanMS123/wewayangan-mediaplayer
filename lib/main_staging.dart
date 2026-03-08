import 'package:get_it/get_it.dart';
import 'package:wewayangan_mediapreview/app/app.dart';
import 'package:wewayangan_mediapreview/bootstrap.dart';

final GetIt getIt = GetIt.instance;

Future<void> main(List<String> args) async {
  getIt.registerSingleton<FlavorParams>(
    FlavorParams(
      flavor: 'staging',
      demo: false,
    ),
  );
  await bootstrap(() => const App(), args);
}
