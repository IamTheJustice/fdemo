import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final Project = TextEditingController();
  final Platform = TextEditingController();
  final discription = TextEditingController();
  bool value = false;
  List<String> temparray = [];

  @override
  Widget build(BuildContext context) {
    final task = TextEditingController();
    final firebase = FirebaseFirestore.instance;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(
                  6.0,
                ),
                border: Border.all(width: 1),
              ),
              child: TextFormField(
                controller: Project,
                decoration: const InputDecoration(hintText: 'Project Name'),
                onChanged: (value) {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(
                  6.0,
                ),
                border: Border.all(width: 1),
              ),
              child: TextFormField(
                controller: Platform,
                decoration: const InputDecoration(hintText: 'Editing Platform'),
                onChanged: (value) {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(
                  6.0,
                ),
                border: Border.all(width: 1),
              ),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: discription,
                decoration: const InputDecoration(hintText: 'Description'),
                onChanged: (value) {},
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                firebase
                    .collection("Projects")
                    .doc()
                    .set({'name': Project.text});
              },
              child: Text("Add project")),
          Expanded(
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("user").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          var uid = snapshot.data!.docs[i].get('uid');
                          var data = snapshot.data!.docs[i];
                          return InkWell(
                            onTap: () {
                              snapshot.data!.docs[i].reference
                                  .collection('Invite')
                                  .add({
                                'Email': data['email'],
                                'name': data['name'],
                                'PROJECT NAME': Project.text,
                                'PLATFORM': Platform.text,
                                'DESCRIPTION': discription.text,
                              });

                              setState(() {
                                if (temparray.contains(data['uid'])) {
                                  temparray.remove(data['uid']);
                                } else {
                                  temparray.add(data['uid']);
                                }
                              });
                            },
                            child: ListTile(
                                title: Text(data['name']),
                                subtitle: Text(data['email']),
                                trailing: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: temparray.contains(data['uid'])
                                          ? Colors.red
                                          : Colors.green),
                                  child: Center(
                                      child: Text(
                                    temparray.contains(data['uid'])
                                        ? 'REMOVE'
                                        : 'ADD',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                )),
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
