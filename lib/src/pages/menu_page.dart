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
  //Firebase
  // final referenceDatabase = FirebaseDatabase.instance
  //     .reference()
  //     .child("Organizations")
  //     .child('hola');
  final User user = FirebaseAuth.instance.currentUser;

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
        centerTitle: true,
        title: Text(titulo),
        actions: [
          if (titulo == "Organization")
            IconButton(
              icon: Icon(Icons.group_add),
              onPressed: () {},
            )
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
        titulo = 'Search';
        return _searchPage;
        break;
      case 1:
        titulo = 'Favorite';

        return _favoritePage;
        break;
      case 2:
        titulo = 'Match';

        return _matchPage;
        break;
      case 3:
        titulo = 'Organization';

        return _organizationPage;
        break;
      case 4:
        titulo = 'Profile';

        return _profilePage;
        break;
      default:
        return _searchPage;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
