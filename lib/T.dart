import 'dart:core';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  // {
  //   'title':
  //       FirebaseFirestore.instance.collection("Projects").doc().toString(),
  //   'value': '1'
  // }

  String? dropDownValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropDownListData = [firebase.collection("Projects").doc().toString()];
  }

  @override
  Widget build(BuildContext context) {
    print("data ${firebase.collection("Projects")}");
    return Scaffold(
        // body: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     SizedBox(
        //       height: 50,
        //       child: ListView(
        //         children: [
        //           DropdownButton<String>(
        //               isDense: true,
        //               value: dropDownValue,
        //               isExpanded: true,
        //               menuMaxHeight: 350,
        //               items: [
        //                 DropdownMenuItem(
        //                   child: Text("Select course"),
        //                   value: "Select course",
        //                 ),
        //                 ...dropDownListData.map<DropdownMenuItem<String>>((e) {
        //                   return DropdownMenuItem(
        //                     child: StreamBuilder(
        //                       stream: firebase
        //                           .collection('Projects')
        //                           .doc()
        //                           .snapshots(),
        //                       builder: (BuildContext context,
        //                           AsyncSnapshot<dynamic> snapshot) {
        //                         if (snapshot.hasData) {
        //                           return ListView.builder(
        //                               itemCount: snapshot.data!.docs.length,
        //                               itemBuilder: (context, i) {
        //                                 var data = snapshot.data!.docs[i];
        //                                 return Text(data['name']);
        //                               });
        //                         }
        //                         return const CircularProgressIndicator();
        //                       },
        //                     ),
        //                     value: e['value'],
        //                   );
        //                 })
        //               ],
        //               onChanged: (newvalue) {
        //                 log("selected value ====${newvalue}");
        //                 setState(() {
        //                   dropDownValue = newvalue!;
        //                 });
        //               })
        //         ],
        //       ),
        //     )
        //   ],
        // ),
        );
  }
}
