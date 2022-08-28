import 'package:flutter/material.dart';
import 'package:shop/src/share_prefs/preferencias_usuario.dart';

class CategoriasWidget extends StatelessWidget {
  CategoriasWidget({Key? key}) : super(key: key);

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.23,
  );
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

  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height * 0.15,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: categorias.length,
        itemBuilder: (context, i) => _tarjeta(context, categorias[i]),
      ),
    );
  }

  Widget _tarjeta(context, Map<String, dynamic> categoria) {
    final screenSize = MediaQuery.of(context).size;
    final tarjeta = Container(
      padding: EdgeInsets.only(right: screenSize.height * 0.01),
      child: Column(
        children: [
          ClipRRect(
            child: CircleAvatar(
              radius: screenSize.width * 0.12,
              child: Icon(
                categoria['icon'],
                size: screenSize.width * 0.12,
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Text(
            categoria['nombre'],
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'categoria', arguments: categoria);
      },
    );
  }
}
