import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quick_stats/src/models/time_match.dart';

class SpectatorPage extends StatefulWidget {
  @override
  SpectatorPageState createState() => SpectatorPageState();
}

class SpectatorPageState extends State<SpectatorPage> {
  String tiempo = '00:00';
  String _match = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final rcvdData = ModalRoute.of(context)!.settings.arguments as Map;

      _match = rcvdData['match'] as String;
    });

    final referenceDatabase = FirebaseDatabase.instance
        .reference()
        .child('LiveMatches')
        .child(_match);
    referenceDatabase.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryChanged(Event event) {
    setState(() {
      tiempo = Time.fromSnapshot(event.snapshot).tiempo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rcvdData = ModalRoute.of(context)!.settings.arguments as Map;

    _match = rcvdData['match'] as String;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("hola"),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/fondoPartido.png"),
                  fit: BoxFit.cover)),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                // PIVOTS
                Row(
                  children: [
                    Spacer(),
                    _botonjugador(context),
                    Spacer(
                      flex: 2,
                    ),
                    _botonjugador(context),
                    Spacer()
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                // ALEROS
                Row(
                  children: [
                    Spacer(),
                    _botonjugador(context),
                    Spacer(
                      flex: 4,
                    ),
                    _botonjugador(context),
                    Spacer()
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                // BASE
                Row(
                  children: [Expanded(child: _botonjugador(context))],
                ),
                SizedBox(
                  height: size.height * 0.045,
                ),
                Row(
                  children: [Expanded(child: _circleTimer(context))],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                // BASE
                Row(
                  children: [Expanded(child: _botonjugador(context))],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                // ALEROS
                Row(
                  children: [
                    Spacer(),
                    _botonjugador(context),
                    Spacer(
                      flex: 4,
                    ),
                    _botonjugador(context),
                    Spacer()
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),

                // PIVOTS
                Row(
                  children: [
                    Spacer(),
                    _botonjugador(context),
                    Spacer(
                      flex: 2,
                    ),
                    _botonjugador(context),
                    Spacer()
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _botonjugador(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
        child: Container(
          // padding: EdgeInsets.symmetric(
          //     horizontal: size.width * 0.1, vertical: size.height * 0.015),
          child: Text(
            '5',
          ),
        ),
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(size.width * 0.04),
            primary: Colors.deepOrange),
        onPressed: () {});
  }

  Widget _circleTimer(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
        child: Container(
          // padding: EdgeInsets.symmetric(
          //     horizontal: size.width * 0.1, vertical: size.height * 0.015),
          child: Text(
            tiempo,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: size.height * 0.04),
          ),
        ),
        style: OutlinedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(size.width * 0.03),
            primary: Colors.deepOrange),
        onPressed: () {});
  }

  Future<void> initializeListener(String _match) async {
    Future.delayed(Duration.zero, () {
      setState(() {
        // ignore: cancel_subscriptions
        final referenceDatabase = FirebaseDatabase.instance
            .reference()
            .child('LiveMatches')
            .child(_match)
            .child('tiempo')
            .onChildChanged
            .listen((event) {
          setState(() {
            tiempo = event.snapshot.key.toString();
            print(event.snapshot.key);
          });
        });
      });
      // TODO: implement initState
    });
  }
}
