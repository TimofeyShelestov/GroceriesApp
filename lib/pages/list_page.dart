import 'package:flutter/material.dart';
import 'package:grocery_app/components/appbar.dart';
import 'package:grocery_app/db/db.dart';

class ListPage extends StatelessWidget {
  final int id;

  const ListPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final listData = db[id];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'title',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listData['list'].length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: colorScheme.surface,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: colorScheme.primary.withOpacity(0.2),
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(color: colorScheme.primary),
                        ),
                      ),
                      title: Text(
                        listData['list'][index],
                        style: TextStyle(
                          fontSize: 18,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
