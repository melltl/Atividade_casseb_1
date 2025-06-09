import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000'; // Android Emulator
  static final storage = FlutterSecureStorage();

  static Future<bool> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'username': email, 'password': senha},
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      await storage.write(key: 'token', value: body['access_token']);
      return true;
    }
    return false;
  }

  static Future<List<dynamic>> getItems() async {
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/items'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Erro ao buscar itens');
  }

  static Future<void> addItem(String name) async {
    final token = await storage.read(key: 'token');
    await http.post(
      Uri.parse('$baseUrl/items'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'name': name}),
    );
  }

  static Future<void> deleteItem(int id) async {
    final token = await storage.read(key: 'token');
    await http.delete(
      Uri.parse('$baseUrl/items/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
