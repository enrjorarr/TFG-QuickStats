import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [_crearFondo(context)],
    ));
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
