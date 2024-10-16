import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrganizationPage extends StatelessWidget {
  final List<Map<String, dynamic>> organizations;

  OrganizationPage({required this.organizations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Organizations' , style: TextStyle(color: primaryTextColor),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two cards per row
            crossAxisSpacing: 10, // Space between columns
            mainAxisSpacing: 10, // Space between rows
            childAspectRatio: 3 / 4, // Adjust this to control card height relative to width
          ),
          itemCount: organizations.length,
          itemBuilder: (context, index) {
            final organization = organizations[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5, // Adds shadow for a lifted effect
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child: Image.network(
                      organization['image'],
                      width: double.infinity,
                      height: 150, // Increased image height
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 150, // Adjusted to match image height
                          color: Colors.grey[300],
                          child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0), // Reduced padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          organization['name'],
                          style: TextStyle(
                            fontSize: 14, // Reduced font size
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis, // Handle long names
                        ),
                        SizedBox(height: 4),
                        Text(
                          organization['location'],
                          style: TextStyle(
                            fontSize: 12, // Reduced font size
                            color: Colors.grey[700],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis, // Handle long addresses
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              organization['rating'].toStringAsFixed(2), // Two decimal places for rating
                              style: TextStyle(
                                fontSize: 12, // Reduced font size
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
