import 'package:flutter/material.dart';
import 'package:edt/config/fonctions.dart';
import 'package:edt/widgets/navbar.dart';
import 'package:edt/screens/menu.dart';

import '../config/config.dart';

class Parametres extends StatefulWidget {
  const Parametres({super.key});

  @override
  State<Parametres> createState() => ParametresState();
}

class ParametresState extends State<Parametres> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          route(context, Menu(isconnected: Storage.connected));
          return false;
        },
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, width(context) / 6),
              child: const Padding(
                padding: EdgeInsets.all(10),
                // child: Appbar(home: true, enjeu: false, retour: () => {}),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Paramètres',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      // AnimatedButton
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Déconnexion')),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Soutenir')),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: const Navbar(
              actif: 2,
            )));
  }
}
