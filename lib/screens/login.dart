import 'package:edt/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:edt/config/fonctions.dart';
import 'package:edt/config/config.dart';
import 'package:edt/data/web/session.dart';
import 'package:flutter_login/flutter_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController edtLogin = TextEditingController();
  final TextEditingController edtPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<String?> authUser(LoginData data) async {
    String username = data.name;
    String password = data.password;
    try {
      if (!await Session.instance.isLog(username, password)) {
        return "Identifiant ou mot de passe incorrect";
      }
    } catch (e) {
      return e.toString().replaceAll("Exception: ", "");
    }
    Storage.storeLogin(username, password);
    Storage.setConnected(true);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        // two text fields
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Connexion',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: edtLogin,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Login',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: edtPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mot de passe',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (edtLogin.text.isEmpty || edtPassword.text.isEmpty) {
                    showSnackBar(context, "Veuillez remplir tous les champs");
                    return;
                  }
                  authUser(LoginData(
                    name: edtLogin.text,
                    password: edtPassword.text,
                  )).then((value) {
                    if (value != null) {
                      showSnackBar(context, value);
                      edtPassword.clear();
                      return;
                    }
                    route(
                        context,
                        Menu(
                            isconnected: Storage.connected,
                            title:
                                '${DateTime.now().day} ${Mois.mois[DateTime.now().month - 1]}',
                            username: Storage.id,
                            password: Storage.password));
                  });
                },
                child: const Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
