import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String databaseTableName = 'Card';
  List list = [];
  createDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseTableName);

    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Card (id INTEGER PRIMARY KEY, title TEXT,subTitle TEXT,time Text)');
    });
  }

  insertData(String title, String subTitle, String time, int color) async {
    var db = await openDatabase(databaseTableName);

    await db.rawInsert('INSERT INTO Notes(title,subTitle,time) VALUES(?,?,?)',
        [title, subTitle, time, color]);
    getData();
    db.close();
  }

  updateData(int id, String title, String subTitle, String time) async {
    var db = await openDatabase(databaseTableName);
    final data = {
      'title': title,
      'subTitle': subTitle,
      'time': time,
    };
    await db.update('Notes', data, where: 'id = ?', whereArgs: [id]);
    getData();
    db.close();
  }

  getData() async {
    var db = await openDatabase(databaseTableName);
    await db.rawQuery('SELECT * FROM Notes').then((value) => list = value);
    db.close();
  }

  deleteData(int id) async {
    var db = await openDatabase(databaseTableName);
    await db.rawDelete('DELETE FROM Notes WHERE id = ?', [id]);
    getData();
    db.close();
  }
}
