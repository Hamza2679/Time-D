import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../organization/organization_page.dart';
import 'main_widget.dart';

class CategoryWidget extends StatefulWidget {
  final String currentCategory;

  CategoryWidget({required this.currentCategory});

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading categories'));
        } else if (snapshot.hasData) {
          List<Map<String, dynamic>> categories = snapshot.data!;

          return Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                bool isSelected = widget.currentCategory == category['text'];

                return Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (_isNavigating) return; // Prevent multiple taps

                      setState(() {
                        _isNavigating = true;
                      });

                      try {
                        String categoryId = category['id'];
                        List<Map<String, dynamic>> organizations =
                        await fetchOrganizations(categoryId);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrganizationPage(
                              organizations: organizations,
                            ),
                          ),
                        ).then((_) {
                          // Reset navigation flag once back to the screen
                          setState(() {
                            _isNavigating = false;
                          });
                        });
                      } catch (error) {
                        print('Error fetching organizations: $error');
                        setState(() {
                          _isNavigating = false;
                        });
                      }
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isSelected
                              ? [primaryColor, secondaryColor]
                              : [primaryTextColor, greyColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
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
                            child: category['id'] == "all"
                                ? Image.asset(
                              category['image'],
                              width: 80,
                              height: 48,
                              fit: BoxFit.cover,
                            )
                                : Image.network(
                              category['image'],
                              width: 80,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            category['text'],
                            style: TextStyle(
                              color: isSelected
                                  ? primaryTextColor
                                  : secondaryTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
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
        return Container(); // Handle an empty state
      },
    );
  }
}
