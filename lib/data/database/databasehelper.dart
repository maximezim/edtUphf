import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:edt/data/models/lecon.dart';
import 'package:edt/data/models/jour.dart';
import 'package:edt/data/utils/datehelper.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static DatabaseHelper instance = DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'lecon.db'),
      onCreate: (db, version) {
        return db.execute(
          """
            CREATE TABLE Lecon(
              nom VARCHAR(50),
              type VARCHAR(10),
              salle VARCHAR(20),
              prof VARCHAR(50),
              horaire VARCHAR(20),
              date VARCHAR(30),
              infos VARCHAR(100),
              PRIMARY KEY(nom, type, salle, horaire, date)
            )
          """,
        );
      },
      version: 1,
    );
  }

  Future<void> insertSchoolDay(SchoolDay schoolDay, DateTime date) async {
    final db = await database;
    await deleteSchoolDay(date);
    for (final lesson in schoolDay.lessons) {
      lesson.date = date;
      await db.insert(
        'Lecon',
        lesson.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> deleteSchoolDay(DateTime date) async {
    final db = await database;
    await db.delete(
      'Lecon',
      where: 'date = ?',
      whereArgs: [DateHelper.convertDateTimeToSQLFormat(date)],
    );
  }

  Future<SchoolDay> getSchoolDay(DateTime date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Lecon',
        where: 'lower(date) = ?',
        whereArgs: [DateHelper.convertDateTimeToSQLFormat(date)]);
    return SchoolDay(
      date,
      maps.map((m) => Lecon.fromMap(m)).toList(),
    );
  }

  Future<void> delete() async {
    deleteDatabase(join(await getDatabasesPath(), 'Lecon.db'));
    _database = null;
  }
}
