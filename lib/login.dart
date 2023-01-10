import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Login"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'first');
          },
          icon: Icon(Icons.arrow_back),
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
                        Navigator.pushNamed(context, 'Home');
                      }
                    } catch (e) {
                      final snackBar = SnackBar(content: Text(e.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                child: Text("Don't have account ?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
