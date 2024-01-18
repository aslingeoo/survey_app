import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:survey_app_acs/dao/userDao.dart';
import 'package:survey_app_acs/modal/user.dart';

class HiveHelper {
  static initDatabase() async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // Directory? documentsDirectory = Platform.isAndroid
    //     ? await getExternalStorageDirectory()
    //     : await getApplicationDocumentsDirectory();
    // Hive.init(documentsDirectory!.path + "/hive");
    await Hive.initFlutter();
    await HiveHelper._registerHiveAdapters();
  }

  static _registerHiveAdapters() async {
    Hive.registerAdapter<user>(userAdapter());
    HiveHelper._createBox();
  }

  static Future<void> _createBox() async {
    await UsersDao.instance.database;
  }
}
