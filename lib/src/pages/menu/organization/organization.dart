import 'package:flutter/material.dart';
import 'package:quick_stats/src/pages/menu/organization/organization_games.dart';

import 'Teams/organization_teams.dart';
import 'Users/organization_users.dart';

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
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;

    String? org = rcvdData['organization'] as String?;
    bool owner = rcvdData['owner'] as bool;

    final _controller = PageController(
      initialPage: index,
    );

    _controller.addListener(() {
      index = _controller.page!.toInt();

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
        actions: [
          if (owner && page == "Equipos")
            IconButton(
              icon: Icon(Icons.group_add),
              onPressed: () {
                Navigator.pushNamed(context, "TeamCreate",
                        arguments: {"organization": org})
                    .then((value) => setState(() {}));
              },
            )
          else if (owner && page == "Usuarios")
            IconButton(
              icon: Icon(Icons.group_add),
              onPressed: () {
                Navigator.pushNamed(context, "OrganizationInviteUsers",
                        arguments: {"organization": org})
                    .then((value) => setState(() {}));
              },
            )
        ],
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
