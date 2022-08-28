import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/src/share_prefs/preferencias_usuario.dart';
import 'package:shop/src/widgets/categorias_widget.dart';
import 'package:shop/src/widgets/productos_widget.dart';
import 'package:shop/src/theme/theme.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final prefs = PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final screenSize = MediaQuery.of(context).copyWith().size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'La Tisa Shop',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(appTheme.darktheme
                ? Icons.mode_night
                : Icons.mode_night_outlined),
            onPressed: () {
              if (appTheme.darktheme) {
                setState(() {
                  appTheme.darktheme = false;
                  prefs.colorSecundario = appTheme.darktheme;
                });
              } else {
                setState(() {
                  appTheme.darktheme = true;
                  prefs.colorSecundario = appTheme.darktheme;
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoriasWidget(),
          SizedBox(height: screenSize.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: const Text(
              'Servicios',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
          ProductosWidget(),
        ],
      ),
    );
  }
}
