import 'package:edt/widgets/topbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:edt/config/fonctions.dart';
import 'package:edt/widgets/bab.dart';
import 'package:edt/screens/login.dart';

class Menu extends StatefulWidget {
  final bool isconnected;
  const Menu({super.key, required this.isconnected});

  @override
  State<Menu> createState() => MenuState();
}

class MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("connected: ${widget.isconnected}");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isconnected) {
      return const Login();
    }
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: const TopAppBar(title: "Test"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // loop to create 5 cards
                for (int i = 0; i < 8; i++)
                  Center(
                    child: Card(
                      child: SizedBox(
                        width: width(context) * 0.9,
                        height: height(context) * 0.12,
                        child: const Center(child: Text('Elevated Card')),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: Navbar(
        //   actif: 0,
        //   // reaload: () {
        //   //   Navigator.push(
        //   //       context,
        //   //       PageRouteBuilder(
        //   //         pageBuilder: (context, animation, secondaryAnimation) =>
        //   //             const Parametre(),
        //   //         transitionDuration: const Duration(seconds: 0),
        //   //       )).then((value) {
        //   //     setState(() {});
        //   //   });
        //   // }
        // )
        bottomNavigationBar:
            const DemoBottomAppBar(isElevated: true, isVisible: true),
      ),
    );
  }
}
