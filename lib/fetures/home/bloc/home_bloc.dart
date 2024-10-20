import 'package:bloc/bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<ItemTapped>((event, emit) {
      emit((state as MainInitial).copyWith(
        selectedIndex: event.index,
        searchQuery: event.index != 0 ? '' : (state as MainInitial).searchQuery,
        filteredItems: [],
      ));
    });

    on<CategoryTapped>((event, emit) {
      String category = 'All'; // Default category is 'All'

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
        case '/food':
          category = 'Food';
          break;
        case '/discover':  // Add the route for "All" category
          category = 'All';
          break;
        default:
          category = 'All'; // Fallback to 'All' in case of unknown route
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

      default:
        return [];
    }
  }
}
