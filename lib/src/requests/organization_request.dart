import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:quick_stats/src/models/organization.dart';

final referenceDatabase = FirebaseDatabase.instance.reference();
final User user = FirebaseAuth.instance.currentUser;

Future<List<String>> getOrganizations() async {
  List<String> organizationNames = [];

  await referenceDatabase
      .child('Users')
      .child(user.uid)
      .child('ParticipatingOrganizations')
      .once()
      .then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key, value) {
      organizationNames.add(key);
    });
  });

  return organizationNames;
}

Future<List<Organization>> getOrganization() async {
  List<Organization> organizations = [];

  List<String> organizationNames = await getOrganizations();
  for (String org in organizationNames) {
    try {
      await referenceDatabase
          .child('Organizations')
          .child(org)
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;

        organizations.add(Organization.fromJson(values));
      });
    } catch (e) {
      print(e);
    }
  }
  ;

  return organizations;
}
