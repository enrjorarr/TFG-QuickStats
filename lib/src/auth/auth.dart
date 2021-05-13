import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User> singInWithGoogle() async {
  final GoogleSignInAccount googleUser = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

  final User user = userCredential.user;

  return user;
}

void signOutGoogle() async {
  await _auth.signOut();
}
