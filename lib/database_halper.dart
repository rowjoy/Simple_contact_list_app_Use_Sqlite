// ignore_for_file: avoid_print

import 'dart:io';

import 'package:contact_apps/usermodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateconstroter();
  static final DatabaseHelper instance = DatabaseHelper._privateconstroter();
  static Database? _database;
  Future<Database> get database async => _database ?? await _initdatabase();

  Future<Database> _initdatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, "contact.db");
    return await openDatabase(path, version: 1, onCreate: _onCreated);
  }

  Future _onCreated(Database db, int version) async {
    await db.execute("""
      CREATE TABLE contact(
        id INTEGER PRIMARY KEY,
        name TEXT,
        number TEXT,
        address TEXT
      )
      """);
  }

  Future<int> adduser(Usermodel usermodel) async {
    Database db = await instance.database;
    return await db.insert("contact", usermodel.toMap());
  }

  Future<List<Usermodel>> getuser() async {
    Database db = await instance.database;
    var user = await db.query("contact", orderBy: 'id');
    List<Usermodel> userlist = user.isNotEmpty
        ? user.map((data) => Usermodel.fromMap(data)).toList()
        : [];
    print('data list$userlist');

    return userlist;
  }

  Future<int> delete(int? id) async {
    Database db = await instance.database;
    return db.delete(
      "contact",
      where: "id= ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Usermodel usermodel) async {
    Database db = await instance.database;
    return db.update(
      "contact",
      usermodel.toMap(),
      where: "id = ?",
      whereArgs: [usermodel.id],
    );
  }
}
