import 'package:flutter/material.dart';
import 'package:edt/config/fonctions.dart';
import 'package:edt/screens/menu.dart';

import '../config/config.dart';

class TestData extends StatefulWidget {
  const TestData({super.key});

  @override
  State<TestData> createState() => TestDataState();
}

class TestDataState extends State<TestData> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        route(
            context,
            Menu(
                isconnected: Storage.connected,
                title:
                    '${DateTime.now().day} ${Mois.mois[DateTime.now().month - 1]}'));
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
                    'Data',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
