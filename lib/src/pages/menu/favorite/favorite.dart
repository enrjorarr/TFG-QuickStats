import 'package:flutter/material.dart';
import 'package:quick_stats/src/pages/menu/organization/Teams/organization_teams.dart';
import 'package:quick_stats/src/pages/menu/organization/Matchs/organization_games.dart';

String page = "Equipos";
int index = 0;

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final Map<String, Object> rcvdData =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;

    String? org = rcvdData['organization'] as String?;

    final _controller = PageController(
      initialPage: index,
    );

    _controller.addListener(() {
      index = _controller.page!.toInt();

      setState(() {
        if (index == 0)
          page = "Partidos";
        else if (index == 1) page = "Equipos";
      });
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(page),
      ),
      body: PageView(
        controller: _controller,
        children: [
          OrganizationGamesPage(
            organization: org,
          ),
          OrganizationTeamsPage(
            organization: org,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_basketball), label: 'Partidos'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Equipos'),
        ],
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
            _controller.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.linear);
          });
        },
      ),
    );
  }
}
