import 'package:flutter/material.dart';
import 'package:grocery_app/components/appbar.dart';
import 'package:grocery_app/components/error_snackbar.dart';
import 'package:grocery_app/db/db.dart';
import 'package:grocery_app/pages/all_list_page.dart';

class GroceryListCreatePage extends StatefulWidget {
  const GroceryListCreatePage({super.key});

  @override
  State<GroceryListCreatePage> createState() => _GroceryListCreatePage();
}

class _GroceryListCreatePage extends State<GroceryListCreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _itemTitleController = TextEditingController();
  final TextEditingController _itemAmountController = TextEditingController();
  final List<Object> _groceryItems = [];

  void _addItem() {
    final itemTitle = _itemTitleController.text.trim();
    final itemAmount = _itemAmountController.text.trim();
    if (itemTitle.isNotEmpty && itemAmount.isNotEmpty) {
      setState(() {
        _groceryItems.add(
          {"title": itemTitle, "amount": itemAmount},
        );
      });
      _itemTitleController.clear();
      _itemAmountController.clear();
    }
  }

  void _saveList() {
    final title = _titleController.text.trim();
    if (title.isNotEmpty && _groceryItems.isNotEmpty) {
      final groceryObj = {"title": title, "list": _groceryItems};
      db.add(groceryObj);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AllListPage(),
        ),
      );
    } else {
      ErrorSnackbar.show(
          context, 'You should have at list one item and defined title');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Grocery List',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'List title',
                labelStyle: TextStyle(color: colorScheme.primary),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _itemTitleController,
              decoration: InputDecoration(
                labelText: 'Add Item',
                labelStyle: TextStyle(color: colorScheme.primary),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addItem,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: TextField(
                controller: _itemAmountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: colorScheme.primary),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _groceryItems.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey(_groceryItems[index]),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        _groceryItems.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Item removed')), // Optional feedback
                      );
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: colorScheme.surface,
                      child: ListTile(
                        title: Text(
                          (_groceryItems[index] as Map)['title'],
                          style: TextStyle(color: colorScheme.onSurface),
                        ),
                        trailing: Text(
                          (_groceryItems[index] as Map)['amount'],
                          style: TextStyle(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _saveList,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
