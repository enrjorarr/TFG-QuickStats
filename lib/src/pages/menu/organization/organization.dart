import 'package:flutter/material.dart';
import 'package:quick_stats/src/pages/menu/organization/organization_games.dart';

import 'organization_teams.dart';
import 'organization_users.dart';

String page = "Equipos";
int index = 1;

class OrganizationPage extends StatefulWidget {
  @override
  _OrganizationPageState createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  @override
  Widget build(BuildContext context) {
    final Map<String, Object> rcvdData =
        ModalRoute.of(context).settings.arguments;

    final _controller = PageController(
      initialPage: index,
    );
    String org = rcvdData['organization'];

    _controller.addListener(() {
      index = _controller.page.toInt();
      setState(() {
        if (index == 0)
          page = "Partidos";
        else if (index == 1)
          page = "Equipos";
        else
          page = "Usuarios";
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
          ),
          OrganizationUsersPage(
            organization: org,
          )
        ],
      ),
    );
  }
}
