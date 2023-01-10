import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  late String email;
  final firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                  // child: Image.asset('asset/icon.png'),
                  ),
              SizedBox(
                height: 200,
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
                    decoration: InputDecoration(hintText: 'enter email'),
                    onChanged: (value) {
                      email = value;
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
                      await _auth.sendPasswordResetEmail(email: email);
                      final snackBar =
                          SnackBar(content: Text("email send successfully"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } catch (e) {
                      print(e);
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(18, 89, 173, 1),
                    borderRadius: BorderRadiusDirectional.circular(
                      10.0,
                    ),
                    border: Border.all(width: 1),
                  ),
                  height: 60,
                  width: 190,
                  child: Center(
                    child: Text(
                      "Send Email",
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
        ),
      ),
    );
  }
}
