import 'package:flutter/material.dart';

import 'package:shop/src/models/producto_model.dart';
import 'package:shop/src/providers/productos_provider.dart';
import 'package:shop/src/share_prefs/preferencias_usuario.dart';

class CatDataPage extends StatelessWidget {
  CatDataPage({Key? key}) : super(key: key);

  final prefs = PreferenciasUsuario();
  final productosProvider = ProductosProvider();
  late final Map<String, dynamic> categoria;
  final producto = ProductoModel();

  @override
  Widget build(BuildContext context) {
    categoria =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    producto.categoria = categoria["numb"];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoria["nombre"]),
      ),
      body: _crearListado(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'producto', arguments: producto);
        },
      ),
    );
  }

  _crearListado() {
    return FutureBuilder(
        future: productosProvider.cargarProductos(categoria["numb"]),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductoModel>> snapshopt) {
          if (snapshopt.hasData) {
            final productos = snapshopt.data;
            return ListView.separated(
                itemCount: productos!.length,
                separatorBuilder: (context, i) => const Divider(),
                itemBuilder: (context, i) => _crearItem(context, productos[i]));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    if (producto.telefono == prefs.telefono) {
      return Dismissible(
        key: UniqueKey(),
        onDismissed: (direccion) {
          producto.categoria = categoria["numb"];
          productosProvider.borrarProducto(producto.categoria, producto.id);
        },
        child: ListTile(
          title: Text(
            '${producto.nombre} - ${producto.precio} CUP',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: SizedBox(
            width: 80,
            height: 80,
            child: (producto.imagenUrl != '')
                ? FadeInImage(
                    image: NetworkImage(producto.imagenUrl),
                    placeholder: const AssetImage('assets/loading.gif'),
                  )
                : const Image(
                    image: AssetImage('assets/no-image.jpg'),
                  ),
          ),
          // onTap: () {
          //   producto.categoria = categoria["numb"];
          //   Navigator.pushNamed(context, 'producto', arguments: producto);
          // },
        ),
      );
    } else {
      return Container();
    }
  }
}
