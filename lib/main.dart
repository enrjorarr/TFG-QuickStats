import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_stats/src/auth/Authenticate.dart';
import 'package:quick_stats/src/auth/authenticationProvider.dart';
import 'package:quick_stats/src/pages/home_page.dart';
import 'package:quick_stats/src/pages/prueba_login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationProvider>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Quick Stats',
        debugShowCheckedModeBanner: false,
        home: Authenticate(),
        routes: {
          'pruebaLogin': (BuildContext context) => PruebaLoginPage(),
          'home': (BuildContext context) => HomePage(),
        },
        theme: ThemeData(primaryColor: Colors.deepOrange, fontFamily: 'Sen'),
      ),
    );
  }
}
