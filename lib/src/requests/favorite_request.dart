import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final referenceDatabase = FirebaseDatabase.instance.reference();
final User? user = FirebaseAuth.instance.currentUser;

Future<List<String>> getFavoriteOrganizations() async {
  List<String> organizationNames = [];

  try {
    await referenceDatabase
        .child('Users')
        .child(user!.uid)
        .child('FavoriteOrganizations')
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

Future<void> deleteFavoriteOrganizations(String organization) async {
  await referenceDatabase
      .child('Users')
      .child(user!.uid)
      .child('FavoriteOrganizations')
      .child(organization)
      .remove();

  await referenceDatabase
      .child('Organizations')
      .child(organization)
      .child('Favorites')
      .child(user!.uid)
      .remove();
}

Future<bool> addOrganiztionFav(String org) async {
  bool check = false;
  try {
    await referenceDatabase
        .child('Users')
        .child(user!.uid)
        .child('FavoriteOrganizations')
        .child(org)
        .set(true);

    await referenceDatabase
        .child('Organizations')
        .child(org)
        .child('Favorites')
        .child(user!.uid)
        .set(true);

    check = true;
  } catch (e) {
    print(e);
  }

  return check;
}
