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
        print(snapshot.value);
        Map<dynamic, dynamic> values = snapshot.value;

        organizations.add(Organization.fromJson(values));
      });
    } catch (e) {
      print(e);
    }
  }

  return organizations;
}

Future<List<String>> getTeams(String org) async {
  List<String> teams = [];
  try {
    await referenceDatabase
        .child('Organizations')
        .child(org)
        .child('teams')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        teams.add(key);
      });
    });
  } catch (e) {
    print(e);
  }

  return teams;
}

Future<List<String>> getMatches(String org) async {
  List<String> matches = [];
  try {
    await referenceDatabase
        .child('Organizations')
        .child(org)
        .child('Matches')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        matches.add(key);
      });
    });
  } catch (e) {
    print(e);
  }

  return matches;
}

Future<List<String>> getUsers(String org) async {
  List<String> users = [];

  try {
    await referenceDatabase
        .child('Organizations')
        .child(org)
        .child('Users')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        users.add(key);
      });
    });
  } catch (e) {
    print(e);
  }

  return users;
}

Future<List<String>> getEmails(String org) async {
  List<String> emails = [];

  List<String> users = await getUsers(org);
  for (String user in users) {
    try {
      await referenceDatabase
          .child('Email_UserID')
          .child(user)
          .once()
          .then((DataSnapshot snapshot) {
        emails.add(snapshot.value);
      });
    } catch (e) {
      print(e);
    }
  }

  return emails;
}
