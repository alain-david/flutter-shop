import 'package:flutter/material.dart';
import '../models/producto_model.dart';

class DetallesPage extends StatelessWidget {
  const DetallesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductoModel? productoArguments =
        ModalRoute.of(context)!.settings.arguments as ProductoModel?;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(productoArguments!),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _caracteristicas(productoArguments),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _appBar(ProductoModel productoArguments) {
    return SliverAppBar(
      expandedHeight: 400,
      flexibleSpace: FlexibleSpaceBar(
        background: (productoArguments.imagenUrl != '')
            ? FadeInImage(
                image: NetworkImage(productoArguments.imagenUrl),
                placeholder: const AssetImage('assets/loading.gif'),
                fit: BoxFit.cover,
              )
            : const Image(
                image: AssetImage('assets/no-image.jpg'),
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  _caracteristicas(ProductoModel productoArguments) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            productoArguments.nombre,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Precio: '
            '${productoArguments.precio} - ${productoArguments.moneda}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Domicilio: '
            '${productoArguments.domicilio ? 'Si' : 'No'}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          if (productoArguments.domicilio) const SizedBox(height: 12),
          if (productoArguments.domicilio)
            if (productoArguments.precioDom == 0)
              const Text(
                'Precio domicilio: Gratis',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            else
              Text(
                'Precio domicilio: ${productoArguments.precioDom}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
          const SizedBox(height: 12),
          Text(
            'Vendedor: ${productoArguments.vendedor}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Teléfono: ${productoArguments.telefono}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Dirección: ${productoArguments.direccion}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Divider(),
          Text(productoArguments.descripcion),
        ],
      ),
    );
  }
}
