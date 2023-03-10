import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_demo/login.dart';
import 'package:f_demo/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class reg extends StatefulWidget {
  late String id;
  reg({super.key, required this.id});

  @override
  State<reg> createState() => regState();
}

class regState extends State<reg> {
  final name = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String id = widget.id;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Registration"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'first');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Image.asset('asset/icon.png'),
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
                    decoration: InputDecoration(hintText: 'name'),
                    controller: name,
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
                    decoration: InputDecoration(hintText: 'email'),
                    controller: email,
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
                    decoration: InputDecoration(hintText: 'password'),
                    controller: pass,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () async {
                  void savesetting() {
                    final newsetting = setting(id: id);

                    print(newsetting);
                  }

                  setState(() async {
                    try {
                      final newUser = await _auth
                          .createUserWithEmailAndPassword(
                              email: email.text, password: pass.text)
                          .then((value) {
                        firebase
                            .collection(id)
                            .doc(id)
                            .collection('user')
                            .doc(_auth.currentUser!.uid)
                            .set({
                          'name': name.text,
                          'email': email.text,
                          'password': pass.text,
                          'uid': _auth.currentUser!.uid,
                        });
                      });

                      if (newUser != null) {
                        const snackBar = SnackBar(
                            content: Text("Registration successfully"));
                        await ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return login(id: id);
                        }));
                      }
                    } catch (e) {
                      print(e);
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(18, 89, 173, 1),
                    borderRadius: BorderRadiusDirectional.circular(
                      10.0,
                    ),
                    border: Border.all(width: 1),
                  ),
                  height: 60,
                  width: 190,
                  child: Center(
                    child: Text(
                      "Registration",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return login(id: id);
                  }));
                },
                child: Text("Already have an account"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
