import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/electronics_model.dart';
import 'electronics_detail_event.dart';
import 'electronics_detail_state.dart';

class ElectronicsDetailBloc extends Bloc<ElectronicsDetailEvent, ElectronicsDetailState> {
final ElectronicsStore store;

ElectronicsDetailBloc(this.store) : super(ElectronicsDetailInitial(_initializeQuantities(store), 0.0)) {
on<UpdateQuantityEvent>(_onUpdateQuantity);
}

static Map<String, int> _initializeQuantities(ElectronicsStore store) {
final quantities = <String, int>{};
for (var item in store.items) {
quantities[item.name] = 0; // Initialize all quantities to 0
}
return quantities;
}

void _onUpdateQuantity(UpdateQuantityEvent event, Emitter<ElectronicsDetailState> emit) {
final currentState = state as ElectronicsDetailInitial;
final quantities = Map<String, int>.from(currentState.quantities);
final itemName = event.itemName;

// Update the quantity
if (quantities.containsKey(itemName) && quantities[itemName]! + event.change >= 0) {
quantities[itemName] = quantities[itemName]! + event.change;
}

// Recalculate the total price
double total = 0;
store.items.forEach((item) {
total += item.price * (quantities[item.name] ?? 0);
});

emit(ElectronicsDetailInitial(quantities, total));
}
}

