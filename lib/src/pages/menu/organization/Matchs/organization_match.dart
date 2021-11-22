import 'package:flutter/material.dart';
import 'package:quick_stats/src/requests/match_request.dart';

String? local = '';
String? visitor = '';
String? organization;
bool isLoading = true;

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

class OrganizationMatchPage extends StatefulWidget {
  @override
  OrganizationMatchPageState createState() => OrganizationMatchPageState();
}

class OrganizationMatchPageState extends State<OrganizationMatchPage> {
  String tiempo = '00:00';
  int periodo = 4;
  String _match = '';
  int localPoints = 0;
  int visitorPoints = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      asyncMethod();
    });
  }

  @override
  void dispose() {
    isLoading = true;
    super.dispose();
  }

  Future<void> asyncMethod() async {
    localTeam =
        await getLocalVisitorTeamFromOrganization(organization, _match, local);
    visitorTeam = await getLocalVisitorTeamFromOrganization(
        organization, _match, visitor);

    localPoints = await getLocalVisitorPointsFromOrganization(
        organization, _match, local);
    visitorPoints = await getLocalVisitorPointsFromOrganization(
        organization, _match, visitor);

    //Asignar variables locales
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
    String partido = rcvdData['partido'] as String;
    organization = rcvdData['organization'] as String;
    var aux = partido.split('-');
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
              title: Text(partido),
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
                        height: size.height * 0.1,
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
                        height: size.height * 0.05,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Spacer(),
                          Column(
                            children: [
                              Text(local!),
                              Text(localPoints.toString()),
                            ],
                          ),
                          // Spacer(),
                          Column(
                            children: [
                              Text('$tiempo'),
                              Text('Periodo $periodo')
                            ],
                          ),
                          //  Spacer(),
                          Column(
                            children: [
                              Text(visitor!),
                              Text(visitorPoints.toString()),
                            ],
                          ),
                          // Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.06,
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
                        height: size.height * 0.05,
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

  // Widget _botonjugador(BuildContext context) {
  //   final size = MediaQuery.of(context).size;

  //   return ElevatedButton(
  //       child: Container(
  //         // padding: EdgeInsets.symmetric(
  //         //     horizontal: size.width * 0.1, vertical: size.height * 0.015),
  //         child: Text(
  //           '5',
  //         ),
  //       ),
  //       style: ElevatedButton.styleFrom(
  //           shape: CircleBorder(),
  //           padding: EdgeInsets.all(size.width * 0.04),
  //           primary: Colors.deepOrange),
  //       onPressed: () {
  //         print('asdas');
  //       });
  // }

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
