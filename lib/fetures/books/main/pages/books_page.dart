import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../../../repositories/book_data.dart';

class BooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [newColor, primaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            image: DecorationImage(
              image: AssetImage('assets/appicon.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2),
                BlendMode.dstATop,
              ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'BookShops and Stationary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
              ),
            ),
          ),
        ),
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
