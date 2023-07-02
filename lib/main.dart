import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:edt/screens/menu.dart';
import 'package:get_storage/get_storage.dart';
import 'package:edt/config/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await GetStorage.init();
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _connected;
  @override
  void initState() {
    _connected = Storage.isConnected();
    Storage.setConnected(_connected);
    Date().selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            fontFamily: 'Poppins',
            colorSchemeSeed: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true),
        home: Menu(
            isconnected: _connected,
            title:
                '${DateTime.now().day} ${Mois.mois[DateTime.now().month - 1]}'));
  }
}
