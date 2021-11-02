import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider {
  final FirebaseAuth firebaseAuth;
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Instancia de Firebase

  AuthenticationProvider(this.firebaseAuth);
//Constructor para incicializar la instancia de Firebase

  //Usamos Stream para guardar el estado de la autenticación
  Stream<User?> get authState => firebaseAuth.idTokenChanges();

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final referenceDatabase = FirebaseDatabase.instance.reference();

  Future<User?> singInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await (googleSignIn.signIn());
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final GoogleAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken) as GoogleAuthCredential;

        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);

        final User user = userCredential.user!;

        //Creamos el usuario al logearnos en la base de datos

        if (!await rootFirebaseIsExist(
            referenceDatabase.child('Users').child(user.uid))) {
          referenceDatabase.child('Users').child(user.uid).set({
            'nombre': user.displayName.toString(),
            'email': user.email.toString()
          });
        }

        await referenceDatabase
            .child('Email_UserID')
            .child(user.uid)
            .set(user.email.toString());

        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> rootFirebaseIsExist(DatabaseReference databaseReference) async {
    DataSnapshot snapshot = await databaseReference.once();

    return snapshot.value != null;
  }

  void signOutGoogle() async {
    try {
      print("bien");

      await _auth.signOut();
    } catch (e) {
      print("problema");
    }
  }
}
