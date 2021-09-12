import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

const KLargeTextStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
const KTitleTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);

class OrganizationPage extends StatefulWidget {
  @override
  _OrganizationPageState createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getOrganizations(),
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
                  final organization = snapshot.data[index];
                  return FadeInRight(
                    delay: Duration(milliseconds: 100 * index),
                    child: listaOrganizaciones(context, organization),
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

  Widget listaOrganizaciones(BuildContext context, String organization) {
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
              organization,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0),
            onTap: () async {
              bool owner = await getOwner(organization);
              Navigator.pushNamed(context, "OrganizationGames",
                      arguments: {"organization": organization, "owner": owner})
                  .then((value) => setState(() {}));
            },
            onLongPress: () async {
              if (await getOwner(organization)) {
                if (await containsTeamOrUser(organization)) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(
                        'No puede eliminarse una organización con equipos o usuarios',
                        textAlign: TextAlign.center,
                      ),
                    ));
                } else {
                  deleteAlert(context, organization);
                }
              } else {
                exitAlert(context, organization);
              }
            },
          )),
    );
  }

  exitAlert(BuildContext context, String organization) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.QUESTION,
        animType: AnimType.BOTTOMSLIDE,
        title: organization,
        desc: '¿Deseas abandonar esta organización?',
        btnOkText: 'Aceptar',
        btnCancelText: 'Cancelar',
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          leaveOrganization(organization).then((value) {
            setState(() {});
          });
        })
      ..show();
  }

  deleteAlert(BuildContext context, String organization) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.QUESTION,
        animType: AnimType.BOTTOMSLIDE,
        title: organization,
        desc: '¿Deseas eliminar esta organización?',
        btnOkText: 'Aceptar',
        btnCancelText: 'Cancelar',
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          deleteOrganizations(organization).then((value) {
            setState(() {});
          });
        })
      ..show();
  }

  createAlertDialog(BuildContext context, String organization) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                organization,
                style: KLargeTextStyle,
              ),
              content: Text(
                "¿Quieres eliminar esta organización?",
                style: KTitleTextStyle,
              ),
              elevation: 15,
              backgroundColor: Color.fromRGBO(255, 203, 119, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              actions: [
                TextButton(
                    onPressed: () {
                      deleteOrganizations(organization);
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Text(
                      "Si",
                      style: KLargeTextStyle,
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: KLargeTextStyle,
                    ))
              ],
            ));
  }
}
