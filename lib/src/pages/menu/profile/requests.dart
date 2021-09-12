import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:quick_stats/src/requests/profile_request.dart';

const KLargeTextStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
const KTitleTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);

class RequestsPage extends StatefulWidget {
  //Firebase
  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  final referenceDatabase = FirebaseDatabase.instance.reference();

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Peticiones'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getOrganizationsRequests(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.deepOrange),
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
                          child: listaOrganizaciones(organization),
                        );
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
          _crearBotonPeticiones(context),
          SizedBox(height: 40)
        ],
      ),
    );
  }

  Widget listaOrganizaciones(String organization) {
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
            onTap: () {
              createAlertDialog(context, organization);
            },
          )),
    );
  }

  createAlertDialog(BuildContext context, String organization) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      animType: AnimType.BOTTOMSLIDE,
      title: organization,
      desc: '¿Te gustaría unirte a esta organización?',
      btnOkText: 'Aceptar',
      btnCancelText: 'Rechazar',
      btnCancelOnPress: () {
        rejectOrganizations(organization);
        setState(() {});
      },
      btnOkOnPress: () async {
        acceptOrganizations(organization);
        rejectOrganizations(organization);
        setState(() {});
      },
    )..show();
  }

  Widget _crearBotonPeticiones(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1, vertical: size.height * 0.015),
          child: Text(
            'Volver',
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          elevation: 14.0,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: 'Sen',
            color: Colors.white,
          ),
          primary: Colors.deepOrange,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }
}
