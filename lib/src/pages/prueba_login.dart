import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quick_stats/src/auth/authenticationProvider.dart';

//Página de login
class PruebaLoginPage extends StatefulWidget {
  @override
  _PruebaLoginPageState createState() => _PruebaLoginPageState();
}

class _PruebaLoginPageState extends State<PruebaLoginPage> {
  final referenceDatabase = FirebaseDatabase.instance.reference();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                    backgroundColor: Colors.white,
                    strokeWidth: 10,
                  ),
                ),
              )
            : Stack(
                children: [_crearFondo(context), _loginForm(context)],
              ));
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
        padding:
            EdgeInsets.only(top: size.height * 0.37, left: size.width * 0.05),
        child: Container(
          height: size.height * 0.54,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.1),
                _crearBoton(context)
              ],
            ),
          ),
        ));
  }

  Widget _crearBoton(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.3, vertical: size.height * 0.015),
          child: Text(
            'LOGIN',
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          elevation: 7.0,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          primary: Colors.deepOrange,
        ),
        onPressed: () {
          setState(() {
            isLoading = true;
            context.read<AuthenticationProvider>().singInWithGoogle();
          });
        });
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondo = Container(
      height: size.height * 0.35,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(120)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(243, 90, 28, 1.0),
                Color.fromRGBO(244, 150, 30, 1.0)
              ])),
    );

//Elementos del fondo

    final circulo = Container(
      width: 65.0,
      height: 65.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0), color: Colors.white),
    );

    final pagina = Container(
      margin: EdgeInsets.only(left: size.width * 0.65),
      child: Text(
        'LOGIN',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      ),
    );

    return Stack(
      children: [
        fondo,
        Positioned.fill(
          child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.only(top: size.height * 0.15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      circulo,
                      SizedBox(height: size.height * 0.07),
                      pagina
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
