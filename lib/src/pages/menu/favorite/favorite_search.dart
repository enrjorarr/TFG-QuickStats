import 'package:flutter/material.dart';
import 'package:quick_stats/src/requests/favorite_request.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

class FavoriteSearchPage extends StatefulWidget {
  @override
  _FavoriteSearchPageState createState() => _FavoriteSearchPageState();
}

class _FavoriteSearchPageState extends State<FavoriteSearchPage> {
  final organizationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    organizationController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    organizationController.dispose();

    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Buscar organización'),
      ),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              _organizationFieldWidget(context),
              _addOrganizationButton(context)
            ],
          )),
    );
  }

  Widget _organizationFieldWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.10,
          size.width * 0.1, size.height * 0.05),
      child: TextFormField(
          controller: organizationController,
          maxLength: 80,
          decoration: InputDecoration(
            hintText: 'Organización',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            prefixIcon: Icon(Icons.people),
            suffixIcon: organizationController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        organizationController.clear();
                      });
                    },
                  ),
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty)
              return 'El nombre de la organización está vacío';
            else if (value.length > 80)
              return 'El nombre de la organización es demasiado largo';
            else if (value
                .contains(RegExp(r'[^a-zA-ZáéíóúÁÉÍÓÚ\s\u00f1\u00d1]')))
              return 'El nombre de la organización no es válido';
            else
              return null;
          }),
    );
  }

  Widget _addOrganizationButton(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1, vertical: size.height * 0.015),
          child: Text(
            'Añadir organización',
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          elevation: 14.0,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: 'Sen',
            color: Colors.white,
          ),
          primary: Colors.deepOrange,
        ),
        onPressed: () async {
          final form = formKey.currentState!;

          if (form.validate()) {
            List<String?> organizationFavs = await getFavoriteOrganizations();
            List<String> allOrganizations = await getAllOrganizationNames();

            var set1 = Set.from(organizationFavs);
            var set2 = Set.from(allOrganizations);

            if (List.from(set2.difference(set1))
                .contains(organizationController.text)) {
              if (await addOrganiztionFav(organizationController.text)) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(
                      'La organización se ha añadido correctamente',
                      textAlign: TextAlign.center,
                    ),
                  ));

                setState(() {
                  Navigator.pop(context);
                });
              }
            } else {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(
                    'La organización no existe o ya se encuentra en ella',
                    textAlign: TextAlign.center,
                  ),
                ));
            }
          }
        });
  }
}
