import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_demo/process.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final currentuser = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;
  // final id = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO'),
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Food App")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("Tasks")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        var data = snapshot.data!.docs[i];
                        return Column(
                          children: [
                            Container(
                              color: Colors.yellow,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    data['task'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CupertinoAlertDialog(
                                                title: Text(
                                                    "Are you sure want to start task ?"),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    child: Text("YES"),
                                                    onPressed: () {
                                                      firebase
                                                          .collection(
                                                              "Food App")
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .collection("Process")
                                                          .add({
                                                        "Task": data['task']
                                                      }).whenComplete(() => {
                                                                snapshot
                                                                    .data!
                                                                    .docs[i]
                                                                    .reference
                                                                    .delete()
                                                              });
                                                      Navigator.popAndPushNamed(
                                                          context, 'process');
                                                    },
                                                  ),
                                                  CupertinoDialogAction(
                                                    child: Text("NO"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      child: Text("START")),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                          ],
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}
