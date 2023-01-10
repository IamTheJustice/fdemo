import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Invite extends StatefulWidget {
  const Invite({Key? key}) : super(key: key);

  @override
  State<Invite> createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  @override
  Widget build(BuildContext context) {
    final currentuser = FirebaseAuth.instance;
    final firebase = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('INVITE'),
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("user")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("Invite")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
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
                                    data['PROJECT NAME'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  Text(
                                    data['PLATFORM'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  Text(
                                    data['DESCRIPTION'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CupertinoAlertDialog(
                                                title: const Text(
                                                    "Are you sure want to start task ?"),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    child: const Text("YES"),
                                                    onPressed: () {
                                                      firebase
                                                          .collection(data[
                                                                  'PROJECT NAME']
                                                              .toString())
                                                          .doc(currentuser
                                                              .currentUser!.uid)
                                                          .set({
                                                        "NAME": data['name'],
                                                        "Email": data['Email'],
                                                        "Uid": currentuser
                                                            .currentUser!.uid,
                                                        //"EMAIL": data["email"],
                                                        //"EMAIL": data["email"],
                                                      });
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
