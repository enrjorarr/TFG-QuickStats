import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quick_stats/src/models/time_match.dart';
import 'package:quick_stats/src/requests/match_request.dart';

String? local = '';
String? visitor = '';
String? organization;
bool isLoading = true;
var sub;

//Variables equipo local
List<dynamic> localTeam = [];
var local0;
var local1;
var local2;
var local3;
var local4;
var local5;
var local6;
var local7;
var local8;
var local9;
var local10;
var local11;

//Variables equipo visitante
List<dynamic> visitorTeam = [];
var visitor0;
var visitor1;
var visitor2;
var visitor3;
var visitor4;
var visitor5;
var visitor6;
var visitor7;
var visitor8;
var visitor9;
var visitor10;
var visitor11;

class SpectatorPage extends StatefulWidget {
  @override
  SpectatorPageState createState() => SpectatorPageState();
}

class SpectatorPageState extends State<SpectatorPage> {
  String tiempo = '10:00';
  int periodo = 1;
  String _match = '';
  int localPoints = 0;
  int visitorPoints = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      asyncMethod();
    });

    final referenceDatabase = FirebaseDatabase.instance
        .reference()
        .child('LiveMatches')
        .child(_match);
    sub = referenceDatabase.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryChanged(Event event) {
    setState(() {
      tiempo = Time.fromSnapshot(event.snapshot).tiempo;
      periodo = Time.fromSnapshot(event.snapshot).periodo;
      localPoints = event.snapshot.value['$local-points'];
      visitorPoints = event.snapshot.value['$visitor-points'];

      local0 = event.snapshot.value[local][0];
      local1 = event.snapshot.value[local][1];
      local2 = event.snapshot.value[local][2];
      local3 = event.snapshot.value[local][3];
      local4 = event.snapshot.value[local][4];
      local5 = event.snapshot.value[local][5];
      local6 = event.snapshot.value[local][6];
      local7 = event.snapshot.value[local][7];
      local8 = event.snapshot.value[local][8];
      local9 = event.snapshot.value[local][9];
      local10 = event.snapshot.value[local][10];
      local11 = event.snapshot.value[local][11];

      visitor0 = event.snapshot.value[visitor][0];
      visitor1 = event.snapshot.value[visitor][1];
      visitor2 = event.snapshot.value[visitor][2];
      visitor3 = event.snapshot.value[visitor][3];
      visitor4 = event.snapshot.value[visitor][4];
      visitor5 = event.snapshot.value[visitor][5];
      visitor6 = event.snapshot.value[visitor][6];
      visitor7 = event.snapshot.value[visitor][7];
      visitor8 = event.snapshot.value[visitor][8];
      visitor9 = event.snapshot.value[visitor][9];
      visitor10 = event.snapshot.value[visitor][10];
      visitor11 = event.snapshot.value[visitor][11];
    });
  }

  @override
  void dispose() {
    sub.cancel();
    isLoading = true;
    super.dispose();
  }

  Future<void> asyncMethod() async {
    localTeam = await getLocalVisitorTeam(_match, local);
    visitorTeam = await getLocalVisitorTeam(_match, visitor);

    localPoints = await getLocalVisitorPoints(_match, local);
    visitorPoints = await getLocalVisitorPoints(_match, visitor);

    tiempo = await getTime(_match);
    periodo = await getPeriod(_match);

    visitor0 = visitorTeam[0];
    visitor1 = visitorTeam[1];
    visitor2 = visitorTeam[2];
    visitor3 = visitorTeam[3];
    visitor4 = visitorTeam[4];
    visitor5 = visitorTeam[5];
    visitor6 = visitorTeam[6];
    visitor7 = visitorTeam[7];
    visitor8 = visitorTeam[8];
    visitor9 = visitorTeam[9];
    visitor10 = visitorTeam[10];
    visitor11 = visitorTeam[11];

    //Asignar variables locales
    local0 = localTeam[0];
    local1 = localTeam[1];
    local2 = localTeam[2];
    local3 = localTeam[3];
    local4 = localTeam[4];
    local5 = localTeam[5];
    local6 = localTeam[6];
    local7 = localTeam[7];
    local8 = localTeam[8];
    local9 = localTeam[9];
    local10 = localTeam[10];
    local11 = localTeam[11];

    isLoading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final rcvdData = ModalRoute.of(context)!.settings.arguments as Map;

    _match = rcvdData['match'] as String;
    var aux = _match.split('-');
    local = aux[0].trim();
    visitor = aux[1].trim();

    final size = MediaQuery.of(context).size;
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                backgroundColor: Colors.white,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(_match),
              centerTitle: true,
            ),
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/fondoPartido.png"),
                        fit: BoxFit.cover)),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      // PIVOTS
                      Row(
                        children: [
                          Spacer(),
                          _botonjugador(context, size, local0),
                          Spacer(),
                          _botonjugador(context, size, local1),
                          Spacer(),
                          _botonjugador(context, size, local2),
                          Spacer(),
                          _botonjugador(context, size, local3),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      // ALEROS
                      Row(
                        children: [
                          Spacer(),
                          _botonjugador(context, size, local4),
                          Spacer(),
                          _botonjugador(context, size, local5),
                          Spacer(),
                          _botonjugador(context, size, local6),
                          Spacer(),
                          _botonjugador(context, size, local7),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      // BASE
                      Row(
                        children: [
                          Spacer(),
                          _botonjugador(context, size, local8),
                          Spacer(),
                          _botonjugador(context, size, local9),
                          Spacer(),
                          _botonjugador(context, size, local10),
                          Spacer(),
                          _botonjugador(context, size, local11),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.045,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Column(
                            children: [
                              Text(local!),
                              Text(localPoints.toString()),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text('$tiempo'),
                              Text('Periodo $periodo')
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(visitor!),
                              Text(visitorPoints.toString()),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      // BASE
                      Row(
                        children: [
                          Spacer(),
                          _botonjugador(context, size, visitor0),
                          Spacer(),
                          _botonjugador(context, size, visitor1),
                          Spacer(),
                          _botonjugador(context, size, visitor2),
                          Spacer(),
                          _botonjugador(context, size, visitor3),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      // ALEROS
                      Row(
                        children: [
                          Spacer(),
                          _botonjugador(context, size, visitor4),
                          Spacer(),
                          _botonjugador(context, size, visitor5),
                          Spacer(),
                          _botonjugador(context, size, visitor6),
                          Spacer(),
                          _botonjugador(context, size, visitor7),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),

                      // PIVOTS
                      Row(
                        children: [
                          Spacer(),
                          _botonjugador(context, size, visitor8),
                          Spacer(),
                          _botonjugador(context, size, visitor9),
                          Spacer(),
                          _botonjugador(context, size, visitor10),
                          Spacer(),
                          _botonjugador(context, size, visitor11),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                )),
          );
  }

  Widget _botonjugador(BuildContext context, Size size, var player) {
    return ElevatedButton(
      child: Container(
        child: Text(player["number"].toString()),
      ),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(size.width * 0.04),
          primary: Colors.deepOrange),
      onPressed: () {
        _bottomSheetButton(player);
      },
      onLongPress: () {},
    );
  }

  void _bottomSheetButton(var player) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              child: Container(
                  child: _bottonNavigationMenu(player),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20)))),
            );
          });
        });
  }

  Column _bottonNavigationMenu(var player) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Nombre: ' + player["name"]),
          onTap: () async {
            setState(() {});
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.sports_basketball_outlined),
          title: Text('Número: ' + player["number"]),
          onTap: () async {
            setState(() {});
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.sports_basketball_outlined),
          title: Text('Puntos: ' + player["points"].toString()),
          onTap: () async {
            setState(() {});
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.sports_basketball_outlined),
          title: Text('Asistencias: ' + player["assists"].toString()),
          onTap: () async {
            setState(() {});
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.sports_basketball_outlined),
          title: Text('Rebotes: ' + player["rebounds"].toString()),
          onTap: () async {
            setState(() {});
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.sports_basketball_outlined),
          title: Text('Faltas: ' + player["faults"].toString()),
          onTap: () async {
            setState(() {});
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}