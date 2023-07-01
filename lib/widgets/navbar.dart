import 'package:flutter/material.dart';
import 'package:edt/screens/parametres.dart';
import 'package:edt/config/fonctions.dart';
import 'package:edt/screens/menu.dart';

import '../config/config.dart';

class Navbar extends StatelessWidget {
  final int actif;

  const Navbar({super.key, required this.actif});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor:
          Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.1),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Accueil',
        ),
        // route to menu
        NavigationDestination(
          icon: Icon(Icons.calendar_month_outlined),
          selectedIcon: Icon(Icons.calendar_month),
          label: 'Date',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Paramètres',
        ),
      ],
      selectedIndex: actif,
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            route(
                context,
                Menu(
                    isconnected: Storage.connected,
                    title:
                        '${DateTime.now().day} ${Mois.mois[DateTime.now().month - 1]}'));
            break;
          case 1:
            // route(context, const NouvellePartie());
            break;
          case 2:
            route(context, const Parametres());
            break;
          default:
            // do nothing
            break;
        }
      },
    );
  }
}
