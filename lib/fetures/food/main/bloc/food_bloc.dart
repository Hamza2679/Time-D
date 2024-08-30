import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repositories/food_data.dart';
import 'food_event.dart';
import 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitial()) {
    on<SearchQueryChanged>((event, emit) {
      print('SearchQueryChanged event received with query: ${event.query}');
      final filteredRestaurants = _filterRestaurants(event.query);
      emit(FoodLoaded(filteredRestaurants));
    });

    add(SearchQueryChanged(''));
  }

  List<Map<String, dynamic>> _filterRestaurants(String query) {
    if (query.isEmpty) {
      return restaurants;
    }
    return restaurants.where((restaurant) {
      bool matchesRestaurantName = restaurant["name"]!.toLowerCase().contains(query.toLowerCase());
      bool matchesMenuItems = restaurant["menu"]!.any((item) {
        return item["name"]!.toLowerCase().contains(query.toLowerCase()) ||
            item["price"]!.contains(query);
      });
      return matchesRestaurantName || matchesMenuItems;
    }).toList();
  }
}
