import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import '../organization_detail/organization_detail_page.dart';

class OrganizationPage extends StatelessWidget {
  final List<Map<String, dynamic>>? organizations;
  bool _isNavigating = false; // Flag to track navigation state

  OrganizationPage({required this.organizations});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> organizationList = organizations ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Organizations', style: TextStyle(color: primaryTextColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: organizationList.isEmpty
            ? Center(
          child: Text(
            'No Organizations Found',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        )
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4,
          ),
          itemCount: organizationList.length,
          itemBuilder: (context, index) {
            final organization = organizationList[index];

            return GestureDetector(
              onTap: () {
                if (!_isNavigating) { // Check if navigation is already in progress
                  _isNavigating = true; // Set the flag to true
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrganizationDetailPage(
                        organizationName: organization['name'],
                        products: organization['products'] ?? [],
                      ),
                    ),
                  ).then((_) {
                    _isNavigating = false; // Reset the flag when navigation is complete
                  });
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          child: Image.network(
                            organization['image'],
                            width: double.infinity,
                            height: 190,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 190,
                                color: Colors.grey[300],
                                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  organization['rating']?.toStringAsFixed(2) ?? 'N/A',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              organization['name'] ?? 'Unknown Organization',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              organization['location'] ?? 'Unknown Location',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
