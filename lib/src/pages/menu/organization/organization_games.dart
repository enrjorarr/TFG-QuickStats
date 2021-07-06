import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:quick_stats/src/models/organization.dart';
import 'package:quick_stats/src/pages/menu/organization/organization.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

class OrganizationGamesPage extends StatelessWidget {
  final String organization;

  const OrganizationGamesPage({Key key, this.organization}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getMatches(organization),
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
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => OrganizationGamesPage(
              //         organization: organization,
              //       ),
              //     ));
              Navigator.pushNamed(context, "OrganizationGames",
                  arguments: {"organization": organization});

              // Navigator.of(context).pushNamed('OrganizationGames');
            },
          )),
    );
  }
}
