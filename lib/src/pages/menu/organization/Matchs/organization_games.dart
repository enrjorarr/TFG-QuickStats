import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

class OrganizationGamesPage extends StatefulWidget {
  final String? organization;

  const OrganizationGamesPage({Key? key, this.organization}) : super(key: key);

  @override
  _OrganizationGamesPageState createState() => _OrganizationGamesPageState();
}

class _OrganizationGamesPageState extends State<OrganizationGamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getMatches(widget.organization!),
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
                  final String match = snapshot.data[index];
                  var aux = match.split('|');
                  String date = aux[1].trim();
                  var partido = aux[0].trim();

                  return FadeInRight(
                    delay: Duration(milliseconds: 100 * index),
                    child: listaOrganizaciones(
                        context, match, widget.organization, date, partido),
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

  Widget listaOrganizaciones(BuildContext context, String match,
      String? organization, String date, String partido) {
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
              match,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(date),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0),
            onTap: () {
              Navigator.pushNamed(context, "OrganizationMatch", arguments: {
                "organization": organization,
                "match": match,
                "partido": partido
              });
            },
            onLongPress: () async {
              if (await getOwner(organization!)) {
                createAlertDialog(context, organization, match);
              }
            },
          )),
    );
  }

  createAlertDialog(BuildContext context, String? organization, String match) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.QUESTION,
        animType: AnimType.BOTTOMSLIDE,
        title: match,
        desc: '¿Deseas eliminar este partido de la organización?',
        btnOkText: 'Aceptar',
        btnCancelText: 'Cancelar',
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          if (await deleteMatch(organization!, match)) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(
                  'Se ha eliminado el partido correctamente',
                  textAlign: TextAlign.center,
                ),
              ));
          } else {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(
                  'Ha ocurrido un error elminando el partido',
                  textAlign: TextAlign.center,
                ),
              ));
          }
          setState(() {});
        })
      ..show();
  }
}
