import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quick_stats/src/requests/match_request.dart';

String? local;
String? visitor;
String? organization;
bool isLoading = true;

//Variables equipo local
List<dynamic> localTeam = [];
List<String?> localBench = [];
List<String?> localPlaying = [];
String? _onChangeLocalBase = '0';
String? _onChangeLocal1Alero = '0';
String? _onChangeLocal2Alero = '0';
String? _onChangeLocal1Pivot = '0';
String? _onChangeLocal2Pivot = '0';
String? local0 = '0';
String? local1 = '0';
String? local2 = '0';
String? local3 = '0';
String? local4 = '0';
String? local5;
String? local6;
String? local7;
String? local8;
String? local9;
String? local10;
String? local11;

//Variables equipo visitante
List<dynamic> visitorTeam = [];
List<String?> visitorBench = [];
List<String?> visitorPlaying = [];
String? _onChangeVisitorBase = '0';
String? _onChangeVisitor1Alero = '0';
String? _onChangeVisitor2Alero = '0';
String? _onChangeVisitor1Pivot = '0';
String? _onChangeVisitor2Pivot = '0';
String? visitor0 = '0';
String? visitor1 = '0';
String? visitor2 = '0';
String? visitor3 = '0';
String? visitor4 = '0';
String? visitor5;
String? visitor6;
String? visitor7;
String? visitor8;
String? visitor9;
String? visitor10;
String? visitor11;

class MatchBasketPage extends StatefulWidget {
  @override
  MatchBasketPageState createState() => MatchBasketPageState();
}

class MatchBasketPageState extends State<MatchBasketPage>
    with WidgetsBindingObserver {
  static const maxSeconds = 59;
  static const maxMinutes = 10;
  int seconds = 00;
  int minutes = maxMinutes;
  int periodo = 1;
  Timer? timer;
  int localPoints = 0;
  int visitorPoints = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);
    Future.delayed(Duration(seconds: 5), () {
      asyncMethod();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    isLoading = true;

    super.dispose();
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.detached) {
      deleteLiveMatch('$local - $visitor');
    }
  }

  Future<void> asyncMethod() async {
    localTeam = await getLocalVisitorTeam('$local - $visitor', local);
    visitorTeam = await getLocalVisitorTeam('$local - $visitor', visitor);

    //Asignar variables locales
    visitor0 = visitorTeam[0]['number'];
    visitor1 = visitorTeam[1]['number'];
    visitor2 = visitorTeam[2]['number'];
    visitor3 = visitorTeam[3]['number'];
    visitor4 = visitorTeam[4]['number'];
    visitor5 = visitorTeam[5]['number'];
    visitor6 = visitorTeam[6]['number'];
    visitor7 = visitorTeam[7]['number'];
    visitor8 = visitorTeam[8]['number'];
    visitor9 = visitorTeam[9]['number'];
    visitor10 = visitorTeam[10]['number'];
    visitor11 = visitorTeam[11]['number'];

    _onChangeVisitorBase = visitor0!;
    _onChangeVisitor1Alero = visitor1;
    _onChangeVisitor2Alero = visitor2;
    _onChangeVisitor1Pivot = visitor3;
    _onChangeVisitor2Pivot = visitor4;
    visitorPlaying.add(visitor0);
    visitorPlaying.add(visitor1);
    visitorPlaying.add(visitor2);
    visitorPlaying.add(visitor3);
    visitorPlaying.add(visitor4);
    visitorBench.add(visitor5);
    visitorBench.add(visitor6);
    visitorBench.add(visitor7);
    visitorBench.add(visitor8);
    visitorBench.add(visitor9);
    visitorBench.add(visitor10);
    visitorBench.add(visitor11);

    //Asignar variables locales
    local0 = localTeam[0]['number'];
    local1 = localTeam[1]['number'];
    local2 = localTeam[2]['number'];
    local3 = localTeam[3]['number'];
    local4 = localTeam[4]['number'];
    local5 = localTeam[5]['number'];
    local6 = localTeam[6]['number'];
    local7 = localTeam[7]['number'];
    local8 = localTeam[8]['number'];
    local9 = localTeam[9]['number'];
    local10 = localTeam[10]['number'];
    local11 = localTeam[11]['number'];

    _onChangeLocalBase = local0!;
    _onChangeLocal1Alero = local1;
    _onChangeLocal2Alero = local2;
    _onChangeLocal1Pivot = local3;
    _onChangeLocal2Pivot = local4;
    localPlaying.add(local0);
    localPlaying.add(local1);
    localPlaying.add(local2);
    localPlaying.add(local3);
    localPlaying.add(local4);
    localBench.add(local5);
    localBench.add(local6);
    localBench.add(local7);
    localBench.add(local8);
    localBench.add(local9);
    localBench.add(local10);
    localBench.add(local11);
    isLoading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final rcvdData = ModalRoute.of(context)!.settings.arguments as Map;

    local = rcvdData['local'] as String?;
    visitor = rcvdData['visitor'] as String?;
    organization = rcvdData['organization'] as String?;
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
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              actions: [
                PopupMenuButton<int>(
                  elevation: 7,
                  color: Colors.deepOrange,
                  onSelected: (item) => onSelected(context, item),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: [
                          Icon(Icons.save_alt),
                          const SizedBox(width: 8),
                          Text('Guardar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.018,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app),
                          const SizedBox(width: 8),
                          Text('Salir',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.018,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),

                // IconButton(
                //     onPressed: () async {
                //       if (await checkPeriodAndtime('$local - $visitor')) {
                //         if (await addMatchToOrganization(
                //             local, visitor, organization!)) {
                //           deleteLiveMatch('$local - $visitor');
                //         }
                //       } else {
                //         ScaffoldMessenger.of(context)
                //           ..removeCurrentSnackBar()
                //           ..showSnackBar(SnackBar(
                //             content: Text(
                //               'El partido aún no ha finalizado',
                //               textAlign: TextAlign.center,
                //             ),
                //           ));
                //       }
                //     },
                //     icon: Icon(Icons.save))
              ],
              centerTitle: true,
              title: Text("$local - $visitor",
                  style: TextStyle(
                      fontSize: size.height * 0.026,
                      fontWeight: FontWeight.bold)),
            ),
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        scale: size.aspectRatio,
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
                          _botonjugadorPivot1Local(context, size),
                          Spacer(
                            flex: 2,
                          ),
                          _botonjugadorPivot2Local(context, size),
                          Spacer()
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      // ALEROS
                      Row(
                        children: [
                          Spacer(),
                          _botonjugadorAlero1Local(context, size),
                          Spacer(
                            flex: 4,
                          ),
                          _botonjugadorAlero2Local(context, size),
                          Spacer()
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      // BASE
                      Row(
                        children: [
                          Expanded(child: _botonjugadorBaseLocal(context, size))
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
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
                              _buildTimer(context, size, local!, visitor!),
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
                        height: size.height * 0.03,
                      ),
                      // BASE
                      Row(
                        children: [
                          Expanded(
                              child: _botonjugadorBaseVisitante(context, size))
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      // ALEROS
                      Row(
                        children: [
                          Spacer(),
                          _botonjugadorAlero1Visitante(context, size),
                          Spacer(
                            flex: 4,
                          ),
                          _botonjugadorAlero2Visitante(context, size),
                          Spacer()
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),

                      // PIVOTS
                      Row(
                        children: [
                          Spacer(),
                          _botonjugadorPivot1Visitante(context, size),
                          Spacer(
                            flex: 2,
                          ),
                          _botonjugadorPivot2Visitante(context, size),
                          Spacer()
                        ],
                      ),
                    ],
                  ),
                )),
          );
  }

  Widget _buildTimer(
      BuildContext context, Size size, String local, String visitor) {
    return SizedBox(
      width: size.width * 0.23,
      height: size.height * 0.15,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: _circleTimer(context, size, local, visitor),
          )
        ],
      ),
    );
  }

  Widget _circleTimer(
      BuildContext context, Size size, String local, String visitor) {
    var isRunning = timer == null ? false : timer!.isActive;

    return ElevatedButton(
      child: Text(
        '$minutes : $seconds',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: size.height * 0.02),
      ),
      style: OutlinedButton.styleFrom(
        fixedSize: size,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        shape: CircleBorder(),
      ),
      onPressed: () {
        if (isRunning) {
          stopTimer();
          isRunning = false;
        } else {
          startTimer(local, visitor);
        }
      },
      onLongPress: () {
        if (isRunning) {
          stopTimer();
          isRunning = false;
        }
        _bottomSheetButtonTimer();
      },
    );
  }

  void startTimer(String local, String visitor) {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
          setTime('$minutes : $seconds', '$local - $visitor');
        });
      } else {
        if (minutes > 0) {
          setState(() {
            minutes--;
            seconds = maxSeconds;
          });
        } else {
          stopTimer();
        }
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  Widget _botonjugadorBaseLocal(BuildContext context, Size size) {
    return ElevatedButton(
      child: Container(
        child: Text(_onChangeLocalBase!),
      ),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(size.width * 0.04),
          primary: Colors.deepOrange),
      onPressed: () {
        _bottomSheetButton(_onChangeLocalBase!, 'local');
      },
      onLongPress: () {
        localPlaying.remove(_onChangeLocalBase);
        _bottomSheetButtonPlayers(_onChangeLocalBase!, 'local');
      },
    );
  }

  Widget _botonjugadorAlero1Local(BuildContext context, Size size) {
    return ElevatedButton(
      child: Container(
        child: Text(_onChangeLocal1Alero!),
      ),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(size.width * 0.04),
          primary: Colors.deepOrange),
      onPressed: () {
        _bottomSheetButton(_onChangeLocal1Alero!, 'local');
      },
      onLongPress: () {
        localPlaying.remove(_onChangeLocal1Alero);
        _bottomSheetButtonPlayers(_onChangeLocal1Alero!, 'local');
      },
    );
  }

  Widget _botonjugadorAlero2Local(BuildContext context, Size size) {
    return ElevatedButton(
      child: Container(
        child: Text(_onChangeLocal2Alero!),
      ),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(size.width * 0.04),
          primary: Colors.deepOrange),
      onPressed: () {
        _bottomSheetButton(_onChangeLocal2Alero!, 'local');
      },
      onLongPress: () {
        localPlaying.remove(_onChangeLocal2Alero);
        _bottomSheetButtonPlayers(_onChangeLocal2Alero!, 'local');
      },
    );
  }

  Widget _botonjugadorPivot1Local(BuildContext context, Size size) {
    return ElevatedButton(
      child: Container(
        child: Text(_onChangeLocal1Pivot!),
      ),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(size.width * 0.04),
          primary: Colors.deepOrange),
      onPressed: () {
        _bottomSheetButton(_onChangeLocal1Pivot!, 'local');
      },
      onLongPress: () {
        localPlaying.remove(_onChangeLocal1Pivot);
        _bottomSheetButtonPlayers(_onChangeLocal1Pivot!, 'local');
      },
    );
  }

  Widget _botonjugadorPivot2Local(BuildContext context, Size size) {
    return ElevatedButton(
      child: Container(
        child: Text(_onChangeLocal2Pivot!),
      ),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(size.width * 0.04),
          primary: Colors.deepOrange),
      onPressed: () {
        _bottomSheetButton(_onChangeLocal2Pivot!, 'local');
      },
      onLongPress: () {
        localPlaying.remove(_onChangeLocal2Pivot);
        _bottomSheetButtonPlayers(_onChangeLocal2Pivot!, 'local');
      },
    );
  }

  Widget _botonjugadorBaseVisitante(BuildContext context, Size size) {
    return ElevatedButton(
      child: Container(
        child: Text(_onChangeVisitorBase!),
      ),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(size.width * 0.04),
          primary: Colors.deepOrange),
      onPressed: () {
        _bottomSheetButton(_onChangeVisitorBase!, 'visitor');
      },
      onLongPress: () {
        visitorPlaying.remove(_onChangeVisitorBase);
        _bottomSheetButtonPlayers(_onChangeVisitorBase!, 'visitor');
      },
    );
  }

  Widget _botonjugadorAlero1Visitante(BuildContext context, Size size) {
    return ElevatedButton(
      child: Container(
        child: Text(_onChangeVisitor1Alero!),
      ),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(size.width * 0.04),
          primary: Colors.deepOrange),
      onPressed: () {
        _bottomSheetButton(_onChangeVisitor1Alero!, 'visitor');
      },
      onLongPress: () {
        visitorPlaying.remove(_onChangeVisitor1Alero);
        _bottomSheetButtonPlayers(_onChangeVisitor1Alero!, 'visitor');
      },
    );
  }

  Widget _botonjugadorAlero2Visitante(BuildContext context, Size size) {
    return ElevatedButton(
      child: Container(
        child: Text(_onChangeVisitor2Alero!),
      ),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(size.width * 0.04),
          primary: Colors.deepOrange),
      onPressed: () {
        _bottomSheetButton(_onChangeVisitor2Alero!, 'visitor');
      },
      onLongPress: () {
        visitorPlaying.remove(_onChangeVisitor2Alero);
        _bottomSheetButtonPlayers(_onChangeVisitor2Alero!, 'visitor');
      },
    );
  }

  Widget _botonjugadorPivot1Visitante(BuildContext context, Size size) {
    return ElevatedButton(
      child: Container(
        child: Text(_onChangeVisitor1Pivot!),
      ),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(size.width * 0.04),
          primary: Colors.deepOrange),
      onPressed: () {
        _bottomSheetButton(_onChangeVisitor1Pivot!, 'visitor');
      },
      onLongPress: () {
        visitorPlaying.remove(_onChangeVisitor1Pivot);
        _bottomSheetButtonPlayers(_onChangeVisitor1Pivot!, 'visitor');
      },
    );
  }

  Widget _botonjugadorPivot2Visitante(BuildContext context, Size size) {
    return ElevatedButton(
      child: Container(
        child: Text(_onChangeVisitor2Pivot!),
      ),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(size.width * 0.04),
          primary: Colors.deepOrange),
      onPressed: () {
        _bottomSheetButton(_onChangeVisitor2Pivot!, 'visitor');
      },
      onLongPress: () {
        visitorPlaying.remove(_onChangeVisitor2Pivot);
        _bottomSheetButtonPlayers(_onChangeVisitor2Pivot!, 'visitor');
      },
    );
  }

  void _bottomSheetButtonTimer() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return Container(
            child: Container(
                child:
                    SingleChildScrollView(child: _bottonNavigationMenuTimer()),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20)))),
          );
        });
  }

  Column _bottonNavigationMenuTimer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.timer),
          title: Text('1 segundo'),
          onTap: () async {
            addTime(1);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.timer),
          title: Text('5 segundos'),
          onTap: () async {
            addTime(5);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.timer),
          title: Text('10 segundos'),
          onTap: () async {
            addTime(10);

            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.timer),
          title: Text('30 segundos'),
          onTap: () async {
            addTime(30);

            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.timer),
          title: Text('1 minuto'),
          onTap: () async {
            addTime(60);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.timer),
          title: Text('Reiniciar contador'),
          onTap: () async {
            resetTimer();
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.arrow_forward),
          title: Text('Pasar de cuarto'),
          onTap: () async {
            addPeriod();
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  void _bottomSheetButton(String player, String team) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return Container(
            child: Container(
                child: _bottonNavigationMenu(player, team),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20)))),
          );
        });
  }

  Column _bottonNavigationMenu(String player, String team) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.sports_basketball),
          title: Text('1 punto'),
          onTap: () async {
            int aux = 0;
            String? playerNum;
            if (team == 'local') {
              localTeam.forEach((element) {
                if (element['number'] == player) {
                  playerNum = aux.toString();
                }
                aux++;
              });
              localPoints = localPoints + 1;
              await setOnePoint(playerNum!, '$local - $visitor', local!);
            } else {
              visitorTeam.forEach((element) {
                if (element['number'] == player) {
                  playerNum = aux.toString();
                }
                aux++;
              });
              visitorPoints = visitorPoints + 1;
              await setOnePoint(playerNum!, '$local - $visitor', visitor!);
            }
            setState(() {});
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.sports_basketball),
          title: Text('2 puntos'),
          onTap: () async {
            int aux = 0;
            String? playerNum;
            if (team == 'local') {
              localTeam.forEach((element) {
                if (element['number'] == player) {
                  playerNum = aux.toString();
                }
                aux++;
              });
              localPoints = localPoints + 2;
              await setTwoPoints(playerNum!, '$local - $visitor', local!);
            } else {
              visitorTeam.forEach((element) {
                if (element['number'] == player) {
                  playerNum = aux.toString();
                }
                aux++;
              });
              visitorPoints = visitorPoints + 2;
              await setTwoPoints(playerNum!, '$local - $visitor', visitor!);
            }
            setState(() {});
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.sports_basketball),
          title: Text('3 puntos'),
          onTap: () async {
            int aux = 0;
            String? playerNum;
            if (team == 'local') {
              localTeam.forEach((element) {
                if (element['number'] == player) {
                  playerNum = aux.toString();
                }
                aux++;
              });
              localPoints = localPoints + 3;

              await setThreePoints(playerNum!, '$local - $visitor', local!);
            } else {
              visitorTeam.forEach((element) {
                if (element['number'] == player) {
                  playerNum = aux.toString();
                }
                aux++;
              });
              visitorPoints = visitorPoints + 3;

              await setThreePoints(playerNum!, '$local - $visitor', visitor!);
            }
            setState(() {});
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.flip_camera_android_rounded),
          title: Text('Rebote'),
          onTap: () async {
            int aux = 0;
            String? playerNum;
            if (team == 'local') {
              localTeam.forEach((element) {
                if (element['number'] == player) {
                  playerNum = aux.toString();
                }
                aux++;
              });

              await setRebound(playerNum!, '$local - $visitor', local!);
            } else {
              visitorTeam.forEach((element) {
                if (element['number'] == player) {
                  playerNum = aux.toString();
                }
                aux++;
              });

              await setRebound(playerNum!, '$local - $visitor', visitor!);
            }
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.connect_without_contact),
          title: Text('Asistencia'),
          onTap: () async {
            int aux = 0;
            String? playerNum;
            if (team == 'local') {
              localTeam.forEach((element) {
                if (element['number'] == player) {
                  playerNum = aux.toString();
                }
                aux++;
              });
              await setAssist(playerNum!, '$local - $visitor', local!);
            } else {
              visitorTeam.forEach((element) {
                if (element['number'] == player) {
                  playerNum = aux.toString();
                }
                aux++;
              });
              await setAssist(playerNum!, '$local - $visitor', visitor!);
            }
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.do_not_touch),
          title: Text('Falta'),
          onTap: () async {
            int aux = 0;
            String? playerNum;
            if (team == 'local') {
              localTeam.forEach((element) {
                if (element['number'] == player) {
                  playerNum = aux.toString();
                }
                aux++;
              });
              await setFault(playerNum!, '$local - $visitor', local!);
            } else {
              visitorTeam.forEach((element) {
                if (element['number'] == player) {
                  playerNum = aux.toString();
                }
                aux++;
              });
              await setFault(playerNum!, '$local - $visitor', visitor!);
            }
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  void _bottomSheetButtonPlayers(String player, String team) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return Container(
            child: Container(
                child: SingleChildScrollView(
                    child: _bottonNavigationMenuPlayers(player, team)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20)))),
          );
        });
  }

  Column _bottonNavigationMenuPlayers(String player, String team) {
    return Column(
        mainAxisSize: MainAxisSize.min, children: getList(player, team));
  }

  List<Widget> getList(String player, String team) {
    List<Widget> childs = [];
    if (team == 'local') {
      for (var item in localBench) {
        childs.add(new ListTile(
          leading: Icon(Icons.person),
          title: Text(item!),
          onTap: () {
            setState(() {
              localBench.add(player);
              if (_onChangeLocalBase == player) _onChangeLocalBase = item;
              if (_onChangeLocal1Alero == player) _onChangeLocal1Alero = item;
              if (_onChangeLocal2Alero == player) _onChangeLocal2Alero = item;
              if (_onChangeLocal1Pivot == player) _onChangeLocal1Pivot = item;
              if (_onChangeLocal2Pivot == player) _onChangeLocal2Pivot = item;

              localBench.remove(item);
              localPlaying.add(item);
              Navigator.pop(context);
            });
          },
        ));
      }
    } else {
      for (var item in visitorBench) {
        childs.add(new ListTile(
          leading: Icon(Icons.person),
          title: Text(item!),
          onTap: () {
            setState(() {
              visitorBench.add(player);
              if (_onChangeVisitorBase == player) _onChangeVisitorBase = item;
              if (_onChangeVisitor1Alero == player)
                _onChangeVisitor1Alero = item;
              if (_onChangeVisitor2Alero == player)
                _onChangeVisitor2Alero = item;
              if (_onChangeVisitor1Pivot == player)
                _onChangeVisitor1Pivot = item;
              if (_onChangeVisitor2Pivot == player)
                _onChangeVisitor2Pivot = item;

              visitorBench.remove(item);
              visitorPlaying.add(item);
              Navigator.pop(context);
            });
          },
        ));
      }
    }

    return childs;
  }

  void addTime(int time) {
    int newSeconds = seconds + time;
    if (newSeconds > 59) {
      if ((minutes + 1) > 9) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(
              'No es posible añadir más tiempo',
              textAlign: TextAlign.center,
            ),
          ));
      } else {
        seconds = newSeconds - 60;
        minutes++;
      }
    } else {
      seconds = newSeconds;
    }
    setTime('$minutes : $seconds', '$local - $visitor');
    setState(() {});
  }

  void resetTimer() {
    minutes = maxMinutes;
    seconds = 00;
    setTime('$minutes : $seconds', '$local - $visitor');
    setState(() {});
  }

  void addPeriod() {
    if ((periodo + 1) > 4) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(
            'El partido se encuentra en el último cuarto',
            textAlign: TextAlign.center,
          ),
        ));
    } else {
      periodo++;
      setPeriod(periodo, '$local - $visitor');
      resetTimer();
    }
  }
}

saveAlert(BuildContext context) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.QUESTION,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Guardar datos',
    desc:
        '¿Deseas guardar los datos de este partido dentro de la organización?',
    btnOkText: 'Aceptar',
    btnCancelText: 'Cancelar',
    btnCancelOnPress: () {},
    btnOkOnPress: () async {
      if (await addMatchToOrganization(local, visitor, organization!)) {
        if (await deleteLiveMatch('$local - $visitor')) {
          localTeam = [];
          localBench = [];
          localPlaying = [];
          visitorTeam = [];
          visitorBench = [];
          visitorPlaying = [];
          isLoading = true;
          Navigator.pushReplacementNamed(context, 'Menu');
        }
      }
    },
  )..show();
}

exitAlert(BuildContext context) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Salir del partido',
      desc:
          '¿Estás seguro de abandonar el partido? Se perderán los datos del encuentro',
      btnOkText: 'Aceptar',
      btnCancelText: 'Cancelar',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        if (await deleteLiveMatch('$local - $visitor')) {
          localTeam = [];
          localBench = [];
          localPlaying = [];
          visitorTeam = [];
          visitorBench = [];
          visitorPlaying = [];
          isLoading = true;
          Navigator.pushReplacementNamed(context, 'Menu');
        } else {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(
                'Ha ocurrido un error',
                textAlign: TextAlign.center,
              ),
            ));
        }
      })
    ..show();
}

void onSelected(BuildContext context, int item) async {
  switch (item) {
    case 0:
      if (await checkPeriodAndtime('$local - $visitor')) {
        saveAlert(context);
      } else {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(
              'El partido aún no ha finalizado',
              textAlign: TextAlign.center,
            ),
          ));
      }
      break;
    case 1:
      exitAlert(context);
      break;
  }
}



// String? _findNumPlayer(String player, String team) {
//   int aux = 0;
//   String? res;
//   if (team == 'local') {
//     localTeam.forEach((element) {
//       if (element['number'] == player) {
//         res = aux.toString();
//       }
//       aux++;
//     });
//   } else {
//     visitorTeam.forEach((element) {
//       if (element['number'] == player) {
//         res = aux.toString();
//       }
//       aux++;
//     });
//   }

//   return res;
// }
