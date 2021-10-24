import 'dart:io';
//import 'package:api_to_sqlite_flutter/src/models/employee_model.dart';
import 'package:adoodlz/blocs/models/post.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    // ignore: join_return_with_assignment
    _database = await initDB();

    return _database;
  }

  // Create the database and the Post table
  Future<Database> initDB() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'posts_manager.db');

    // ignore: unnecessary_await_in_return
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      // ignore: missing_whitespace_between_adjacent_strings
      await db.execute('CREATE TABLE Post('
          // ignore: missing_whitespace_between_adjacent_strings
          'id INTEGER PRIMARY KEY,'
          // ignore: missing_whitespace_between_adjacent_strings
          'email TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'firstName TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'lastName TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'avatar TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'dbId TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'title TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'url TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'media TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'content TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'corpId TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'goals TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'status TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'createdAt TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'expireAt TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'tags TEXT,'
          // ignore: missing_whitespace_between_adjacent_strings
          'stats TEXT'
          ')');
    });
  }

  // Insert employee on database
  createPost(Post newPost) async {
    await deleteAllPosts();
    final db = await database;
    final res = await db.insert('Post', newPost.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllPosts() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Post');

    return res;
  }

  Future<List<Post>> getAllPosts() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM POST");

    List<Post> list =
        res.isNotEmpty ? res.map((c) => Post.fromJson(c)).toList() : [];

    return list;
  }
}
