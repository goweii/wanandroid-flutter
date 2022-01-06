import 'package:flutter/material.dart';

class ObservableData<T> extends ValueNotifier<T> {
  ObservableData(T value) : super(value);
}