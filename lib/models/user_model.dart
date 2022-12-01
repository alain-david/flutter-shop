import 'dart:convert';

UserModel usersModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String usersModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.direccion = '',
    this.nombre = '',
    this.password = '',
    this.telefono = '',
  });

  String direccion;
  String nombre;
  String password;
  String telefono;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        direccion: json["direccion"],
        nombre: json["nombre"],
        password: json["password"],
        telefono: json["telefono"],
      );

  Map<String, dynamic> toJson() => {
        "direccion": direccion,
        "nombre": nombre,
        "password": password,
        "telefono": telefono,
      };
}
