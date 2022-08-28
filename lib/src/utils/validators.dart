import 'package:shop/src/providers/users_provider.dart';

final users = UsersProvider();

bool isNumeric(String? s) {
  if (s!.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}

// Future<String?> isUser(String? telefono) async {
//   final listaUsuarios = await users.cargarUsers();

//   for (var element in listaUsuarios) {
//     if (telefono == element.telefono) {
//       return null;
//     } else {
//       return 'Ingrese un # valido';
//     }
//   }
// }
