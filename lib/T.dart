import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_demo/givetask.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class T extends StatefulWidget {
  T({Key? key}) : super(key: key);

  @override
  State<T> createState() => _TState();
}

final firebase = FirebaseFirestore.instance;
final currentuser = FirebaseAuth.instance;

class _TState extends State<T> {
  late List dropDownListData;

  String? dropDownValue;

  var selectedUbication;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dropDownListData = [firebase.collection("Projects").doc().toString()];
  }

  @override
  Widget build(BuildContext context) {
    // print("data ${firebase.collection("Projects")}");
    return Scaffold(
      appBar: AppBar(
        title: Text("PROJECT LIST"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: //Here is my code.
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Projects")
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
                                  Container(
                                    color: Colors.yellow,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          data['name'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return Givetask(
                                                    var1: data['name']);
                                              }));
                                            },
                                            child: Text("GIVE TASK"))
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
                        return const CircularProgressIndicator();
                      }
                    }),
          )
        ],
      ),
    );
  }
}
