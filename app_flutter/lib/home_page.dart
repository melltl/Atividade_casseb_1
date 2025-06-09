import 'package:flutter/material.dart';
import 'package:app_flutter/api_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> items = [];
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  void fetchItems() async {
    final data = await ApiService.getItems();
    setState(() {
      items = data;
    });
  }

  void addItem() async {
    await ApiService.addItem(controller.text);
    controller.clear();
    fetchItems();
  }

  void deleteItem(int id) async {
    await ApiService.deleteItem(id);
    fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Itens')),
      body: Column(
        children: [
          TextField(controller: controller, decoration: InputDecoration(labelText: 'Novo item')),
          ElevatedButton(onPressed: addItem, child: Text('Adicionar')),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item['name']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteItem(item['id']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
