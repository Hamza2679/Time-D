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
          backgroundColor: Colors.deepOrange,
          title: Text(store.name, style: TextStyle(color: Colors.white)),
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
              Text('Items:'),
              Expanded(
                child: BlocBuilder<ElectronicsDetailBloc, ElectronicsDetailState>(
                  builder: (context, state) {
                    if (state is ElectronicsDetailInitial) {
                      return ListView.builder(
                        itemCount: store.items.length,
                        itemBuilder: (context, index) {
                          var item = store.items[index];
                          return ListTile(
                            leading: Image.asset(
                              item.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(item.name),
                            subtitle: Text('Price: \$${item.price.toStringAsFixed(0)}'),
                            trailing: Container(
                              width: 120,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      context.read<ElectronicsDetailBloc>().add(UpdateQuantityEvent(item.name, -1));
                                    },
                                  ),
                                  Text('${state.quantities[item.name] ?? 0}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      context.read<ElectronicsDetailBloc>().add(UpdateQuantityEvent(item.name, 1));
                                    },
                                  ),
                                ],
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
                      color: Colors.deepOrange,
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total: \$${state.totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.deepOrange,
                              backgroundColor: Colors.white,
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
                            child: Text("Buy Now"),
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
}
