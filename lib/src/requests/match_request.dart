import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

final referenceDatabase = FirebaseDatabase.instance.reference();
final User? user = FirebaseAuth.instance.currentUser;

Future<void> setTime(String time, String local, String visitor) async {
  try {
    await referenceDatabase
        .child('LiveMatches')
        .child('$local - $visitor')
        .child('tiempo')
        .set(time);
  } catch (e) {
    print(e);
  }
}

Future<void> setOnePoint(String numPlayer, String match, String team) async {
  try {
    await referenceDatabase
        .child('LiveMatches')
        .child(match)
        .child(team)
        .child(numPlayer)
        .child('points')
        .set(ServerValue.increment(1));

    await referenceDatabase
        .child('LiveMatches')
        .child(match)
        .child('$team-points')
        .set(ServerValue.increment(1));
  } catch (e) {
    print(e);
  }
}

Future<void> setTwoPoints(String numPlayer, String match, String team) async {
  try {
    await referenceDatabase
        .child('LiveMatches')
        .child(match)
        .child(team)
        .child(numPlayer)
        .child('points')
        .set(ServerValue.increment(2));

    await referenceDatabase
        .child('LiveMatches')
        .child(match)
        .child('$team-points')
        .set(ServerValue.increment(2));
  } catch (e) {
    print(e);
  }
}

Future<void> setThreePoints(String numPlayer, String match, String team) async {
  try {
    await referenceDatabase
        .child('LiveMatches')
        .child(match)
        .child(team)
        .child(numPlayer)
        .child('points')
        .set(ServerValue.increment(3));

    await referenceDatabase
        .child('LiveMatches')
        .child(match)
        .child('$team-points')
        .set(ServerValue.increment(3));
  } catch (e) {
    print(e);
  }
}

Future<void> setAssist(String numPlayer, String match, String team) async {
  try {
    await referenceDatabase
        .child('LiveMatches')
        .child(match)
        .child(team)
        .child(numPlayer)
        .child('assists')
        .set(ServerValue.increment(1));
  } catch (e) {
    print(e);
  }
}

Future<void> setFault(String numPlayer, String match, String team) async {
  try {
    await referenceDatabase
        .child('LiveMatches')
        .child(match)
        .child(team)
        .child(numPlayer)
        .child('faults')
        .set(ServerValue.increment(1));
  } catch (e) {
    print(e);
  }
}

Future<void> setRebound(String numPlayer, String match, String team) async {
  try {
    await referenceDatabase
        .child('LiveMatches')
        .child(match)
        .child(team)
        .child(numPlayer)
        .child('rebounds')
        .set(ServerValue.increment(1));
  } catch (e) {
    print(e);
  }
}

Future<bool> createMatch(String? local, String? visitor) async {
  bool res = false;
  int localIteration = -1;
  int visitorIteration = -1;

  var localPlayers = await getPlayers(local);
  var visitorPlayers = await getPlayers(visitor);

  try {
    await referenceDatabase
        .child('LiveMatches')
        .child('$local - $visitor')
        .child('tiempo')
        .set('10 : 00');

    await referenceDatabase
        .child('LiveMatches')
        .child('$local - $visitor')
        .child('periodo')
        .set(1);

    await referenceDatabase
        .child('LiveMatches')
        .child('$local - $visitor')
        .child('$local-points')
        .set(0);

    await referenceDatabase
        .child('LiveMatches')
        .child('$local - $visitor')
        .child('$visitor-points')
        .set(0);

    localPlayers.forEach((key, value) async {
      if (value != null) {
        var aux = value.split('/');
        String name = aux[0].trim();
        String number = aux[1].trim();
        localIteration++;

        await setTeamValues(
            local!, visitor!, local, localIteration, name, number);
      }
    });

    visitorPlayers.forEach((key, value) async {
      if (value != null) {
        var aux = value.split('/');
        String name = aux[0].trim();
        String number = aux[1].trim();
        visitorIteration++;

        await setTeamValues(
            local!, visitor!, visitor, visitorIteration, name, number);
      }
    });

    res = true;
  } catch (e) {
    print(e);
  }
  return res;
}

Future<void> setTeamValues(String local, String visitor, String team,
    int iteration, String name, String number) async {
  try {
    await referenceDatabase
        .child('LiveMatches')
        .child('$local - $visitor')
        .child(team)
        .child(iteration.toString())
        .child('assists')
        .set(0);

    await referenceDatabase
        .child('LiveMatches')
        .child('$local - $visitor')
        .child(team)
        .child(iteration.toString())
        .child('points')
        .set(0);

    await referenceDatabase
        .child('LiveMatches')
        .child('$local - $visitor')
        .child(team)
        .child(iteration.toString())
        .child('faults')
        .set(0);

    await referenceDatabase
        .child('LiveMatches')
        .child('$local - $visitor')
        .child(team)
        .child(iteration.toString())
        .child('rebounds')
        .set(0);

    await referenceDatabase
        .child('LiveMatches')
        .child('$local - $visitor')
        .child(team)
        .child(iteration.toString())
        .child('name')
        .set(name);

    await referenceDatabase
        .child('LiveMatches')
        .child('$local - $visitor')
        .child(team)
        .child(iteration.toString())
        .child('number')
        .set(number);
  } catch (e) {
    print(e);
  }
}

Future<bool> matchExist(String local, String visitor) async {
  bool res = false;

  try {
    await referenceDatabase
        .child('LiveMatches')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        if (key == '$local - $visitor') {
          res = true;
        }
      });
    });
  } catch (e) {
    print(e);
  }
  return res;
}

Future<List<String>> getLiveMatches() async {
  List<String> liveMatches = [];

  try {
    await referenceDatabase
        .child('LiveMatches')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        liveMatches.add(key);
      });
    });
  } catch (e) {
    print(e);
  }
  return liveMatches;
}

Future<List<dynamic>> getLocalVisitorTeam(String? match, String? team) async {
  List<dynamic> localTeam = [];

  try {
    await referenceDatabase
        .child('LiveMatches')
        .child(match!)
        .child(team!)
        .once()
        .then((DataSnapshot snapshot) {
      localTeam = snapshot.value;
    });
  } catch (e) {
    print(e);
  }
  return localTeam;
}
