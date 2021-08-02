import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:quick_stats/src/auth/authenticationProvider.dart';
import 'package:quick_stats/src/models/usuario.dart';

class HomePage extends StatelessWidget {
  final referenceDatabase = FirebaseDatabase.instance.reference();
  final textController = TextEditingController();
  // Organization organization = new Organization();
  User user = FirebaseAuth.instance.currentUser;
  Usuario usuario = new Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home page'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [Text(user.displayName), _logout(context)],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        animationDuration: Duration(milliseconds: 350),
        height: 60,
        color: Colors.deepOrange,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.deepOrange,
        items: [
          Icon(
            Icons.search,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.star_border,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.sports_basketball_outlined,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.people_outline,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.account_circle_outlined,
            size: 25,
            color: Colors.black,
          )
        ],
        onTap: (index) {
          print(index);
        },
      ),
    );
  }

  _logout(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.logout),
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          context.read<AuthenticationProvider>().signOutGoogle();
        });
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          // addData(textController.text, context);
        });
  }

  // void addData(String data, context) {
  //   organization.nombre = data;
  //   organization.apellido = 'perez';
  //   organization.numero = '21';
  // }
}
