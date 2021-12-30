import 'package:event_bus/event_bus.dart';

class Bus {
  static final Bus _instance = Bus._();

  Bus._();

  factory Bus() => _instance;

  final EventBus _eventBus = EventBus();

  Stream<T> on<T>() {
    return _eventBus.on<T>();
  }

  void send(event) {
    _eventBus.fire(event);
  }
}
