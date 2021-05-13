import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quick_stats/src/auth/authenticationProvider.dart';

const KLargeTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
const KTitleTextStyle =
    TextStyle(fontSize: 16, color: Color.fromRGBO(129, 156, 168, 1));

class ProfilePage extends StatelessWidget {
  //Firebase
  final referenceDatabase = FirebaseDatabase.instance.reference();
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 65, 15, 15),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(user.photoURL),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                user.displayName,
                style: KLargeTextStyle,
              ),
              SizedBox(height: 30),
              Text(
                user.email,
                style: KLargeTextStyle,
              ),
              SizedBox(height: 40),
              Text(
                'Código de usuario',
                style: KTitleTextStyle,
              ),
              SizedBox(height: 10),
              Text(
                user.uid,
                style: KLargeTextStyle,
              ),
              SizedBox(height: 40),
              _crearBoton(context)
            ],
          ),
        ),
      ),
    );
  }

  //Login - Botón de login
  Widget _crearBoton(BuildContext context) {
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
