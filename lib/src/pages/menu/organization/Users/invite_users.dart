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

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> rcvdData =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
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
              if (!showCard) _botonBuscar(context, org) else _prueba(context),
              if (showCard) _botonInvitar(context, org),

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

  Widget _botonBuscar(BuildContext context, String? org) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1, vertical: size.height * 0.015),
          child: Text(
            'Buscar usuario',
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
              showCard = true;
              setState(() {});
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

  Widget _prueba(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
      child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(255, 141, 67, 1)),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white))),
              child: Icon(Icons.people, color: Colors.white),
            ),
            title: Text(
              emailController.text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0),
            onTap: () {},
          )),
    );
  }

  Widget _botonInvitar(BuildContext context, String? org) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1, vertical: size.height * 0.015),
          child: Text(
            'Invitar ',
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
            if (await inviteUser(emailController.text, org!)) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text('La invitación ha sido enviada'),
                ));
            }
            showCard = false;

            setState(() {});
          }
        });
  }
}
