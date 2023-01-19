import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_demo/login.dart';
import 'package:f_demo/singup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class company extends StatefulWidget {
  const company({Key? key}) : super(key: key);

  @override
  State<company> createState() => _companyState();
}

class _companyState extends State<company> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("company list")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              var data = snapshot.data!.docs[i];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return reg(id: data['uid']);
                                    }));
                                  },
                                  child: Container(
                                    height: 45,
                                    color: Colors.redAccent,
                                    child: Center(
                                        child: Text(
                                      data['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    )),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
