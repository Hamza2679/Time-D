import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/pharmacy_bloc.dart';
import '../../../../models/pharmacy_model.dart';
import '../../../../repositories/pharmacy_data.dart'; // Import the data including the drugs list
import '../../detail/page/pharmacy_detail_page.dart';
import '../bloc/pharmacy_state.dart';


class PharmacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmacies'),
      ),
      body: BlocBuilder<PharmacyBloc, PharmacyState>(
        builder: (context, state) {
          if (state is PharmacyLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PharmacyLoaded) {
            final pharmacies = state.pharmacies;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: pharmacies.length,
              itemBuilder: (context, index) {
                final pharmacy = pharmacies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PharmacyDetailPage(
                          pharmacy: pharmacy,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 400,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            pharmacy.image,
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Text(pharmacy.name),
                          Text(pharmacy.address),
                        ],
                      ),
                    ),
                )
                );
              },
            );
          } else if (state is PharmacyError) {
            return Center(child: Text('Failed to load pharmacies'));
          } else {
            return Center(child: Text('No pharmacies available'));
          }
        },
      ),
    );
  }
}
