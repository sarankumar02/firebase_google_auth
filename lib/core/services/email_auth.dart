import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:playonn_user/core/screens/dummyscreen.dart';
import 'package:playonn_user/core/screens/signin.dart';
import 'package:playonn_user/core/screens/registration.dart';

Future<void> signUpWithEmailIdAndPassword(
    _formkey, _email, _password, context) async {
  final formState = _formkey.currentState;
  if (formState.validate()) {
    formState.save();
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Signin()));
    } catch (e) {
      print(e.message);
    }
  }
}

Future<void> signInWithEmailIdAndPassword(
    _formkey, email, password, context) async {
  final formState = _formkey.currentState;
  if (formState.validate()) {
    formState.save();
    try {
      handleSignInEmail(email, password);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DummyScreen()));
    } catch (e) {
      print(e.message);
    }
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;

Future<FirebaseUser> handleSignInEmail(email, password) async {
  AuthResult result =
      await auth.signInWithEmailAndPassword(email: email, password: password);
  final FirebaseUser user = result.user;

  assert(user != null);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await auth.currentUser();
  assert(user.uid == currentUser.uid);

  print('signInEmail succeeded: $user');

  return user;
}
