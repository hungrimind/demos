bool matchRoute(String pattern, String path) {
  final pathSegments = path.split('/').where((s) => s.isNotEmpty).toList();
  final patternSegments = getSegments(pattern);

  if (patternSegments.length != pathSegments.length) return false;

  for (var i = 0; i < patternSegments.length; i++) {
    if (patternSegments[i].startsWith(':')) continue;
    if (patternSegments[i] != pathSegments[i]) return false;
  }

  return true;
}

String findMatchingRoutePattern(String path, List<String> routes) {
  final route = routes.firstWhere(
    (route) => matchRoute(route, path),
    orElse: () => routes.firstWhere((route) => route == '/404'),
  );
  return route;
}

/// Splits a path into segments, filtering out empty segments
List<String> getSegments(String path) =>
    path.split('/').where((s) => s.isNotEmpty).toList();
