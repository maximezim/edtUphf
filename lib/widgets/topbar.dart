import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../config/config.dart';
import '../config/fonctions.dart';
import '../screens/login.dart';
import '../screens/menu.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool shadowColor = false;
  final double scrolledUnderElevation = 3.0;
  final DateTime date;
  final Function(bool) onThemeToggle;

  const TopAppBar({
    super.key,
    required this.date,
    required this.onThemeToggle,
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
                    password: Storage.password,
                    onThemeToggle: onThemeToggle));
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
              // PopupMenuItem(
              //     child: ListTile(
              //   leading: const Icon(Icons.monetization_on),
              //   title: const Text('Me soutenir'),
              //   onTap: () {
              //     // TODO
              //   },
              // )),
              PopupMenuItem(
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    bool isDarkMode = GetStorage().read('isDarkMode') ?? false;
                    return ListTile(
                      leading: const Icon(Icons.brightness_4),
                      title: const Text('Dark Mode'),
                      trailing: Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            GetStorage().write('isDarkMode', value);
                            isDarkMode = value;
                            onThemeToggle(value);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
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
