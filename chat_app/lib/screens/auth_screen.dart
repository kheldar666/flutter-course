import 'dart:io';

import 'package:chat_app/models/auth_mode.dart';
import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm),
      ),
    );
  }

  Future<void> _submitAuthForm({
    required String email,
    required String? username,
    required String password,
    required File? image,
    required AuthMode mode,
  }) async {
    UserCredential credential;

    try {
      if (mode == AuthMode.signup) {
        //Register
        credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //Upload the avatar to Firestore
        final imageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(credential.user!.uid + '.jpg');
        UploadTask uploadTask = imageRef.putFile(image!);

        var imageUrl = await (await uploadTask).ref.getDownloadURL();

        await _db.collection('users').doc(credential.user!.uid).set({
          'username': username,
          'email': email,
          'imageUrl': imageUrl.toString()
        });
      } else {
        //Login
        credential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } on FirebaseAuthException catch (error) {
      var message = 'An error occurred. Please check your credentials';
      if (error.message != null) {
        message = error.message.toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.black54,
        ),
      );
    } catch (error) {
      print(error);
    }
  }
}
