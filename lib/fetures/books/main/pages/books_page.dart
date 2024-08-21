import 'package:flutter/material.dart';
import '../../../../repositories/book_data.dart';

class BooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Stores'),
      ),
      body: ListView.builder(
        itemCount: bookStores.length,
        itemBuilder: (context, index) {
          final store = bookStores[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(
                store.imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(store.name),
              subtitle: Text(store.address),
            ),
          );
        },
      ),
    );
  }
}
