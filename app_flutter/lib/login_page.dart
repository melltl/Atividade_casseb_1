import 'dart:convert';
import 'package:flutter/material.dart';
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
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  String _mensagemErro = '';

  void _fazerLogin() async {
    final email = _emailController.text;
    final senha = _senhaController.text;

    final sucesso = await ApiService.login(email, senha);

    if (sucesso) {
      setState(() {
        _mensagemErro = '';
      });
      // Navega para a próxima tela ou mostra sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login realizado com sucesso!')),
      );
    } else {
      setState(() {
        _mensagemErro = 'Email ou senha incorretos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fazerLogin,
              child: Text('Entrar'),
            ),
            if (_mensagemErro.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _mensagemErro,
                  style: TextStyle(color: Colors.red),
                ),
              )
          ],
        ),
      ),
    );
  }
}
