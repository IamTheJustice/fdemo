import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_demo/T.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Givetask extends StatefulWidget {
  String var1;
  Givetask({required this.var1});

  @override
  State<Givetask> createState() => _GivetaskState();
}

class _GivetaskState extends State<Givetask> {
  @override
  Widget build(BuildContext context) {
    String var1 = widget.var1;
    final task = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('GIVE TASK'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection(var1).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          var data = snapshot.data!.docs[i];
                          return ListTile(
                            leading: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                          child: ListView(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .circular(
                                                      6.0,
                                                    ),
                                                    border:
                                                        Border.all(width: 1),
                                                  ),
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Add task'),
                                                    controller: task,
                                                  ),
                                                ),
                                              ),
                                              MaterialButton(
                                                onPressed: () async {
                                                  FirebaseFirestore.instance
                                                      .collection(var1)
                                                      .doc(var1)
                                                      .collection('task')
                                                      .add({'task': task.text});
                                                  FirebaseFirestore.instance
                                                      .collection("user")
                                                      .doc(currentuser
                                                          .currentUser!.uid)
                                                      .collection(
                                                          'Current Project')
                                                      .doc(var1)
                                                      .collection("Task")
                                                      .add({
                                                    'Task': task.text
                                                  }).whenComplete(() => {
                                                            Navigator.pop(
                                                                context),
                                                          });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                        18, 89, 173, 1),
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .circular(
                                                      10.0,
                                                    ),
                                                    border:
                                                        Border.all(width: 1),
                                                  ),
                                                  height: 60,
                                                  width: 190,
                                                  child: const Center(
                                                    child: Text(
                                                      "Add",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 30,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ));
                              },
                            ),
                            title: Text(data['NAME']),
                            subtitle: Text(data['Email']),
                            trailing: IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {},
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
