import 'dart:convert';

ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel producto) =>
    json.encode(producto.toJson());

class ProductoModel {
  ProductoModel({
    this.categoria = '',
    this.descripcion = '',
    this.direccion = '',
    this.domicilio = false,
    this.id = '',
    this.imagenUrl = '',
    this.moneda = 'CUP',
    this.nombre = '',
    this.precio = 0,
    this.precioDom = 0,
    this.telefono = '',
    this.vendedor = '',
  });

  String categoria;
  String descripcion;
  String direccion;
  bool domicilio;
  String id;
  String imagenUrl;
  String moneda;
  String nombre;
  double precio;
  double precioDom;
  String telefono;
  String vendedor;

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        descripcion: json["descripcion"],
        direccion: json["direccion"],
        domicilio: json["domicilio"],
        id: json["id"],
        moneda: json["moneda"],
        nombre: json["nombre"],
        precio: json["precio"].toDouble(),
        precioDom: json["precioDom"].toDouble(),
        telefono: json["telefono"],
        imagenUrl: json["imagenUrl"],
        vendedor: json["vendedor"],
      );

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "direccion": direccion,
        "domicilio": domicilio,
        // "id": id,
        "moneda": moneda,
        "nombre": nombre,
        "precio": precio,
        "precioDom": precioDom,
        "telefono": telefono,
        "imagenUrl": imagenUrl,
        "vendedor": vendedor
      };
}
