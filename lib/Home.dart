import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_demo/currentproject.dart';
import 'package:f_demo/invite.dart';
import 'package:f_demo/process.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  late String id;
  Home({required this.id});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final currentuser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var id = widget.id;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("user")
                    .where('uid', isEqualTo: currentuser.currentUser!.uid)
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
                                width: double.infinity,
                                color: Colors.grey,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(data['name']),
                                    const SizedBox(height: 10),
                                    Text(data['email']),
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
            const Divider(),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return curruntProject(id: id);
                  }));
                },
                child: Text("TO DO")),
            const Divider(),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Process(id: id);
                  }));
                },
                child: Text("IN PROCESS")),
            const Divider(),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Invite(id: id);
                  }));
                },
                child: Text("INVITE")),
            const Divider(),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'AddProject');
                },
                child: Text("ADD PROJECT")),
            Divider(),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'T');
                },
                child: Text("PROJECT LIST")),
            Divider(),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'dashboard');
                },
                child: Text("DASH BOARD"))
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Projecture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Image(
              width: 300,
              height: 300,
              image: NetworkImage(
                  'https://seeklogo.com/images/F/firebase-logo-402F407EE0-seeklogo.com.png'),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Firebase Realtime Database Series in Flutter 2022',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
