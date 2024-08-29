import 'package:bloc/bloc.dart';
import 'package:delivery_app/repositories/book_data.dart';
import '../../../repositories/electronics_data.dart';
import '../../../repositories/pharmacy_data.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../common/data.dart'; // Ensure all data lists are imported

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<ItemTapped>((event, emit) {
      emit((state as MainInitial).copyWith(
        selectedIndex: event.index,
        searchQuery: event.index != 0 ? '' : (state as MainInitial).searchQuery,
        filteredItems: [], // Clear filtered items when navigating away
      ));
    });

    on<CategoryTapped>((event, emit) {
      String category = 'Food';
      switch (event.route) {
        case '/electronics':
          category = 'Electronics';
          break;
        case '/pharmacy':
          category = 'Pharmacy';
          break;
        case '/sparepart':
          category = 'SparePart';
          break;
        case '/gift':
          category = 'Gifts';
          break;
        case '/books_and_stationery':
          category = 'Books';
          break;
      }
      emit((state as MainInitial).copyWith(currentCategory: category, filteredItems: []));
    });

    on<SearchQueryChanged>((event, emit) {
      final query = event.query;
      final category = (state as MainInitial).currentCategory;
      List<dynamic> filteredItems = _filterItems(query, category);
      emit((state as MainInitial).copyWith(searchQuery: query, filteredItems: filteredItems));
    });
  }

  List<dynamic> _filterItems(String query, String category) {
    if (query.isEmpty) return [];

    switch (category) {
      case 'Food':
        return restaurants
            .where((item) => (item['name'] ?? '').toString().toLowerCase().contains(query.toLowerCase()))
            .toList();
      case 'Pharmacy':
        return pharmacies
            .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      case 'Books':
        return bookStores
            .where((book) => book.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      case 'Electronics':
        return electronicsStores
            .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      default:
        return [];
    }
  }
}
