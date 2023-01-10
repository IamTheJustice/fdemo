import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Addtask extends StatefulWidget {
  const Addtask({Key? key}) : super(key: key);

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  final task = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  final currentuser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(
                    6.0,
                  ),
                  border: Border.all(width: 1),
                ),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Add task'),
                  controller: task,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                setState(() async {
                  try {
                    firebase
                        .collection('user')
                        .doc()
                        .update({'task': task.text});
                  } catch (e) {
                    print(e);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(18, 89, 173, 1),
                  borderRadius: BorderRadiusDirectional.circular(
                    10.0,
                  ),
                  border: Border.all(width: 1),
                ),
                height: 60,
                width: 190,
                child: Center(
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
