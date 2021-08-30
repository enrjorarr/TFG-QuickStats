import 'package:firebase_database/firebase_database.dart';

class Local {
  String? key;
  String name;
  String number;

  Local(this.name, this.number);

  Local.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        number = snapshot.value["number"];

  toJson() {
    return {
      "name": name,
      "number": number,
    };
  }
}
