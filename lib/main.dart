import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/src/pages/data_cat_page.dart';
import 'package:shop/src/pages/categoria_page.dart';
import 'package:shop/src/pages/detalles_page.dart';
import 'package:shop/src/pages/home_page.dart';
import 'package:shop/src/pages/login_page.dart';
import 'package:shop/src/pages/producto_page.dart';
import 'package:shop/src/theme/theme.dart';
import 'src/share_prefs/preferencias_usuario.dart';

void main() async {
// Cargar preferencias de usuarios antes de ejecutar el runApp()
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeChanger(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciasUsuario();
    final appTheme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: (appTheme.darktheme) ? miTema : ThemeData.light(),
      title: 'Shop App',
      initialRoute: prefs.logueado,
      routes: {
        'login': (context) => const LoginPage(),
        'home': (context) => const HomePage(),
        'detalles': (context) => const DetallesPage(),
        'categoria': (context) => CategoriaPage(),
        'producto': (context) => const ProductoPage(),
        'catData': (context) => CatDataPage(),
      },
    );
  }
}
