import 'package:flutter/material.dart';

Widget buildHeader(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget buildSearchBar({double height = 56.0, required ValueChanged<String> onChanged}) {
  return Container(

    height: height,
    child: TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search for items',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}

