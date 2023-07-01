import 'package:edt/widgets/topbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:edt/config/fonctions.dart';
import 'package:edt/widgets/bab.dart';
import 'package:edt/screens/login.dart';

class Menu extends StatefulWidget {
  final bool isconnected;
  final String title;
  const Menu({super.key, required this.isconnected, required this.title});

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
        appBar: TopAppBar(title: widget.title),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // loop to create 5 cards
                for (int i = 0; i < 6; i++)
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
        bottomNavigationBar:
            const DemoBottomAppBar(isElevated: true, isVisible: true),
      ),
    );
  }
}
