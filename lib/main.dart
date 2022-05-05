import 'package:flutter/material.dart';
import 'package:flutter_crud_examples/services/sqflite_service.dart';
import 'package:flutter_crud_examples/services/storage_service.dart';
import 'package:flutter_crud_examples/views/home_page.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<StorageService>(SqfLiteService());
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home:  const HomePage(),
    );
  }
}
