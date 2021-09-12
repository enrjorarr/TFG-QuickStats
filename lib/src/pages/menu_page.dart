import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:quick_stats/src/pages/menu/favorite_page.dart';
import 'package:quick_stats/src/pages/menu/match_page.dart';
import 'package:quick_stats/src/pages/menu/organization_page.dart';
import 'package:quick_stats/src/pages/menu/search_page.dart';

import 'menu/profile_page.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final User? user = FirebaseAuth.instance.currentUser;

  // Variables
  int pageIndex = 2;
  String titulo = "Match";

  //Creamos las páginas
  final SearchPage _searchPage = new SearchPage();
  final FavoritePage _favoritePage = new FavoritePage();
  final MatchPage _matchPage = MatchPage();
  final OrganizationPage _organizationPage = new OrganizationPage();
  final ProfilePage _profilePage = new ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(titulo),
        actions: [
          if (titulo == "Organizaciones")
            IconButton(
              icon: Icon(Icons.group_add),
              onPressed: () {
                Navigator.pushNamed(context, "OrganizationCreate")
                    .then((value) => setState(() {
                          _showPage = new OrganizationPage();
                        }));
              },
            ),
          if (titulo == 'Organizaciones favoritas')
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, "FavoriteSearchPage")
                    .then((value) => setState(() {
                          _showPage = new FavoritePage();
                        }));
              },
            ),
        ],
      ),
      body: _showPage,
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        animationDuration: Duration(milliseconds: 350),
        height: 55,
        color: Colors.deepOrange,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.deepOrange,
        items: [
          Icon(
            Icons.search,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.star_border,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.sports_basketball_outlined,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.people_outline,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.account_circle_outlined,
            size: 25,
            color: Colors.black,
          )
        ],
        onTap: (index) {
          setState(() {
            _showPage = _pageChooser(index);
          });
        },
      ),
    );
  }

  Widget _showPage = new MatchPage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        titulo = 'Buscar Partido';
        return _searchPage;

      case 1:
        titulo = 'Organizaciones favoritas';

        return _favoritePage;

      case 2:
        titulo = 'Partido';

        return _matchPage;

      case 3:
        titulo = 'Organizaciones';

        return _organizationPage;

      case 4:
        titulo = 'Perfil';

        return _profilePage;

      default:
        return _searchPage;
    }
  }
}
