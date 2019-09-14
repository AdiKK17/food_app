import 'dart:convert';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, "items.db"),
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE things_to_buy(id INTEGER PRIMARY KEY NOT NULL,item TEXT NOT NULL)");
        }, version: 1);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> delete(String table, int id) async {
    final db = await DBHelper.database();
    db.delete(table,where: "id = $id");
    print("itworks");
  }
}
