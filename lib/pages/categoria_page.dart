import 'package:flutter/material.dart';

import '../models/producto_model.dart';
import '../providers/productos_provider.dart';

class CategoriaPage extends StatelessWidget {
  CategoriaPage({Key? key}) : super(key: key);

  final productosProvider = ProductosProvider();
  late final Map<String, dynamic> categoria;

  @override
  Widget build(BuildContext context) {
    categoria =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoria['nombre']),
      ),
      body: _crearListado(),
    );
  }

  _crearListado() {
    return FutureBuilder(
        future: productosProvider.cargarProductos(categoria['numb']),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductoModel>> snapshopt) {
          if (snapshopt.hasData) {
            final productos = snapshopt.data;
            return ListView.builder(
              itemCount: productos!.length,
              itemBuilder: (context, i) => _crearItem(context, productos[i]),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, 'detalles', arguments: producto),
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 180,
        width: 340,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 180,
                width: 140,
                child: (producto.imagenUrl != '')
                    ? FadeInImage(
                        image: NetworkImage(producto.imagenUrl),
                        placeholder: const AssetImage('assets/loading.gif'),
                        fit: BoxFit.cover,
                      )
                    : const Image(
                        image: AssetImage('assets/no-image.jpg'),
                      ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    producto.nombre,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${producto.precio} - ${producto.moneda}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Domicilio: ' '${producto.domicilio ? 'Si' : 'No'}',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
