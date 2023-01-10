import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Process extends StatefulWidget {
  const Process({Key? key}) : super(key: key);

  @override
  State<Process> createState() => _ProcessState();
}

class _ProcessState extends State<Process> {
  final currentuser = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Food App")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("Process")
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
                                  height: 80,
                                  color: Colors.yellow,
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        data['Task'],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
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
        ),
      ),
    );
  }
}
