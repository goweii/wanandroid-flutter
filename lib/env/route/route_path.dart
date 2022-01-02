class RoutePath<T> {
  final String location;
  final T arguments;

  RoutePath({
    required this.location,
    required this.arguments,
  });

  bool get isRoot => location == '/';
}
