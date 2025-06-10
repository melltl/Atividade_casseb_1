import 'package:flutter/material.dart';
import 'package:app_flutter/login_page.dart'; // <- IMPORTANTE

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App com API',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(), // <- Aqui usa a classe que deve estar declarada/importada
    );
  }
}
