import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/pages/data_page.dart';

import 'package:shop/src/pages/inicio_page.dart';
import 'package:shop/src/share_prefs/preferencias_usuario.dart';
import 'package:shop/src/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prefs = PreferenciasUsuario();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    prefs.logueado = 'home';
    return Scaffold(
      body: _page(currentIndex),
      bottomNavigationBar: _bottonNavigatonBar(),
    );
  }

  Widget _page(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return const InicioPage();
      case 1:
        return DataPage();
      default:
        return const InicioPage();
    }
  }

  Widget _bottonNavigatonBar() {
    final appTheme = Provider.of<ThemeChanger>(context);
    return BottomNavigationBar(
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      backgroundColor:
          (appTheme.darktheme) ? const Color.fromRGBO(31, 40, 68, 1) : null,
      iconSize: 30,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_customize), label: 'Míos'),
      ],
    );
  }
}
