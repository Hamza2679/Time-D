import 'package:flutter/material.dart';

// A widget to build the list of electronics
Widget buildElectronics(BuildContext context, List<String> electronics) {
  return ListView.builder(
    itemCount: electronics.length,
    itemBuilder: (context, index) {
      final item = electronics[index];
      return Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          contentPadding: EdgeInsets.all(16.0),
          title: Text(item, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),

        ),
      );
    },
  );
}
