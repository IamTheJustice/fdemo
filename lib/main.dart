import 'package:f_demo/Addproject.dart';
import 'package:f_demo/Home.dart';
import 'package:f_demo/T.dart';
import 'package:f_demo/add.dart';
import 'package:f_demo/companylist.dart';
import 'package:f_demo/currentproject.dart';
import 'package:f_demo/dashboard.dart';

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
    initialRoute: 'companylist',
    routes: {
      'companylist': (context) => const company(),
      'Add': (context) => const Add(),
      'Forgot': (context) => const Forgot(),
      'AddProject': (context) => const AddProject(),
      'T': (context) => T(),
      'dashboard': (context) => const DashBoard(),
    },
  ));
}
