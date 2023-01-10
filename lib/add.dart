import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final task = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Food App")
                    .snapshots(),
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
                                                  snapshot
                                                      .data!.docs[i].reference
                                                      .collection('Tasks')
                                                      .add({
                                                    'task': task.text
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
