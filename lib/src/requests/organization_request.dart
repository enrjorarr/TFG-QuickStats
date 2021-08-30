import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:quick_stats/src/models/organization.dart';

final referenceDatabase = FirebaseDatabase.instance.reference();
final User? user = FirebaseAuth.instance.currentUser;

Future<List<String>> getOrganizations() async {
  List<String> organizationNames = [];

  await referenceDatabase
      .child('Users')
      .child(user!.uid)
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

  return organizations;
}

Future<List<String>> getAllOrganizationNames() async {
  List<String> organizations = [];

  try {
    await referenceDatabase
        .child('Organizations')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        organizations.add(key);
      });
    });
  } catch (e) {
    print(e);
  }
  return organizations;
}

Future<bool> addOrganization(String org) async {
  bool checkOrganization = false;
  try {
    await referenceDatabase
        .child('Organizations')
        .child(org)
        .child('owner')
        .set(user!.uid);

    await referenceDatabase
        .child('Organizations')
        .child(org)
        .child('Users')
        .child(user!.uid)
        .set(true);

    await referenceDatabase
        .child('Users')
        .child(user!.uid)
        .child('ParticipatingOrganizations')
        .child(org)
        .set(true);
    checkOrganization = true;
  } catch (e) {
    print(e);
  }
  return checkOrganization;
}

Future<List<String>> getAllTeamNames() async {
  List<String> teams = [];

  try {
    await referenceDatabase.child('Teams').once().then((DataSnapshot snapshot) {
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

Future<bool> addTeam(String team, String org) async {
  bool checkTeam = false;
  try {
    await referenceDatabase
        .child('Teams')
        .child(team)
        .child('0')
        .set('Usuario de ejemplo / 0');

    await referenceDatabase
        .child('Organizations')
        .child(org)
        .child('teams')
        .child(team)
        .set(true);

    checkTeam = true;
  } catch (e) {
    print(e);
  }
  return checkTeam;
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

Future<Map<int, String?>> getPlayers(String? team) async {
  Map<int, String?> result = new Map<int, String?>();

  try {
    await referenceDatabase.child('Teams').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        if (key == team) {
          int i = 0;
          for (var val in value) {
            result[i] = val;

            i++;
          }
        }
      });
    });
  } catch (e) {
    print(e);
  }

  return result;
}

Future<int?> getNumPlayers(String? team) async {
  int? result = 0;
  int aux = 0;
  try {
    await referenceDatabase.child('Teams').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        if (key == team) {
          result = values.values.elementAt(aux).length;
        }
        aux++;
      });
    });
  } catch (e) {
    print(e);
  }

  return result;
}

Future<bool> checkMinNumPlayers(String? team) async {
  bool result = false;
  int aux = 0;
  try {
    await referenceDatabase.child('Teams').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        if (key == team) {
          if (values.values.elementAt(aux).length > 1) {
            result = true;
          }
        }
        aux++;
      });
    });
  } catch (e) {
    print(e);
  }

  return result;
}

Future<int> getFirstValueAvailable(String team) async {
  int result = 0;
  int aux = 0;
  bool check = true;
  try {
    await referenceDatabase.child('Teams').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        if (key == team) {
          for (var val in value) {
            if (val == null) {
              check = false;
              result = aux;
            } else {
              if (check) result = aux + 1;
            }
            aux++;
          }
        }
      });
      return result;
    });
  } catch (e) {
    print(e);
  }

  return result;
}

Future<int> getNumSpecificPlayers(String team, String player) async {
  int result = 0;
  try {
    await referenceDatabase.child('Teams').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        if (key == team) {
          int i = 0;
          for (var val in value) {
            if (val == player) {
              result = i;
            }
            i++;
          }
        }
      });
    });
  } catch (e) {
    print(e);
  }

  return result;
}

Future<bool> checkNumberPlayers(String? team, int numero) async {
  bool result = false;
  List<String?> listaNumeros = [];
  try {
    await referenceDatabase.child('Teams').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        if (key == team) {
          for (var val in value) {
            var aux = val.split('/');
            listaNumeros.add(aux[1].trim());
          }
          result = listaNumeros.contains(numero.toString());
        }
      });
    });
  } catch (e) {
    print(e);
  }

  return result;
}

Future<bool> addPlayer(String name, String team) async {
  bool checkPlayer = false;
  int numero = await getFirstValueAvailable(team);

  try {
    await referenceDatabase
        .child('Teams')
        .child(team)
        .child(numero.toString())
        .set(name);

    checkPlayer = true;
  } catch (e) {
    print(e);
  }
  return checkPlayer;
}

Future<bool> updatePlayer(String name, String team, String player) async {
  bool checkPlayer = false;
  int numero = await getNumSpecificPlayers(team, player);

  try {
    await referenceDatabase
        .child('Teams')
        .child(team)
        .child(numero.toString())
        .set(name);

    checkPlayer = true;
  } catch (e) {
    print(e);
  }
  return checkPlayer;
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

Future<List<String?>> getEmails(String org) async {
  List<String?> emails = [];

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
      owner = snapshot.value == user!.uid;
    });
  } catch (e) {
    print(e);
  }

  return owner;
}

Future<void> deleteOrganizations(String organization) async {
  await referenceDatabase
      .child('Users')
      .child(user!.uid)
      .child('ParticipatingOrganizations')
      .child(organization)
      .remove();

  await referenceDatabase.child('Organizations').child(organization).remove();
}

Future<bool> deleteTeam(String org, String team) async {
  bool checkDeleteTeam = false;

  try {
    await referenceDatabase
        .child('Organizations')
        .child(org)
        .child('teams')
        .child(team)
        .remove();

    await referenceDatabase.child('Teams').child(team).remove();

    checkDeleteTeam = true;
  } catch (e) {
    print(e);
  }

  return checkDeleteTeam;
}

Future<bool> deletePlayer(String team, String player) async {
  bool checkPlayer = false;
  int numPlayer;

  try {
    numPlayer = await getNumSpecificPlayers(team, player);
    await referenceDatabase
        .child('Teams')
        .child(team)
        .child(numPlayer.toString())
        .remove();
    checkPlayer = true;
  } catch (e) {
    print(e);
  }

  return checkPlayer;
}
