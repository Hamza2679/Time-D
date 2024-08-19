import 'package:equatable/equatable.dart';

abstract class ElectronicsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadElectronics extends ElectronicsEvent {}
