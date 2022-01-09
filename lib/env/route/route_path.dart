import 'package:equatable/equatable.dart';

class RoutePath<T> extends Equatable {
  final String location;
  final T arguments;

  const RoutePath({
    required this.location,
    required this.arguments,
  });

  bool get isRoot => location == '/';

  @override
  List<Object?> get props => [
        location,
        arguments,
      ];
}
