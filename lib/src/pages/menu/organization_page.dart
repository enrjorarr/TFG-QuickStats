import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:quick_stats/src/models/organization.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

class OrganizationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getOrganization(),
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
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget listaOrganizaciones(Organization organization) {
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
              organization.name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Row(
              children: <Widget>[
                Text("Equipos - ", style: TextStyle(color: Colors.white)),
                Text(organization.numTeams.toString(),
                    style: TextStyle(color: Colors.white)),
                Text("  Usuarios - ", style: TextStyle(color: Colors.white)),
                Text(organization.numUsers.toString(),
                    style: TextStyle(color: Colors.white))
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0),
            onTap: () {},
          )),
    );
  }
}

// class _ListaOrganizaciones extends StatelessWidget {
//   final List<Organization> organizations;

//   _ListaOrganizaciones(this.organizations);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: organizations.length,
//       itemBuilder: (context, index) {
//         final organization = organizations[index];
//         return ListTile(
//           title: Text(organization.name),
//         );
//       },
//     );
//   }
// }
