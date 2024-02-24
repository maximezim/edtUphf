import 'package:edt/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:edt/widgets/bab.dart';
import 'package:edt/screens/login.dart';
import 'package:edt/data/manager/datamanager.dart';
import 'package:edt/data/models/jour.dart';
import 'package:edt/widgets/lessontile.dart';

class Menu extends StatefulWidget {
  final String username;
  final String password;
  final bool isconnected;
  final String title;
  const Menu(
      {super.key,
      required this.isconnected,
      required this.title,
      required this.username,
      required this.password});

  @override
  State<Menu> createState() => MenuState();
}

class MenuState extends State<Menu> {
  late Future<SchoolDay> schoolDay;
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    schoolDay =
        DataManager.instance.getSchoolDay(widget.username, widget.password);
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
          // padding: const EdgeInsets.all(10),
          child: buildBody(),
        ),
        bottomNavigationBar: DemoBottomAppBar(
            isElevated: true,
            isVisible: true,
            onNextDay: onNextDay,
            onPreviousDay: onPreviousDay),
      ),
    );
  }

  FutureBuilder buildBody() {
    return FutureBuilder<SchoolDay>(
      future: schoolDay,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const LinearProgressIndicator();
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data!.lessons.length,
              itemBuilder: (context, index) {
                return LessonTile(snapshot.data!.lessons[index]);
              },
            );
          default:
            return Center(
              child: Text('Erreur: ${snapshot.error}'),
            );
        }
      },
    );
  }

  void onNextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
      schoolDay = DataManager.instance.getNextSchoolDay();
    });
  }

  void onPreviousDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: -1));
      schoolDay = DataManager.instance.getPreviousSchoolDay();
    });
  }
}
