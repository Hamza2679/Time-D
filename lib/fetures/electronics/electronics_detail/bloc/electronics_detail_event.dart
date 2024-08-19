// electronics_detail_event.dart

import 'package:equatable/equatable.dart';

abstract class ElectronicsDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadElectronicsDetail extends ElectronicsDetailEvent {
  final String electronicsId;

  LoadElectronicsDetail(this.electronicsId);

  @override
  List<Object> get props => [electronicsId];
}

class RefreshElectronicsDetail extends ElectronicsDetailEvent {
  final String electronicsId;

  RefreshElectronicsDetail(this.electronicsId);

  @override
  List<Object> get props => [electronicsId];
}
