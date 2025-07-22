import 'dart:convert';
import 'package:helios_test/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String _baseUrl = 'https://randomuser.me/api/';
  static const int _resultsPerPage = 20;

  Future<List<User>> fetchUsers({int page = 1}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final uri = Uri.parse(
      '$_baseUrl?results=$_resultsPerPage&page=$page&seed=heliosTest',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];

      return results.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Erreur lors du chargement des utilisateurs');
    }
  }
}
