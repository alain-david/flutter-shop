import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/src/providers/productos_provider.dart';
import 'package:shop/src/theme/theme.dart';

class DataPage extends StatelessWidget {
  DataPage({Key? key}) : super(key: key);
  final List<Map<String, dynamic>> categorias = [
    {
      "nombre": "Alimentos",
      "icon": Icons.food_bank,
      "numb": "0",
    },
    {
      "nombre": "Automotriz",
      "icon": Icons.car_crash,
      "numb": "1",
    },
    {
      "nombre": "Belleza, Salud y Cuidado Personal",
      "icon": Icons.sports_gymnastics,
      "numb": "2",
    },
    {
      "nombre": "Computadoras",
      "icon": Icons.computer,
      "numb": "3",
    },
    {
      "nombre": 'Deportes',
      "icon": Icons.sports_baseball_outlined,
      "numb": "4",
    },
    {
      "nombre": 'Electrónicos',
      "icon": Icons.settings_cell_outlined,
      "numb": "5",
    },
    {
      "nombre": 'Hecho a mano',
      "icon": Icons.back_hand_outlined,
      "numb": "6",
    },
    {
      "nombre": 'Hogar, Jardín y Mazcotas',
      "icon": Icons.home_outlined,
      "numb": "7",
    },
    {
      "nombre": 'Juguetes y bebe',
      "icon": Icons.baby_changing_station,
      "numb": "8",
    },
    {
      "nombre": 'Oficina',
      "icon": Icons.menu_book_rounded,
      "numb": "9",
    },
    {
      "nombre": 'Ropa, Zapatos y Joyería',
      "icon": Icons.south_america_outlined,
      "numb": "10",
    },
  ];

  final productosProvider = ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            (appTheme.darktheme) ? const Color.fromRGBO(59, 68, 94, 1) : null,
        title: const Text(
          'Categorías',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      backgroundColor:
          (appTheme.darktheme) ? const Color.fromRGBO(59, 68, 94, 1) : null,
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          color:
              (appTheme.darktheme) ? const Color.fromRGBO(31, 40, 68, 1) : null,
          child: _crearListViewInt(),
        ),
      ),
    );
  }

  ListView _crearListViewInt() {
    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (context, i) => _listTile(context, categorias[i]),
    );
  }

  ListTile _listTile(BuildContext context, categoria) {
    return ListTile(
      title: Text(
        categoria["nombre"],
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      leading: Icon(categoria["icon"]),
      trailing: const Icon(
        Icons.arrow_circle_right_outlined,
        size: 30,
      ),
      onTap: () =>
          Navigator.pushNamed(context, 'catData', arguments: categoria),
    );
  }
}
