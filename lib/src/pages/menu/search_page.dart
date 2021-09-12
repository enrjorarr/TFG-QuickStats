import 'package:flutter/material.dart';
import 'package:quick_stats/src/requests/match_request.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _chosenValue;

  List<String> partidos = [];

  @override
  void initState() {
    super.initState();
    asyncMethod().then((value) {
      partidos = value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<String>> asyncMethod() async {
    var resultado = await getLiveMatches();
    return resultado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _crearBotonPeticiones(context),
    );
  }

  Widget _crearBotonPeticiones(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: DropdownButton<String>(
              value: _chosenValue,
              //elevation: 5,
              style: TextStyle(color: Colors.black),

              items: partidos.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(
                "Seleccione un partido",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              onChanged: (String? value) {
                setState(() {
                  _chosenValue = value;
                });
              },
            ),
          ),
          _botonCrear(context)
        ],
      ),
    );
  }

  Widget _botonCrear(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1, vertical: size.height * 0.015),
          child: Text(
            'Ver partido',
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
        onPressed: () async {
          if (_chosenValue != null) {
            Navigator.pushNamed(context, "SpectatorPage",
                arguments: {"match": _chosenValue});
          } else {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(
                  'Seleccione un partido',
                  textAlign: TextAlign.center,
                ),
              ));
          }
        });
  }
}
