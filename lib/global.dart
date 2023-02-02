import 'package:f_demo/singup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class global {
  static var function = Colors.red;
  // static var id = regState.id;
  static String id = regState().widget.id.toString();
}
