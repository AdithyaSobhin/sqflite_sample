import 'package:sqflite/sqflite.dart';

class HomeScreenController {
  static List myDataList = [];
  static late Database database;

  static Future<void> initDb() async {
    database = await openDatabase("mydb.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Employees (id INTEGER PRIMARY KEY, name TEXT, designation TEXT)');
    });
  }

  static Future<void> addEmployee(
      {required String name, required String designation}) async {
    await database.rawInsert(
        'INSERT INTO Employees(name,designation) VALUES(?, ?)',
        [name, designation]);
  }

  static Future<void> deleteEmployee(var id) async {
    await database.rawDelete('DELETE FROM Employees WHERE id = ?', ['$id']);
    await getEmployee();
  }

  static Future<void> getEmployee() async {
    List<Map> list = await database.rawQuery('SELECT * FROM Employees');
    print(list);
    myDataList = list;
  }

  Future<void> updateEmployee() async {
    await database.rawUpdate(
        'UPDATE Employees SET id = ?, value = ? WHERE name = ?',
        ['updated name', '9876', 'some name']);
  }
}
