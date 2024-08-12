import 'package:bloc/bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<ItemTapped>((event, emit) {
      emit((state as MainInitial).copyWith(
        selectedIndex: event.index,
        searchQuery: event.index != 0 ? '' : (state as MainInitial).searchQuery,
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
      emit((state as MainInitial).copyWith(currentCategory: category));
    });

    on<SearchQueryChanged>((event, emit) {
      emit((state as MainInitial).copyWith(searchQuery: event.query));
    });
  }
}
