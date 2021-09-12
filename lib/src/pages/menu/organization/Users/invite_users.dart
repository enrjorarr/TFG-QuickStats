import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:quick_stats/src/requests/organization_request.dart';

class OrganizationInviteUsersPage extends StatefulWidget {
  @override
  _OrganizationInviteUsersPageState createState() =>
      _OrganizationInviteUsersPageState();
}

class _OrganizationInviteUsersPageState
    extends State<OrganizationInviteUsersPage> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var showCard = false;

  @override
  void initState() {
    emailController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  void onListen() => setState(() {
        showCard = false;
      });

  @override
  Widget build(BuildContext context) {
    final rcvdData = ModalRoute.of(context)!.settings.arguments as Map;

    String? org = rcvdData['organization'] as String?;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Buscar usuario'),
      ),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              _emailFieldWidget(context),
              _botonInvitarUser(context, org)

              // buildNoAccount(),
            ],
          )),
    );
  }

  Widget _emailFieldWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.10,
          size.width * 0.1, size.height * 0.05),
      child: TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            prefixIcon: Icon(Icons.mail),
            suffixIcon: emailController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        emailController.clear();
                        showCard = false;
                      });
                    },
                  ),
          ),
          keyboardType: TextInputType.emailAddress,
          autofillHints: [AutofillHints.email],
          validator: (email) => email != null && !EmailValidator.validate(email)
              ? 'Introduzca un email válido'
              : null),
    );
  }

  Widget _botonInvitarUser(BuildContext context, String? org) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1, vertical: size.height * 0.015),
          child: Text(
            'Añadir usuario',
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
          showCard = false;

          if (form.validate()) {
            List<String?> usuariosOrg = await getEmails(org!);
            List<String> usuariosTodos = await getAllEmails();

            var set1 = Set.from(usuariosOrg);
            var set2 = Set.from(usuariosTodos);

            if (List.from(set2.difference(set1))
                .contains(emailController.text)) {
              if (await inviteUser(emailController.text, org)) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(
                      'La invitación ha sido enviada',
                      textAlign: TextAlign.center,
                    ),
                  ));
              }
              setState(() {
                Navigator.pop(context);
              });
            } else {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(
                    'El usuario no existe o ya participa en la organización',
                    textAlign: TextAlign.center,
                  ),
                ));
            }
          }
        });
  }
}
