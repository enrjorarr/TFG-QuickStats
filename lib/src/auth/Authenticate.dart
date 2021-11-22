import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/Material.dart';
import 'package:quick_stats/src/pages/menu_page.dart';
import 'package:quick_stats/src/pages/prueba_login.dart';

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Instancia para conocer el estado del autenticador.
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      //Si el usuario está logeado, se redirige al menú principal.
      return MenuPage();
    }
    //Si el usuario no está logead, le redirige a la pantalla de login.
    return PruebaLoginPage();
  }
}
