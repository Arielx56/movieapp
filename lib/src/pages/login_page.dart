import 'package:flutter/material.dart';
import 'package:movieapp_with_login/src/bloc/bloc_provaider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          userLogin(context),
        ],
      ),
    );
  }

  Widget userLogin(BuildContext context) {
    final data = BlocProvaider.of(context);
    return StreamBuilder(
      stream: data.userStream,
      builder: (context, snapshot) {
        return TextField(
          decoration: InputDecoration(
            hintText: 'Ingrese su usuario',
          ),
          onChanged: data.changeUser,
        );
      },
    );
  }
  Widget userPassword(BuildContext context) {
    final data = BlocProvaider.of(context);
    return StreamBuilder(
      stream: data.passwordStream,
      builder: (context, snapshot) {
        return TextField(
          decoration: InputDecoration(
            hintText: 'Ingrese su Contraseña',
          ),
          onChanged: data.changePassword,
        );
      },
    );
  }
  Widget btnLogin(BuildContext context){
    return RaisedButton(
    color: Colors.purpleAccent,
    child: Container(
      child: Text('Login'),
    ),
    onPressed: () {
      
    },
    );
  }
}
