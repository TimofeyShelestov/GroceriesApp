import 'package:flutter/material.dart';
import 'package:grocery_app/components/list_card.dart';
import 'package:grocery_app/db/db.dart';
import 'package:grocery_app/pages/grocery_list_create_page.dart';

class AllListPage extends StatelessWidget {
  const AllListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: <ListCard>[
              for (var i = 0; i < db.length; i++)
                ListCard(
                    name: db[i]['title'],
                    description: 'Test description',
                    id: i)
            ],
          ),
          Positioned(
            bottom: 16 + 8,
            right: 16 + 8,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GroceryListCreatePage(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
