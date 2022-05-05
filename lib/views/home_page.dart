import 'package:flutter/material.dart';
import 'package:flutter_crud_examples/main.dart';
import 'package:flutter_crud_examples/models/person_model.dart';
import 'package:flutter_crud_examples/services/storage_service.dart';
import 'package:flutter_crud_examples/views/add_person_page.dart';
import 'package:flutter_crud_examples/views/update_person_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StorageService _storageService = getIt<StorageService>();
  List<Person> personList = [];

  Future<void> getDataList() async {
    personList = await _storageService.getDatas();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getDataList();
    return Scaffold(
      appBar: AppBar(title: const Text('Crud Examples')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildListviewBuilderDatas(),
      ),
      floatingActionButton: buildFlattingAddButton(),
    );
  }

  ListView buildListviewBuilderDatas() {
    return ListView.builder(
      itemCount: personList.length,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          endActionPane: ActionPane(motion: const ScrollMotion(), children: [
            SlidableAction(
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
                onPressed: (_) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdatePersonPage(
                          person: personList[index],
                        ),
                      ));
                }),
            SlidableAction(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                onPressed: (_) async {
                  await _storageService.deleteData(personList[index]);
                })
          ]),
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${personList[index].id}'),
              ),
              title: Text('${personList[index].personName}'),
              subtitle: Text('${personList[index].phoneNumber}'),
            ),
          ),
        );
      },
    );
  }

  FloatingActionButton buildFlattingAddButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddPersonPage(),
          ),
        );
      },
    );
  }
}
