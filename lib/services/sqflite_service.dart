import 'package:flutter_crud_examples/models/person_model.dart';
import 'package:flutter_crud_examples/services/storage_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfLiteService extends StorageService {
  String tblPerson = "person";
  String colId = "id";
  String colPersonName = "personName";
  String colPhoneNumber = "phoneNumber";

  Future<Database> initializeDb() async {
    String filePath = 'todos.db';
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    var dbPersons = openDatabase(path, version: 1, onCreate: _createDb);
    return dbPersons;
  }

  Future<void> _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblPerson($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colPersonName TEXT,"
        "$colPhoneNumber TEXT"
        ")");
  }

  @override
  Future<void> createData(Person person) async {
    final _database = await initializeDb();
    await _database.insert(tblPerson, person.toJson());
  }

  @override
  Future<List<Person>> getDatas() async {
    final _database = await initializeDb();
    List<Person> personList = [];
    var result = await _database
        .rawQuery("SELECT * FROM $tblPerson ORDER BY $colPersonName ASC");
    for (var element in result) {
      personList.add(Person.fromJson(element));
    }
    return personList;
  }

  @override
  Future<void> updateData(Person person) async {
    final _database = await initializeDb();
    _database.update(tblPerson, person.toJson(),
        where: "$colId = ? ", whereArgs: [person.id]);
  }

  @override
  Future<void> deleteData(Person person) async {
    final _database = await initializeDb();
    await _database
        .delete(tblPerson, where: "$colId = ? ", whereArgs: [person.id]);
  }
}
