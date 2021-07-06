import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final referenceDatabase = FirebaseDatabase.instance.reference();
final User user = FirebaseAuth.instance.currentUser;

Future<List<String>> getOrganizationsRequests() async {
  List<String> organizationNames = [];
  try {
    await referenceDatabase
        .child('Users')
        .child(user.uid)
        .child('Requests')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        organizationNames.add(key);
      });
    });
  } catch (e) {
    print(e);
  }

  return organizationNames;
}

Future<void> acceptOrganizations(String organization) async {
  await referenceDatabase
      .child('Users')
      .child(user.uid)
      .child('ParticipatingOrganizations')
      .child(organization)
      .set(true);
}

Future<void> rejectOrganizations(String organization) async {
  await referenceDatabase
      .child('Users')
      .child(user.uid)
      .child('Requests')
      .child(organization)
      .remove();
}
