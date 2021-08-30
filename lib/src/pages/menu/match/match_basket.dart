import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quick_stats/src/requests/match_request.dart';

String? local;
String? visitor;

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
String? local12;
String? local13;
String? local14;

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
String? visitor12;
String? visitor13;
String? visitor14;

class MatchBasketPage extends StatefulWidget {
  @override
  MatchBasketPageState createState() => MatchBasketPageState();
}

class MatchBasketPageState extends State<MatchBasketPage> {
  static const maxSeconds = 59;
  static const maxMinutes = 10;
  int seconds = 00;
  int minutes = maxMinutes;
  Timer? timer;
  int localPoints = 0;
  int visitorPoints = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // final rcvdData = ModalRoute.of(context)!.settings.arguments as Map;

      // local = rcvdData['local'] as String?;
      // visitor = rcvdData['visitor'] as String?;
      asyncMethod();
    });
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
    visitor12 = visitorTeam[12]['number'];
    visitor13 = visitorTeam[13]['number'];
    visitor14 = visitorTeam[14]['number'];

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
    visitorBench.add(visitor12);
    visitorBench.add(visitor13);
    visitorBench.add(visitor14);

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
    local12 = localTeam[12]['number'];
    local13 = localTeam[13]['number'];
    local14 = localTeam[14]['number'];

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
    localBench.add(local12);
    localBench.add(local13);
    localBench.add(local14);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final rcvdData = ModalRoute.of(context)!.settings.arguments as Map;

    local = rcvdData['local'] as String?;
    visitor = rcvdData['visitor'] as String?;
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      SizedBox.expand(
        child: Image.asset(
          'assets/fondoPartido.png',
          fit: BoxFit.fill,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("hola"),
        ),
        body: Container(
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         scale: size.aspectRatio,
            //         image: AssetImage("assets/fondoPartido.png"),
            //         fit: BoxFit.cover)),
            child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.001,
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
                height: size.height * 0.07,
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
                height: size.height * 0.045,
              ),
              // BASE
              Row(
                children: [
                  Expanded(child: _botonjugadorBaseLocal(context, size))
                ],
              ),
              SizedBox(
                height: size.height * 0.043,
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
                  _buildTimer(context, size, local!, visitor!),
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
                height: size.height * 0.043,
              ),
              // BASE
              Row(
                children: [
                  Expanded(child: _botonjugadorBaseVisitante(context, size))
                ],
              ),
              SizedBox(
                height: size.height * 0.0,
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
                height: size.height * 0.07,
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
      ),
    ]);
  }

  Widget _buildTimer(
      BuildContext context, Size size, String local, String visitor) {
    return SizedBox(
      width: size.width * 0.23,
      height: size.height * 0.15,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // CircularProgressIndicator(
          //   value: seconds / maxSeconds,
          //   strokeWidth: 11,
          //   valueColor: AlwaysStoppedAnimation(Colors.white),
          //   backgroundColor: Colors.orange[200],
          // ),
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
              fontSize: size.height * 0.03),
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
        });
  }

  void startTimer(String local, String visitor) {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
          setTime('$minutes : $seconds', local, visitor);
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
          leading: Icon(Icons.ac_unit),
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
          leading: Icon(Icons.ac_unit),
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
          leading: Icon(Icons.ac_unit),
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
          leading: Icon(Icons.ac_unit),
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
          leading: Icon(Icons.ac_unit),
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
