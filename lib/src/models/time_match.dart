import 'package:firebase_database/firebase_database.dart';

class Time {
  String? key;
  int periodo;
  String tiempo;

  Time(this.periodo, this.tiempo);

  Time.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        periodo = snapshot.value["periodo"],
        tiempo = snapshot.value["tiempo"];

  toJson() {
    return {
      "periodo": periodo,
      "tiempo": tiempo,
    };
  }
}
