import 'package:flutter/material.dart';
import 'package:quick_stats/src/requests/match_request.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  String? _chosenValue;
  String? _chosenValue1;
  String? _chosenValue2;

  List<String> organizaciones = [];

  List<String> equipos = [];

  @override
  void initState() {
    super.initState();
    asyncMethod().then((value) {
      organizaciones = value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(0.0),
              child: DropdownButton<String>(
                value: _chosenValue,
                //elevation: 5,
                style: TextStyle(color: Colors.black),

                items: organizaciones
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text(
                  "Seleccione una organización",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: (String? value) async {
                  equipos = await getTeams(value!);
                  setState(() {
                    _chosenValue = value;
                    _chosenValue1 = null;
                    _chosenValue2 = null;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          _eleccionEquipo1(context),
          _eleccionEquipo2(context),
          _botonCrear(context)
        ],
      ),
    );
  }

  Widget _eleccionEquipo1(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: DropdownButton<String>(
        value: _chosenValue1,
        //elevation: 5,
        style: TextStyle(color: Colors.black),

        items: equipos.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: Text(
          "Seleccione al equipo local",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onChanged: (String? value) {
          setState(() {
            _chosenValue1 = value;
          });
        },
      ),
    );
  }

  Widget _eleccionEquipo2(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: DropdownButton<String>(
        value: _chosenValue2,
        //elevation: 5,
        style: TextStyle(color: Colors.black),

        items: equipos.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: Text(
          "Seleccione al equipo visitante",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onChanged: (String? value) {
          setState(() {
            _chosenValue2 = value;
          });
        },
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
            'Crear partido',
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
          if (_chosenValue1 != _chosenValue2) {
            if (_chosenValue1 != null && _chosenValue2 != null) {
              if (await matchExist(_chosenValue1!, _chosenValue2!)) {
                await createMatch(_chosenValue1, _chosenValue2).then((value) =>
                    Navigator.pushReplacementNamed(context, "BasketMatch",
                        arguments: {
                          "local": _chosenValue1,
                          "visitor": _chosenValue2,
                          "organization": _chosenValue
                        }));
              } else {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(
                      'Este partido se encuentra en curso',
                      textAlign: TextAlign.center,
                    ),
                  ));
              }
            } else {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(
                    'Debe seleccionar dos equipos',
                    textAlign: TextAlign.center,
                  ),
                ));
            }
          } else {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(
                  'Debe seleccionar dos equipos diferentes',
                  textAlign: TextAlign.center,
                ),
              ));
          }
        });
  }

  Future<List<String>> asyncMethod() async {
    var resultado = await getOrganizations();
    return resultado;
  }
}
