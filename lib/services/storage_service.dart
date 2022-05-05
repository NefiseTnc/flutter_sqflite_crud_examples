import 'package:flutter_crud_examples/models/person_model.dart';

abstract class StorageService {
  Future<void> createData(Person person);
  Future<List<Person>> getDatas();
  Future<void> updateData(Person person);
  Future<void> deleteData(Person person);
}
