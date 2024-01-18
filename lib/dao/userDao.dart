import 'package:get/get.dart';
import 'package:hive/hive.dart';

class UsersDao {
  Box? _database;

    static final UsersDao _singleton = UsersDao._();
  static UsersDao get instance => _singleton;
  UsersDao._();

  Future<Box?> get database async {
    _database = _database ?? await _openDatabase();
    return _database;
  }

  _openDatabase() async {
    return await Hive.openBox("UsersBox");
  }

  clearDatabase() async {
    return await _database?.clear() ?? (await _openDatabase()).clear();
  }

  Future<void> insertOrUpdate(String uid, value) async {
    String id = "user$uid";
    await _database!.put(id, value);
  }

  get(String uid) async {
    String id = "user$uid";
    return await _database!.get(id);
  }
}
