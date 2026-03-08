class AppParams {
  AppParams({required this.args});

  final List<String> args;
}

class FlavorParams {
  FlavorParams({required this.flavor, required this.demo});

  final String flavor;
  final bool demo;
}
