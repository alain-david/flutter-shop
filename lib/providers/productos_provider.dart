import 'dart:convert';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

import '../models/producto_model.dart';

class ProductosProvider {
  final String _url = '152.206.139.203:8090';

  Future<List<ProductoModel>> cargarProductos(categoria) async {
    final url = Uri.http(_url, '/api/collections/$categoria/records');
    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final List<ProductoModel> productos = [];

    if (decodedData['items'] == null) return [];

    decodedData['items'].forEach((producto) {
      final productoTemp = ProductoModel.fromJson(producto);

      productos.add(productoTemp);
    });

    return productos;
  }

  Future<bool> crearProducto(String categoria, ProductoModel producto) async {
    final url = Uri.http(_url, '/api/collections/$categoria/records');

    await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: productoModelToJson(producto));

    return true;
  }

  Future<bool> editarProducto(String categoria, ProductoModel producto) async {
    final url =
        Uri.http(_url, '/api/collections/alimentos/$categoria/${producto.id}');

    // print(producto.id);

    final resp = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: productoModelToJson(producto),
    );

    // print(resp.body);

    return true;
  }

  Future<int> borrarProducto(String categoria, String id) async {
    final url = Uri.http(_url, '/api/collections/$categoria/records/$id');

    await http.delete(url);

    return 1;
  }

  Future<String?> subirImagen(XFile? imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/la-tisa-shop/image/upload?upload_preset=latisashop');
    final mimeType = mime(imagen!.path)!.split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      // print('Algo salio mal');
      // print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    // print(respData);

    return respData['secure_url'];
  }
}
