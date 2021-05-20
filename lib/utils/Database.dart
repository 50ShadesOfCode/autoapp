import 'dart:io';
import 'dart:async';

import 'package:auto_app/utils/FavModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static late Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    String path = join(docsDir.path, "autofavs.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Favs ("
          "url TEXT"
          ")");
    });
  }

  newFav(String url) async {
    print("inserted" + url);
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into Favs (url)"
        " VALUES (?)",
        [url]);
    print("ins");
    return raw;
  }

  deleteFav(String url) async {
    final db = await database;
    db.delete("Favs", where: "url = ?", whereArgs: [url]);
    print("deleted");
  }

  getAllClients() async {
    final db = await database;
    var res = await db.query("Favs");
    List<FavModel> list =
        res.isNotEmpty ? res.map((c) => FavModel.fromMap(c)).toList() : [];
    List<String> urls = [];
    for (FavModel ms in list) {
      urls.add(ms.url);
    }
    return urls;
  }
}
