import 'package:firebase_database/firebase_database.dart';

class Usuario {
  Usuario({this.nombre, this.email, this.usuario});

  String nombre;
  String email;
  String usuario;

  Usuario.fromSnapshot(DataSnapshot snapshot)
      : nombre = snapshot.value["nombre"],
        email = snapshot.value["email"],
        usuario = snapshot.value["usuario"];

  toJson() {
    return {
      "nombre": nombre,
      "email": email,
      "usuario": usuario,
    };
  }
}
