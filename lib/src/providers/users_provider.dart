import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/src/models/user_model.dart';

class UsersProvider {
  final String _url = 'la-tisa-shop-default-rtdb.firebaseio.com';

  Future<List<UserModel>> cargarUsers() async {
    final url = Uri.https(_url, '/users.json');
    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final List<UserModel> users = [];

    if (decodedData == null) return [];

    decodedData.forEach((id, user) {
      final userTemp = UserModel.fromJson(user);

      users.add(userTemp);
    });

    return users;
  }
}
