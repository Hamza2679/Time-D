import 'package:flutter/material.dart';
import '../../books/books_page.dart';
import '../../electronics/main/pages/electronics_page.dart';
import '../../food/main/pages/food_page.dart';
import '../../gift/gift_page.dart';
import '../../pharmacy/main/page/pharmacy_page.dart';
import '../../sparepart/sparepart_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';

Widget buildCategoryPage(String currentCategory) {
  switch (currentCategory) {
    case 'Electronics':
      return ElectronicsPage();
    case 'Pharmacy':
      return PharmacyPage();
    case 'SparePart':
      return SparePartPage();
    case 'Gifts':
      return GiftsPage();
    case 'Books':
      return BooksPage();
    default:
      return FoodPage();
  }
}
Widget buildCategories(BuildContext context, List<Map<String, dynamic>> categories, String currentCategory) {
  return Container(
    height: 126,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        bool isSelected = currentCategory == category['text'];
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<MainBloc>(context).add(CategoryTapped(category['route']));
            },
            child: Container(
              width: 130,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.deepOrange : Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      category['image'],
                      width: 130,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    category['text'],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
