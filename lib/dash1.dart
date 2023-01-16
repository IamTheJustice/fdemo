import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dash1 extends StatefulWidget {
  String var1;
  Dash1({required this.var1});

  @override
  State<Dash1> createState() => _Dash1State();
}

class _Dash1State extends State<Dash1> {
  @override
  Widget build(BuildContext context) {
    String var1 = widget.var1;
    return Scaffold(
      appBar: AppBar(
        title: Text("ABOUT"),
      ),
      body: Column(
        children: [
          Container(
              height: 50,
              color: Colors.grey,
              child: Center(
                  child: Text(
                var1,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25),
              ))),
        ],
      ),
    );
  }
}
