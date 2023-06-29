import 'package:flutter/material.dart';
import 'package:edt/config/fonctions.dart';
import 'package:edt/screens/menu.dart';
import 'package:edt/widgets/datepick.dart';
import 'package:edt/screens/login.dart';

import '../config/config.dart';

class DemoBottomAppBar extends StatelessWidget {
  const DemoBottomAppBar({
    super.key,
    required this.isElevated,
    required this.isVisible,
  });

  final bool isElevated;
  final bool isVisible;
  final DatePicker datePicker = const DatePicker(
    restorationId: 'example_restoration_id',
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 80.0 : 0,
      child: BottomAppBar(
        elevation: isElevated ? null : 0.0,
        child: Row(
          children: <Widget>[
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
              offset: const Offset(0, -150),
            ),
            IconButton(
              tooltip: 'Menu',
              icon: const Icon(Icons.home),
              onPressed: () {
                route(context, Menu(isconnected: Storage.connected));
              },
            ),
            IconButton(
              tooltip: 'Gauche',
              icon: const Icon(Icons.arrow_left),
              onPressed: () {
                // datePicker.previousPage();
              },
            ),
            IconButton(
              tooltip: 'Droite',
              icon: const Icon(Icons.arrow_right),
              onPressed: () {
                // datePicker.nextPage();
              },
            ),
            // IconButton(
            //   tooltip: 'Favorite',
            //   icon: const Icon(Icons.favorite),
            //   onPressed: () {},
            // ),
            const Expanded(child: SizedBox()),
            FloatingActionButton(
              tooltip: 'Choisir une date',
              child: const Icon(Icons.calendar_month),
              onPressed: () {
                route(context, datePicker);
              },
            ),
          ],
        ),
      ),
    );
  }
}
