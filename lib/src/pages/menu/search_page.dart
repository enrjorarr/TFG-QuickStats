import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:quick_stats/src/models/organization.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

class SearchPage extends StatelessWidget {
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
              backgroundColor: Colors.orange,
            ),
          );
        },
      ),
    );
  }

  Widget listaOrganizaciones(Organization organization) {
    return ListTile(
      title: Text(
        organization.name,
        style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
      ),
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
