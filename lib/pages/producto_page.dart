import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../models/producto_model.dart';
import '../providers/productos_provider.dart';
import '../share_prefs/preferencias_usuario.dart';
import '../theme/theme.dart';
import '../utils/validators.dart' as utils;

class ProductoPage extends StatefulWidget {
  const ProductoPage({Key? key}) : super(key: key);

  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final prefs = PreferenciasUsuario();
  final formKey = GlobalKey<FormState>();
  final productoProvider = ProductosProvider();
  int moneda = 1;

  ProductoModel producto = ProductoModel();
  bool _guardando = false;
  XFile? imagen;

  @override
  Widget build(BuildContext context) {
    final ProductoModel? productoArguments =
        ModalRoute.of(context)!.settings.arguments as ProductoModel?;

    if (productoArguments != null) {
      producto = productoArguments;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Producto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: () => _seleccionarFoto(ImageSource.gallery),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () => _seleccionarFoto(ImageSource.camera),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _nombre(),
                _precio(),
                _moneda(),
                _domicilio(),
                _precioDom(),
                _descripcion(),
                const SizedBox(height: 10),
                _botton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mostrarFoto() {
    if (producto.imagenUrl != '') {
      return FadeInImage(
        image: NetworkImage(producto.imagenUrl),
        placeholder: const AssetImage('assets/loading.gif'),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        height: 300,
        child: imagen == null
            ? const Icon(
                Icons.add_a_photo,
                size: 150,
              )
            : Image(
                image: FileImage(File(imagen!.path)),
                fit: BoxFit.cover,
              ),
      );
    }
  }

  Future _seleccionarFoto(ImageSource origen) async {
    imagen = await ImagePicker().pickImage(
      source: origen,
      imageQuality: 20,
    );

    if (imagen != null) {
      producto.imagenUrl = '';
    }

    setState(() {});
  }

  Widget _nombre() {
    return TextFormField(
      initialValue: producto.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        labelText: 'Nombre',
      ),
      onSaved: (value) => producto.nombre = value!,
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese un nombre valido';
        } else {
          return null;
        }
      },
    );
  }

  Widget _precio() {
    return TextFormField(
      initialValue: producto.precio.toString(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (value) => producto.precio = double.parse(value!),
      validator: (value) {
        if (double.parse(value!) >= 1) {
          return null;
        } else {
          return 'El precio tiene que ser mayor que 0';
        }
      },
    );
  }

  Widget _moneda() {
    return Column(
      children: [
        RadioListTile(
          value: 1,
          title: const Text('CUP'),
          groupValue: moneda,
          onChanged: (int? value) {
            setState(() {
              moneda = value!;
            });
          },
        ),
        RadioListTile(
          value: 2,
          title: const Text('MLC'),
          groupValue: moneda,
          onChanged: (int? value) {
            setState(() {
              moneda = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _domicilio() {
    final appTheme = Provider.of<ThemeChanger>(context);

    return SwitchListTile(
      value: producto.domicilio,
      title: const Text('Domicilio'),
      activeColor:
          (appTheme.darktheme) ? const Color.fromRGBO(247, 140, 148, 1) : null,
      onChanged: (value) => setState(() {
        producto.domicilio = value;
      }),
    );
  }

  Widget _precioDom() {
    return TextFormField(
      initialValue: producto.precioDom.toString(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(
        labelText: 'Precio Domicilio',
      ),
      onSaved: (value) => producto.precioDom = double.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Sólo números';
        }
      },
    );
  }

  Widget _descripcion() {
    return TextFormField(
      initialValue: producto.descripcion,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        labelText: 'Descripción',
      ),
      onSaved: (value) => producto.descripcion = value!,
    );
  }

  Widget _botton() {
    final appTheme = Provider.of<ThemeChanger>(context);

    return ElevatedButton.icon(
      icon: const Icon(Icons.save),
      label: const Text('Guardar'),
      style: ElevatedButton.styleFrom(
        primary: (appTheme.darktheme)
            ? const Color.fromRGBO(247, 140, 148, 1)
            : null,
        onPrimary: Colors.white,
      ),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState?.save();

    setState(() {
      _guardando = true;
    });

    if (imagen != null) {
      producto.imagenUrl = (await productoProvider.subirImagen(imagen))!;
    } else {
      // producto.imagenUrl = '';
    }

    producto.moneda = (moneda == 1) ? 'CUP' : 'MLC';
    producto.vendedor = prefs.nombre;
    producto.telefono = prefs.telefono;
    producto.direccion = prefs.direccion;

    if (producto.id == '') {
      productoProvider.crearProducto(producto.categoria, producto);
    } else {
      productoProvider.editarProducto(producto.categoria, producto);
    }

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
