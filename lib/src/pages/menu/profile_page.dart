import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quick_stats/src/auth/authenticationProvider.dart';

class ProfilePage extends StatelessWidget {
  final referenceDatabase = FirebaseDatabase.instance.reference();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 40, 15, 15),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(user!.photoURL!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Text(
                user!.displayName!,
                style: TextStyle(
                    fontSize: size.height * 0.026, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                user!.email!,
                style: TextStyle(
                    fontSize: size.height * 0.026, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.20),
              _crearBotonPeticiones(context),
              SizedBox(height: size.height * 0.02),
              _crearBotonLogout(context)
            ],
          ),
        ),
      ),
    );
  }

  //Petición - Botón de peticiones
  Widget _crearBotonPeticiones(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1, vertical: size.height * 0.015),
          child: Text(
            'PETICIONES',
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
          Navigator.of(context).pushNamed('requests');
        });
  }

  //Login - Botón de login
  Widget _crearBotonLogout(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1, vertical: size.height * 0.015),
          child: Text(
            'LOGOUT',
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
          context.read<AuthenticationProvider>().signOutGoogle();
        });
  }
}
