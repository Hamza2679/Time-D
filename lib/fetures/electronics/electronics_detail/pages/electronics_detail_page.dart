import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/electronics_model.dart';
import '../../../common/finish_page.dart';
import '../bloc/electronics_detail_bloc.dart';
import '../bloc/electronics_detail_event.dart';
import '../bloc/electronics_detail_state.dart';

class ElectronicsDetailPage extends StatelessWidget {
  final ElectronicsStore store;

  ElectronicsDetailPage({required this.store});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ElectronicsDetailBloc(store),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(store.name, style: TextStyle(color: primaryTextColor)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  store.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                store.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(store.location),
              SizedBox(height: 10),
              Text('Items',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
              Expanded(
                child: BlocBuilder<ElectronicsDetailBloc, ElectronicsDetailState>(
                  builder: (context, state) {
                    if (state is ElectronicsDetailInitial) {
                      return ListView.builder(
                        itemCount: store.items.length,
                        itemBuilder: (context, index) {
                          var item = store.items[index];
                          return Card(
                            elevation: 4.0,  // Add elevation here
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    item.image,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(item.name),
                                subtitle: Text('Price: \$${item.price.toStringAsFixed(0)}'),
                                trailing: Container(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildQuantityButton(
                                        icon: Icons.remove,
                                        color: redColor,
                                        onPressed: () {
                                          context.read<ElectronicsDetailBloc>().add(UpdateQuantityEvent(item.name, -1));
                                        },
                                      ),
                                      Text(
                                        '${state.quantities[item.name] ?? 0}',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      _buildQuantityButton(
                                        icon: Icons.add,
                                        color: greenColor,
                                        onPressed: () {
                                          context.read<ElectronicsDetailBloc>().add(UpdateQuantityEvent(item.name, 1));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
              BlocBuilder<ElectronicsDetailBloc, ElectronicsDetailState>(
                builder: (context, state) {
                  if (state is ElectronicsDetailInitial) {
                    return Container(
                      color: primaryColor,
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total: \$${state.totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryTextColor,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: primaryColor,
                              backgroundColor: primaryTextColor,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Order Summary"),
                                    content: Text(
                                      "Total Price: \$${state.totalPrice.toStringAsFixed(2)}",
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FinishPage(),
                                            ),
                                                (Route<dynamic> route) => false,
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("Order Now"),
                          ),
                        ],
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 18,
        icon: Icon(icon, color: primaryTextColor),
        onPressed: onPressed,
      ),
    );
  }
}
