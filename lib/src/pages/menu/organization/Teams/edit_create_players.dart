import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

int _currentValue = 0;

class EditCreatePlayersPage extends StatefulWidget {
  @override
  _EditCreatePlayersPageState createState() => _EditCreatePlayersPageState();
}

class _EditCreatePlayersPageState extends State<EditCreatePlayersPage> {
  final playerController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    playerController.addListener(onListen);

    Future.delayed(Duration.zero, () {
      setState(() {
        final rcvdData = ModalRoute.of(context)!.settings.arguments as Map;

        try {
          String _player = rcvdData['player'] as String;
          var aux = _player.split('/');
          playerController.text = aux[0].trim();
          _currentValue = int.parse(aux[1].trim());
        } catch (e) {
          print(e);
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    playerController.dispose();

    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final rcvdData = ModalRoute.of(context)!.settings.arguments as Map;

    int _numeroInicial = 101;
    var player;
    String? team = rcvdData['team'] as String?;
    String titulo = rcvdData['titulo'] as String;

    try {
      player = rcvdData['player'];
      var aux = player.split('/');
      _numeroInicial = int.parse(aux[1].trim());
    } catch (e) {
      print(e);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(titulo),
      ),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              _playerFieldWidget(context),
              Text('Número del jugador',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              _playerNumberWidget(context),
              SizedBox(
                height: 30,
              ),
              _botonCrear(context, team, titulo, _numeroInicial, player)

              // buildNoAccount(),
            ],
          )),
    );
  }

  Widget _playerFieldWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.10,
          size.width * 0.1, size.height * 0.05),
      child: TextFormField(
          controller: playerController,
          maxLength: 30,
          decoration: InputDecoration(
            hintText: 'Nombre del jugador',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            prefixIcon: Icon(Icons.people),
            suffixIcon: playerController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        playerController.clear();
                      });
                    },
                  ),
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty)
              return 'El nombre del jugador está vacío';
            else if (value.length > 20)
              return 'El nombre del jugador es demasiado largo';
            else if (value
                .contains(RegExp(r'[^a-zA-ZáéíóúÁÉÍÓÚ\s\u00f1\u00d1]')))
              return 'El nombre del equipo no es válido';
            else
              return null;
          }),
    );
  }

  Widget _playerNumberWidget(BuildContext context) {
    return NumberPicker(
      decoration: BoxDecoration(
        backgroundBlendMode: BlendMode.color,
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 3),
      ),
      // axis: Axis.horizontal,
      value: _currentValue,
      minValue: 0,
      maxValue: 99,
      onChanged: (value) => setState(() => _currentValue = value),
    );
  }

  Widget _botonCrear(BuildContext context, String? team, String titulo,
      int numeroInicial, String? player) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1, vertical: size.height * 0.015),
          child: Text(
            titulo,
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

          if (form.validate()) {
            if (!await checkNumberPlayers(team, _currentValue) ||
                numeroInicial == _currentValue) {
              if (player == null) {
                if (await addPlayer(
                    playerController.text + " / " + _currentValue.toString(),
                    team!)) {
                  setState(() {
                    playerController.clear();
                    _currentValue = 0;
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text(
                          'El jugador se ha creado correctamente',
                          textAlign: TextAlign.center,
                        ),
                      ));
                    Navigator.pop(context);
                  });
                }
              } else {
                if (await updatePlayer(
                    playerController.text + " / " + _currentValue.toString(),
                    team!,
                    player)) {
                  setState(() {
                    playerController.clear();
                    _currentValue = 0;
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text(
                          'El jugador se ha modificado correctamente',
                          textAlign: TextAlign.center,
                        ),
                      ));
                    Navigator.pop(context);
                  });
                }
              }
            } else {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(
                    'Ya existe un jugador con ese número',
                    textAlign: TextAlign.center,
                  ),
                ));
            }
          }
        });
  }
}
