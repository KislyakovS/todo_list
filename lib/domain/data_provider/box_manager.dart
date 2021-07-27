import 'package:hive_flutter/hive_flutter.dart';

class BoxManager {
  Future<Box<T>> _openBox<T>(String name, int typeId, TypeAdapter<T> adapter) {
    if (Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }

    return Hive.openBox<T>(name);
  }
}
