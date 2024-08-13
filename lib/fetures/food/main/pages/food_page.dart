import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/food_bloc.dart';
import '../bloc/food_event.dart';
import '../bloc/food_state.dart';
import 'package:delivery_app/fetures/food/widgets/food_widgets.dart';

class FoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodBloc(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(5.0),
          child: AppBar(),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white54,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Restaurants',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                    BlocBuilder<FoodBloc, FoodState>(
                      builder: (context, state) {
                        if (state is FoodInitial) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is FoodLoaded) {
                          return buildRestaurants(context, state.filteredRestaurants);
                        } else {
                          return Center(child: Text('Something went wrong!'));
                        }
                      },


                ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
