import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_demo/Home.dart';
import 'package:f_demo/T.dart';
import 'package:f_demo/global.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatefulWidget {
  late String id;
  login({required this.id});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String userid = widget.id;
    late String abcd;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Login"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'first');
          },
          icon: const Icon(Icons.arrow_back),
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
                    decoration: InputDecoration(hintText: 'email'),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                ),
              ),
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
                    decoration: const InputDecoration(hintText: 'password'),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  setState(() async {
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);

                      if (newUser != null) {
                        final QuerySnapshot result = await FirebaseFirestore
                            .instance
                            .collection(userid)
                            .doc(userid)
                            .collection('user')
                            .get();
                        final List<DocumentSnapshot> documents = result.docs;

                        for (var DOC in documents) {
                          print(DOC.id);
                          abcd = DOC.id;
                        }

                        if (abcd == currentuser.currentUser!.uid) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Home(id: userid);
                          }));
                        } else {
                          const snackBar = SnackBar(content: Text('error'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    } catch (e) {
                      final snackBar = SnackBar(content: Text(e.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      print(e);
                    }
                    print(currentuser.currentUser!.uid);
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
                  width: 120,
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'Forgot');
                },
                child: Text("Forgot password"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'SignUp');
                },
                child: Text(
                  "Don't have account ?",
                  style: TextStyle(color: global.function),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
