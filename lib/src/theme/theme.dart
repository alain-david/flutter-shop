import 'package:flutter/material.dart';
import 'package:shop/src/share_prefs/preferencias_usuario.dart';

class ThemeChanger with ChangeNotifier {
  bool _darktheme = PreferenciasUsuario().colorSecundario;

  bool get darktheme => _darktheme;

  set darktheme(value) {
    _darktheme = value;
    notifyListeners();
  }
}

final miTema = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark(
    secondary: Color.fromRGBO(247, 140, 148, 1),
  ),
  scaffoldBackgroundColor: const Color.fromRGBO(31, 40, 68, 1),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Color.fromRGBO(31, 40, 68, 1),
  ),
);
