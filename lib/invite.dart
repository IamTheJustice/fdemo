import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_demo/global.dart';
import 'package:f_demo/model.dart';
import 'package:f_demo/preference_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Invite extends StatefulWidget {
  late String id;
  Invite({required this.id});

  @override
  State<Invite> createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var col = "";
    final currentuser = FirebaseAuth.instance;
    final firebase = FirebaseFirestore.instance;
    void getvalue() async {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        var uid = (prefs.getString('userid'));
      });
    }

    var id = widget.id;

    return Scaffold(
        appBar: AppBar(
          title: const Text('INVITE'),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(id)
                      .doc(id)
                      .collection("user")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("Invite")
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
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(width: 3),
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Project Name :" +
                                              data['PROJECT NAME'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          "Platform :" + data['PLATFORM'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          "Description :" + data['DESCRIPTION'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CupertinoAlertDialog(
                                                      title: const Text(
                                                          "Are you sure want to accept invite ?"),
                                                      actions: [
                                                        CupertinoDialogAction(
                                                          child:
                                                              const Text("YES"),
                                                          onPressed: () {
                                                            firebase
                                                                .collection(id)
                                                                .doc(id)
                                                                .collection(
                                                                    "user")
                                                                .doc(currentuser
                                                                    .currentUser!
                                                                    .uid)
                                                                .collection(
                                                                    "Current Project")
                                                                .doc(data[
                                                                    "PROJECT NAME"])
                                                                .set({
                                                              "Project Name": data[
                                                                  'PROJECT NAME'],
                                                              "Platform ": data[
                                                                  'PLATFORM'],
                                                              "Description ": data[
                                                                  'DESCRIPTION'],
                                                              "Uid": data[
                                                                  "PROJECT NAME"]
                                                            });
                                                            firebase
                                                                .collection(id)
                                                                .doc(id)
                                                                .collection(data[
                                                                        'PROJECT NAME']
                                                                    .toString())
                                                                .doc(currentuser
                                                                    .currentUser!
                                                                    .uid)
                                                                .set({
                                                              "NAME":
                                                                  data['name'],
                                                              "Email":
                                                                  data['Email'],
                                                              "Uid": currentuser
                                                                  .currentUser!
                                                                  .uid,
                                                              //"EMAIL": data["email"],
                                                              //"EMAIL": data["email"],
                                                            }).whenComplete(
                                                                    () => {
                                                                          snapshot
                                                                              .data!
                                                                              .docs[i]
                                                                              .reference
                                                                              .delete()
                                                                        });

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        CupertinoDialogAction(
                                                          child: Text("NO"),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Text(
                                              "ACCEPT INVITATION",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            )),
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
            ),
          ],
        ));
  }
}
