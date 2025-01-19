import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/components/appbar.dart';
import 'package:grocery_app/components/list_card.dart';
import 'package:grocery_app/db/db.dart';
import 'package:grocery_app/pages/grocery_list_create_page.dart';
import 'package:grocery_app/themes/provider.dart';
import 'package:provider/provider.dart';

class AllListPage extends StatefulWidget {
  const AllListPage({super.key});

  @override
  State<AllListPage> createState() => _AllListPageState();
}

class _AllListPageState extends State<AllListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "All Groceries List",
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
