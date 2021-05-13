import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/Material.dart';
import 'package:quick_stats/src/pages/menu_page.dart';
import 'package:quick_stats/src/pages/prueba_login.dart';

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Instance to know the authentication state.
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      //Means that the user is logged in already and hence navigate to HomePage
      return MenuPage();
    }
    //The user isn't logged in and hence navigate to SignInPage.
    return PruebaLoginPage();
  }
}
