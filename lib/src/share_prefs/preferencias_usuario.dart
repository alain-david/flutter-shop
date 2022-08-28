import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  // ignore: unused_field
  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get logueado {
    return _prefs.getString('logueado') ?? 'login';
  }

  set logueado(String value) => _prefs.setString('logueado', value);

  //Get y Set del colorSecundario
  bool get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool value) => _prefs.setBool('colorSecundario', value);

  String get telefono {
    return _prefs.getString('telefono') ?? '';
  }

  set telefono(String value) => _prefs.setString('telefono', value);

  String get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String value) => _prefs.setString('nombre', value);

  String get direccion {
    return _prefs.getString('direccion') ?? '';
  }

  set direccion(String value) => _prefs.setString('direccion', value);
}
