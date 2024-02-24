import 'package:flutter/material.dart';

import '../config/config.dart';
import '../config/fonctions.dart';
import '../screens/login.dart';
import '../screens/menu.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool shadowColor = false;
  final double scrolledUnderElevation = 3.0;
  final DateTime date;
  const TopAppBar({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = "${date.day} ${Mois.mois[date.month - 1]}";

    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(formattedDate),
      scrolledUnderElevation: scrolledUnderElevation,
      shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
      actions: <Widget>[
        IconButton(
          tooltip: 'Menu',
          icon: const Icon(Icons.home),
          onPressed: () {
            route(
                context,
                Menu(
                    isconnected: Storage.connected,
                    title:
                        '${DateTime.now().day} ${Mois.mois[DateTime.now().month - 1]}',
                    username: Storage.id,
                    password: Storage.password));
          },
        ),
        PopupMenuButton(
          tooltip: 'Open popup menu',
          icon: const Icon(Icons.more_vert),
          initialValue: null,
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Déconnexion'),
                  onTap: () {
                    Storage.setConnected(false);
                    route(context, const Login());
                  },
                ),
              ),
              PopupMenuItem(
                  child: ListTile(
                leading: const Icon(Icons.monetization_on),
                title: const Text('Me soutenir'),
                onTap: () {
                  // TODO
                },
              )),
            ];
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
