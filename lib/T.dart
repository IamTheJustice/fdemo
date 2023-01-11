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
  // late List dropDownListData;
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
    // dropDownListData = [firebase.collection("Projects").doc().toString()];
  }

  @override
  Widget build(BuildContext context) {
    // print("data ${firebase.collection("Projects")}");
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Projects")
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView(children: [
                    SizedBox(
                      height: 50,
                      child: DropdownButton(
                          isDense: false,
                          value: dropDownValue,
                          isExpanded: true,
                          menuMaxHeight: 350,
                          items: [
                            DropdownMenuItem(
                              value: snapshot.data!.docs.toString(),
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    var data = snapshot.data!.docs[i];
                                    return Text(data['name']);
                                  }),
                            ),
                          ],
                          onChanged: (newvalue) {
                            setState(() {
                              print('a');
                              dropDownValue = newvalue!;
                            });
                          }),
                    ),
                  ]);
                  // return CircularProgressIndicator();
                  if (snapshot.hasData) {
                  } else {
                    const CircularProgressIndicator();
                  }
                }),
          )
        ],
      ),
    );
  }
}
