import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {
  final int selectedIndex;
  final String searchQuery;
  final String currentCategory;

  const MainInitial({
    this.selectedIndex = 0,
    this.searchQuery = '',
    this.currentCategory = 'Food',
  });

  MainInitial copyWith({
    int? selectedIndex,
    String? searchQuery,
    String? currentCategory,
  }) {
    return MainInitial(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      currentCategory: currentCategory ?? this.currentCategory,
    );
  }

  @override
  List<Object> get props => [selectedIndex, searchQuery, currentCategory];
}
