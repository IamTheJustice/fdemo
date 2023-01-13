import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_demo/currentprocess.dart';
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
        title: const Text('PROCESS PROJECT LIST'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: //Here is my code.
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("user")
                        .doc(currentuser.currentUser!.uid)
                        .collection("Current Project")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              //  var name = snapshot.data!.docs[i].get('name');

                              var data = snapshot.data!.docs[i];

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 50,
                                      color: Colors.yellow,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            data['Project Name'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            width: 160,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return CurrentProcess(
                                                      var2:
                                                          data['Project Name']);
                                                }));
                                              },
                                              child: Text("SHOW TASK"))
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
          )
        ],
      ),
    );
  }
}
