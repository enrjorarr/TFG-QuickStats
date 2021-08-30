import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

const KLargeTextStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
const KTitleTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);

class OrganizationTeamsPage extends StatefulWidget {
  final String? organization;

  const OrganizationTeamsPage({Key? key, this.organization}) : super(key: key);

  @override
  _OrganizationTeamsPageState createState() => _OrganizationTeamsPageState();
}

class _OrganizationTeamsPageState extends State<OrganizationTeamsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getTeams(widget.organization!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  backgroundColor: Colors.white,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final team = snapshot.data[index];
                  return FadeInRight(
                    delay: Duration(milliseconds: 100 * index),
                    child: listaTeams(context, team, widget.organization),
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            Text('No data');
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget listaTeams(BuildContext context, String team, String? organization) {
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
                        right:
                            new BorderSide(width: 1.0, color: Colors.white))),
                child: Icon(Icons.people, color: Colors.white),
              ),
              title: Text(
                team,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.keyboard_arrow_right,
                  color: Colors.white, size: 30.0),
              onTap: () {
                Navigator.pushNamed(context, "OrganizationEditTeamPage",
                    arguments: {"team": team, "organization": organization});
              },
              onLongPress: () async {
                if (await getOwner(organization!)) {
                  createAlertDialog(context, organization, team);
                }
              })),
    );
  }

  createAlertDialog(BuildContext context, String? organization, String team) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                team,
                style: KLargeTextStyle,
              ),
              content: Text(
                "¿Quieres eliminar este equipo?",
                style: KTitleTextStyle,
              ),
              elevation: 15,
              backgroundColor: Color.fromRGBO(255, 203, 119, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              actions: [
                TextButton(
                    onPressed: () async {
                      if (await deleteTeam(organization!, team)) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text(
                              'Se ha eliminado el equipo correctamente',
                              textAlign: TextAlign.center,
                            ),
                          ));
                      } else {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text(
                              'Ha ocurrido un error elminando el equipo',
                              textAlign: TextAlign.center,
                            ),
                          ));
                      }
                      setState(() {});
                    },
                    child: Text(
                      "Si",
                      style: KLargeTextStyle,
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Text(
                      "No",
                      style: KLargeTextStyle,
                    ))
              ],
            ));
  }
}
