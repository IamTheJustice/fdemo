import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_demo/T.dart';
import 'package:f_demo/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class curruntProject extends StatefulWidget {
  late String id;
  curruntProject({required this.id});

  @override
  State<curruntProject> createState() => _curruntProjectState();
}

class _curruntProjectState extends State<curruntProject> {
  @override
  Widget build(BuildContext context) {
    var id = widget.id;
    return Scaffold(
      appBar: AppBar(
        title: Text("Project List"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: //Here is my code.
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(id)
                        .doc(id)
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
                                      color: Colors.yellow,
                                      width: double.infinity,
                                      child: Column(
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
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return Task(
                                                      id: id,
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
