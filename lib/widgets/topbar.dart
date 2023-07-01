import 'package:flutter/material.dart';

import '../config/config.dart';
import '../config/fonctions.dart';
import '../screens/login.dart';
import '../screens/menu.dart';
import '../screens/testdata.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool shadowColor = false;
  final double scrolledUnderElevation = 3.0;
  final String? title;
  const TopAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!),
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
                        '${DateTime.now().day} ${Mois.mois[DateTime.now().month - 1]}'));
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
              PopupMenuItem(
                  child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Data'),
                onTap: () {
                  route(context, const TestData());
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
