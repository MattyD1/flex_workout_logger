enum Flavor {
  local,
  development,
  staging,
  production,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.local:
        return 'Flex';
      case Flavor.development:
        return 'Flex Development';
      case Flavor.staging:
        return 'Flex Staging';
      case Flavor.production:
        return 'Flex Production';
      default:
        return 'title';
    }
  }

}
