import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class ItemTapped extends MainEvent {
  final int index;

  const ItemTapped(this.index);

  @override
  List<Object> get props => [index];
}

class CategoryTapped extends MainEvent {
  final String route;

  const CategoryTapped(this.route);

  @override
  List<Object> get props => [route];
}

class SearchQueryChanged extends MainEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
