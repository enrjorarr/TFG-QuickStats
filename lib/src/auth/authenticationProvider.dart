import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quick_stats/src/auth/authenticationProvider.dart';

class AuthenticationProvider {
  final FirebaseAuth firebaseAuth;
  final FirebaseAuth _auth = FirebaseAuth.instance;

// FirebaseAuth instance

  AuthenticationProvider(this.firebaseAuth);
//Constructor to initialize the Firebase Auth instance.

  //Using Stream to listen to Authentication State
  Stream<User> get authState => firebaseAuth.idTokenChanges();

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final referenceDatabase = FirebaseDatabase.instance.reference();

  Future<User> singInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      final User user = userCredential.user;

      //Creamos el usuario al logearnos en la base de datos

      if (!await rootFirebaseIsExist(
          referenceDatabase.child('Users').child(user.uid))) {
        referenceDatabase.child('Users').child(user.uid).set({
          'nombre': user.displayName.toString(),
          'email': user.email.toString()
        });
      }

      return user;
    } catch (e) {
      print(e);
      return e;
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
