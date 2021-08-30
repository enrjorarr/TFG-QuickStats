import 'package:flutter/material.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

class TeamCreatePage extends StatefulWidget {
  @override
  _TeamCreatePageState createState() => _TeamCreatePageState();
}

class _TeamCreatePageState extends State<TeamCreatePage> {
  final teamController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    teamController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    teamController.dispose();

    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final rcvdData = ModalRoute.of(context)!.settings.arguments as Map;

    String? org = rcvdData['organization'] as String?;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Crear equipo'),
      ),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              _teamFieldWidget(context),
              _botonCrear(context, org)

              // buildNoAccount(),
            ],
          )),
    );
  }

  Widget _teamFieldWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.10,
          size.width * 0.1, size.height * 0.05),
      child: TextFormField(
          controller: teamController,
          maxLength: 30,
          decoration: InputDecoration(
            hintText: 'Nombre del equipo',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            prefixIcon: Icon(Icons.people),
            suffixIcon: teamController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        teamController.clear();
                      });
                    },
                  ),
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty)
              return 'El nombre del equipo está vacío';
            else if (value.length > 30)
              return 'El nombre del equipo es demasiado largo';
            else if (value
                .contains(RegExp(r'[^a-zA-ZáéíóúÁÉÍÓÚ\s\u00f1\u00d1]')))
              return 'El nombre del equipo no es válido';
            else
              return null;
          }),
    );
  }

  Widget _botonCrear(BuildContext context, String? org) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1, vertical: size.height * 0.015),
          child: Text(
            'Crear equipo',
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
          final form = formKey.currentState!;
          List<String> teamNames = [];

          if (form.validate()) {
            teamNames = await getAllTeamNames();
            if (!teamNames.contains(teamController.text)) {
              if (await addTeam(teamController.text, org!)) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(
                      'El equipo se ha creado correctamente',
                      textAlign: TextAlign.center,
                    ),
                  ));
                setState(() {
                  Navigator.pop(context);
                });
              } else {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(
                      'Ha ocurrido un error al crear el equipo',
                      textAlign: TextAlign.center,
                    ),
                  ));
              }
            } else {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(
                    'Ya existe un equipo con este nombre',
                    textAlign: TextAlign.center,
                  ),
                ));
            }
          }
        });
  }
}
