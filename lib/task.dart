import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_demo/process.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  String var2;
  Task({required this.var2});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final currentuser = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;
  // final id = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    String var2 = widget.var2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO'),
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("user")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("Current Project")
                  .doc(var2)
                  .collection("Task")
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.yellow,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      data['Task'],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 200,
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
                                                            .collection(var2)
                                                            .doc(var2)
                                                            .collection(
                                                                'Process')
                                                            .doc()
                                                            .set({
                                                          'task': data['Task']
                                                        });

                                                        firebase
                                                            .collection("user")
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid)
                                                            .collection(
                                                                "Current Project")
                                                            .doc(var2)
                                                            .collection(
                                                                "Process")
                                                            .add({
                                                          "Task": data['Task']
                                                        }).whenComplete(() => {
                                                                  snapshot
                                                                      .data!
                                                                      .docs[i]
                                                                      .reference
                                                                      .delete()
                                                                });
                                                        Navigator
                                                            .popAndPushNamed(
                                                                context,
                                                                'process');
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
