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

Future<Map<dynamic, dynamic>> getPlayers(String team) async {
  Map<dynamic, dynamic> values = new Map<dynamic, dynamic>();
  try {
    await referenceDatabase
        .child('Teams')
        .child(team)
        .once()
        .then((DataSnapshot snapshot) {
      values = snapshot.value;
    });
  } catch (e) {
    print(e);
  }

  return values;
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

Future<String> checkEmail(String email) async {
  String userKey = "";
  try {
    await referenceDatabase
        .child('Email_UserID')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        if (value == email) userKey = key;
      });
    });
  } catch (e) {
    print(e);
  }

  return userKey;
}

Future<bool> inviteUser(String email, String org) async {
  String userKey = await checkEmail(email);
  bool validation = true;

  try {
    await referenceDatabase
        .child('Users')
        .child(userKey)
        .child('Requests')
        .child(org)
        .set(true);
  } catch (e) {
    validation = false;
    print(e);
  }

  return validation;
}

Future<List<String>> getAllEmails() async {
  List<String> emails = [];

  try {
    await referenceDatabase
        .child('Email_UserID')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        emails.add(value);
      });
    });
  } catch (e) {
    print(e);
  }

  return emails;
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

Future<bool> getOwner(String org) async {
  bool owner = false;
  try {
    await referenceDatabase
        .child('Organizations')
        .child(org)
        .child('owner')
        .once()
        .then((DataSnapshot snapshot) {
      owner = snapshot.value == user.uid;
    });
  } catch (e) {
    print(e);
  }

  return owner;
}
