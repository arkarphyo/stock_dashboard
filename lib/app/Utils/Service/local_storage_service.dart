import 'package:get_storage/get_storage.dart';

class LocalStorageServices {
  static final LocalStorageServices _localStorageServices =
      LocalStorageServices._internal();

  factory LocalStorageServices() {
    return _localStorageServices;
  }

  LocalStorageServices._internal();
  final box = GetStorage();

  //Write Data
  void writeData(String key, value) {
    box.write(key, value);
  }

  //Read Data
  String readData(String key) {
    return box.read(key) ?? '';
  }

  void removeData(String key) {
    box.remove(key);
  }
}
