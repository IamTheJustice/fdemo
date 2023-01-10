import 'package:f_demo/Addproject.dart';
import 'package:f_demo/Home.dart';
import 'package:f_demo/T.dart';
import 'package:f_demo/add.dart';
import 'package:f_demo/addtask.dart';
import 'package:f_demo/forgot.dart';
import 'package:f_demo/invite.dart';
import 'package:f_demo/process.dart';
import 'package:f_demo/login.dart';
import 'package:f_demo/singup.dart';
import 'package:f_demo/task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(brightness: Brightness.light),
    debugShowCheckedModeBanner: false,
    initialRoute: 'T',
    routes: {
      'login': (context) => const login(),
      'SignUp': (context) => const reg(),
      'Home': (context) => const Home(),
      'Add': (context) => const Add(),
      'Addtask': (context) => const Addtask(),
      'Task': (context) => const Task(),
      'Forgot': (context) => const Forgot(),
      'process': (context) => const Process(),
      'AddProject': (context) => const AddProject(),
      'Invite': (context) => Invite(),
      'T': (context) => T(),
    },
  ));
}
