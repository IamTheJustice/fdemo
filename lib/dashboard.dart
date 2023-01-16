import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_demo/dash1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DASHBOARD"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('user').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          var data = snapshot.data!.docs[i];
                          return ListTile(
                            title: Text(data['name']),
                            subtitle: Text(data['email']),
                            trailing: IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Dash1(var1: data['name']);
                                }));
                              },
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
    );
  }
}
