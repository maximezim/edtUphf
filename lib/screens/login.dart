import 'package:edt/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:edt/config/fonctions.dart';
import 'package:edt/config/config.dart';

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
                  // if (edtLogin.text != '' && edtPassword.text != '') {
                  //   login(edtLogin.text, edtPassword.text).then((value) {
                  //     if (value == true) {
                  //       Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => const DemoBottomAppBar(isElevated: true,isVisible: true),
                  //         ),
                  //       );
                  //     } else {
                  //       showSnackBar(context, 'Erreur de connexion');
                  //     }
                  //   });
                  // } else {
                  //   showSnackBar(context, 'Veuillez remplir tous les champs');
                  // }
                  Storage.storeLogin(edtLogin.text, edtPassword.text);
                  Storage.connected = true;
                  Storage.setConnected(Storage.connected);
                  route(
                      context,
                      Menu(
                          isconnected: Storage.connected,
                          title:
                              '${DateTime.now().day} ${Mois.mois[DateTime.now().month - 1]}'));
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
