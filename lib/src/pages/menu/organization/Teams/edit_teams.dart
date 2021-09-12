import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

const KLargeTextStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
const KTitleTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);

class OrganizationEditTeamPage extends StatefulWidget {
  @override
  _OrganizationEditTeamPageState createState() =>
      _OrganizationEditTeamPageState();
}

class _OrganizationEditTeamPageState extends State<OrganizationEditTeamPage> {
  @override
  Widget build(BuildContext context) {
    final rcvdData = ModalRoute.of(context)!.settings.arguments as Map;

    String? team = rcvdData['team'] as String?;
    String? org = rcvdData['organization'] as String?;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Editar equipo'),
        ),
        body: new Builder(builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 8,
                child: FutureBuilder(
                  future: getPlayers(team),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.deepOrange),
                            backgroundColor: Colors.white,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          // shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            final player = snapshot.data[index];
                            if (player != null) {
                              return FadeInRight(
                                delay: Duration(milliseconds: 100 * index),
                                child:
                                    listaJugadores(context, player, team, org),
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        );
                      }
                    } else if (snapshot.hasError) {
                      Text('No data');
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                        backgroundColor: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }));
  }

  Widget listaJugadores(
      BuildContext context, String player, String? team, String? org) {
    return Card(
      elevation: 5.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(255, 141, 67, 1)),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white))),
              child: Icon(Icons.people, color: Colors.white),
            ),
            title: Text(
              player,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0),
            onTap: () async {
              if (await getOwner(org!)) {
                Navigator.pushNamed(context, "EditCreatePlayers", arguments: {
                  "team": team,
                  "titulo": "Editar jugador",
                  "player": player
                }).then((value) => setState(() {}));
              }
            },
            // onLongPress: () async {
            //   if (await checkMinNumPlayers(team)) {
            //     if (await getOwner(org!)) {
            //       createAlertDialog(context, player, team);
            //     }
            //   } else {
            //     ScaffoldMessenger.of(context)
            //       ..removeCurrentSnackBar()
            //       ..showSnackBar(SnackBar(
            //         content: Text(
            //           'El equipo no puede tener 0 jugadores',
            //           textAlign: TextAlign.center,
            //         ),
            //       ));
            //   }
            // }
          )),
    );
  }

  // createAlertDialog(BuildContext context, String player, String? team) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: Text(
  //               player,
  //               style: KLargeTextStyle,
  //             ),
  //             content: Text(
  //               "¿Quieres eliminar este jugador?",
  //               style: KTitleTextStyle,
  //             ),
  //             elevation: 15,
  //             backgroundColor: Color.fromRGBO(255, 203, 119, 1),
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(15)),
  //             actions: [
  //               TextButton(
  //                   onPressed: () async {
  //                     if (await deletePlayer(team!, player)) {
  //                       ScaffoldMessenger.of(context)
  //                         ..removeCurrentSnackBar()
  //                         ..showSnackBar(SnackBar(
  //                           content: Text(
  //                             'El jugador se ha eliminado correctamente',
  //                             textAlign: TextAlign.center,
  //                           ),
  //                         ));
  //                     }

  //                     Navigator.pop(context);
  //                     setState(() {});
  //                   },
  //                   child: Text(
  //                     "Si",
  //                     style: KLargeTextStyle,
  //                   )),
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                     setState(() {});
  //                   },
  //                   child: Text(
  //                     "No",
  //                     style: KLargeTextStyle,
  //                   ))
  //             ],
  //           ));
  // }
}
