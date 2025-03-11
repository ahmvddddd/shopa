

// import 'package:get_storage/get_storage.dart';

// class TLocalStorage {
//   static final TLocalStorage _instance= TLocalStorage.internal();

//   factory TLocalStorage() {
//     return _instance;
//   }

//   TLocalStorage._();

//   final _storage = GetStorage();

//   //Generic method to save data
//   Future<void> saveData<T>(String key, T value) async {
//     await _storage.write(key, value);
//   }

//   //Generic method to rea data
//   T? readData<T>(String key) {
//     return _storage.read<T>(key);
// }

//   //Generic method to remove data
//    Future<void> removeData(String key) async {
//     await _storage.remove(key);
//    }

//    //clear all data in storage
//   Future<void> clearAll() async {
//     await _storage.erase();
//   }
// }