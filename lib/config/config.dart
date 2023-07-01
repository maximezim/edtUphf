import 'package:get_storage/get_storage.dart';

class Storage {
  static var connected = false;
  static var id = "";
  static var password = "";

  static void storeLogin(String id, String password) async {
    GetStorage().write("id", id);
    GetStorage().write("password", password);
  }

  static void deleteLogin() async {
    GetStorage().remove("id");
    GetStorage().remove("password");
  }

  static void setConnected(bool connected) {
    GetStorage().write("connected", connected);
    Storage.connected = connected;
  }

  static bool isConnected() {
    bool connected = GetStorage().read("connected") ?? false;
    return connected;
  }

  static Object fetchLogin() {
    String? id = GetStorage().read("id");
    String? password = GetStorage().read("password");
    if (id == null || password == null) {
      return false;
    }
    return (Storage.id, Storage.password);
  }
}

class Mois {
  // liste des mois
  static List<String> mois = [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre"
  ];
}
