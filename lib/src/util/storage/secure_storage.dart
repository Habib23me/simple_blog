import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

class SecureStorage {
  final FlutterSecureStorage storage;

  SecureStorage({@required this.storage});

  Future<String> read(String key) => storage.read(key: key);

  Future<void> write(
    String key,
    String value,
  ) =>
      storage.write(key: key, value: value);

  Future<void> delete(String key) => storage.delete(key: key);
}
