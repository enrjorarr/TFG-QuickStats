import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

const KLargeTextStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
const KTitleTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
final User? currentUser = FirebaseAuth.instance.currentUser;

class OrganizationUsersPage extends StatefulWidget {
  final String? organization;

  const OrganizationUsersPage({Key? key, this.organization}) : super(key: key);

  @override
  _OrganizationUsersPageState createState() => _OrganizationUsersPageState();
}

class _OrganizationUsersPageState extends State<OrganizationUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getEmails(widget.organization!),
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
                  final user = snapshot.data[index];
                  return FadeInRight(
                    delay: Duration(milliseconds: 100 * index),
                    child: listaOrganizaciones(
                        context, widget.organization!, user),
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

  Widget listaOrganizaciones(BuildContext context, String org, String user) {
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
              user,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0),
            onTap: () {},
            onLongPress: () async {
              if (await getOwner(org)) {
                if (user != currentUser!.email)
                  createAlertDialog(context, org, user);
                else {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(
                        'El propetario de la organización no puede ser eliminado',
                        textAlign: TextAlign.center,
                      ),
                    ));
                }
              }
            },
          )),
    );
  }

  createAlertDialog(BuildContext context, String org, String user) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.QUESTION,
        animType: AnimType.BOTTOMSLIDE,
        title: user,
        desc: '¿Deseas eliminar a este usuario de la organización?',
        btnOkText: 'Aceptar',
        btnCancelText: 'Cancelar',
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          if (await deleteUsers(org, user)) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(
                  'Se ha eliminado el usuario correctamente',
                  textAlign: TextAlign.center,
                ),
              ));
          } else {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(
                  'Ha ocurrido un error elminando al usuario',
                  textAlign: TextAlign.center,
                ),
              ));
          }
          setState(() {});
        })
      ..show();

    // showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //           title: Text(
    //             user,
    //             style: KLargeTextStyle,
    //           ),
    //           content: Text(
    //             "¿Quieres eliminar este usuario?",
    //             style: KTitleTextStyle,
    //           ),
    //           elevation: 15,
    //           backgroundColor: Color.fromRGBO(255, 203, 119, 1),
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(15)),
    //           actions: [
    //             TextButton(
    //                 onPressed: () async {
    //                   if (await deleteUsers(org, user)) {
    //                     Navigator.pop(context);
    //                     ScaffoldMessenger.of(context)
    //                       ..removeCurrentSnackBar()
    //                       ..showSnackBar(SnackBar(
    //                         content: Text(
    //                           'Se ha eliminado el usuario correctamente',
    //                           textAlign: TextAlign.center,
    //                         ),
    //                       ));
    //                   } else {
    //                     ScaffoldMessenger.of(context)
    //                       ..removeCurrentSnackBar()
    //                       ..showSnackBar(SnackBar(
    //                         content: Text(
    //                           'Ha ocurrido un error elminando al usuario',
    //                           textAlign: TextAlign.center,
    //                         ),
    //                       ));
    //                   }
    //                   setState(() {});
    //                 },
    //                 child: Text(
    //                   "Si",
    //                   style: KLargeTextStyle,
    //                 )),
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                   setState(() {});
    //                 },
    //                 child: Text(
    //                   "No",
    //                   style: KLargeTextStyle,
    //                 ))
    //           ],
    //         ));
  }
}
