import 'package:edt/data/database/databasehelper.dart';
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
  final Function(bool) onThemeToggle;
  const Menu({
    super.key,
    required this.isconnected,
    required this.title,
    required this.username,
    required this.password,
    required this.onThemeToggle,
  });

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
        appBar:
            TopAppBar(date: selectedDate, onThemeToggle: widget.onThemeToggle),
        body: Center(
          // Center the content vertically and horizontally
          child: buildBody(),
        ),
        bottomNavigationBar: DemoBottomAppBar(
          isElevated: true,
          isVisible: true,
          onNextDay: onNextDay,
          onPreviousDay: onPreviousDay,
          onDateSelected: onDateSelected,
        ),
      ),
    );
  }

  Widget buildBody() {
    return FutureBuilder<SchoolDay>(
      future: schoolDay,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            // Place the loading indicator at the top of the screen
            return Column(
              children: [
                const LinearProgressIndicator(),
                Expanded(child: Container()), // Keeps the indicator at the top
              ],
            );
          case ConnectionState.done:
            // Ensure there's data before trying to build the list
            if (snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.lessons.length,
                itemBuilder: (context, index) {
                  return LessonTile(snapshot.data!.lessons[index]);
                },
              );
            } else {
              return const Text('No data available');
            }
          default:
            return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }

  void onNextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
      schoolDay = DataManager.instance.getSpecificDay(selectedDate);
    });
  }

  void onPreviousDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
      schoolDay = DataManager.instance.getSpecificDay(selectedDate);
    });
  }

  void onDateSelected(DateTime newSelectedDate) {
    setState(() {
      selectedDate = newSelectedDate;
      schoolDay = DataManager.instance.getSpecificDay(selectedDate);
    });
  }
}
