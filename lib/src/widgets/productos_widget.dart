import 'package:flutter/material.dart';
import 'package:shop/src/models/producto_model.dart';

class ProductosWidget extends StatelessWidget {
  ProductosWidget({Key? key}) : super(key: key);

  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final ProductoModel producto = ProductoModel();

    return SizedBox(
      height: screenSize.height * 0.52,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: 6,
        itemBuilder: (context, i) => _tarjeta(context, producto),
      ),
    );
  }

  Widget _tarjeta(context, ProductoModel producto) {
    final screenSize = MediaQuery.of(context).size;
    final tarjeta = Container(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: const FadeInImage(
          image: NetworkImage(
              'https://www.etecsa.cu/sites/default/files/secciones/NAUTAHOGAR_NAUTA_PERSONAS_ETECSA_2.jpg'),
          placeholder: AssetImage('assets/no-image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
    return GestureDetector(
      child: tarjeta,
      onTap: () {
        // Navigator.pushNamed(context, 'detalles', arguments: producto);
      },
    );
  }
}
