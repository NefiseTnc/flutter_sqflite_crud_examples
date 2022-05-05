import 'package:flutter/material.dart';
import 'package:flutter_crud_examples/main.dart';
import 'package:flutter_crud_examples/models/person_model.dart';
import 'package:flutter_crud_examples/services/storage_service.dart';

class AddPersonPage extends StatefulWidget {
  const AddPersonPage({Key? key}) : super(key: key);

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  final StorageService _storageService = getIt<StorageService>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCntr = TextEditingController();
  final TextEditingController _numberCntr = TextEditingController();

  @override
  void dispose() {
    _nameCntr.dispose();
    _numberCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Person')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildForm(),
      ),
    );
  }

  Form buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameCntr,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Person name',
                suffixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _numberCntr,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Phone Number',
                suffixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (value.length != 11) {
                  return 'Invalid phone number please try again';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Person newPerson = Person(
                            personName: _nameCntr.text,
                            phoneNumber: _numberCntr.text);

                        await _storageService.createData(newPerson);
                        Navigator.pop(context);
                      }
                    }))
          ],
        ));
  }
}
