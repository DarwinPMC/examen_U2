// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Keytool command: keytool -list -v -alias androiddebugkey -keystore C:\Users\frank\.android\debug.keystore

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
String? name;
String? email;
String imageUrl = "";
String error = "";

Future<String?> signInWithGoogle() async {
  try {
    await _googleSignIn.signIn();
  } catch (err) {
    print("Error durante el inicio de sesión: $err");
    error = "Error durante el inicio de sesión: $err";
    // You might want to handle or log the error more appropriately here
    Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return null;
  }

  final GoogleSignInAccount? user = _googleSignIn.currentUser;

  if (user != null) {
    if (user.email != null && user.displayName != null) {
      name = user.displayName;
      email = user.email;
      imageUrl = user.photoUrl ?? "";
      print('Inicio de sesión con Google correctamente: $user');
      return '$user';
    } else {
      error = "Datos de usuario incompletos";
      Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  } else {
    error = "La usuario es nulo";
    Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return null;
  }
}

Future<void> signOutGoogle() async {
  await _googleSignIn.signOut();
  print("El usuario cerró sesión");
}
