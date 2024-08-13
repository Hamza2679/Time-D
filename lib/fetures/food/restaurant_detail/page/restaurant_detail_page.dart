import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/restaurant_detail_bloc.dart';
import '../bloc/restaurant_detail_event.dart';
import '../bloc/restaurant_detail_state.dart';
import '../../../common/finish_page.dart';

class RestaurantDetailPage extends StatelessWidget {
  final String name;
  final String image;
  final String address;
  final List<Map<String, String>> menu;

  RestaurantDetailPage({
    required this.name,
    required this.image,
    required this.address,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantBloc(menu)..add(LoadMenu()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(name, style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(image, width: double.infinity, height: 200, fit: BoxFit.cover),
              SizedBox(height: 16),
              Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(address, style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 16),
              Text('Menu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<RestaurantBloc, RestaurantState>(
                  builder: (context, state) {
                    if (state is RestaurantLoaded) {
                      return ListView.builder(
                        itemCount: menu.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Image.asset(menu[index]["image"]!, width: 50, height: 50, fit: BoxFit.cover),
                            title: Text(menu[index]["name"]!),
                            subtitle: Text(menu[index]["price"]!),
                            trailing: Container(
                              width: 120,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      context.read<RestaurantBloc>().add(DecrementQuantity(index));
                                    },
                                  ),
                                  Text(state.quantities[index].toString()),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      context.read<RestaurantBloc>().add(IncrementQuantity(index));
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
              SizedBox(height: 16),
              BlocBuilder<RestaurantBloc, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantLoaded) {
                    return Container(
                      color: Colors.deepOrange,
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total: \$${state.totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.deepOrange,
                              backgroundColor: Colors.white, // Text color
                            ),
                            onPressed: () {
                              context.read<RestaurantBloc>().add(BuyNow());
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Order Summary"),
                                    content: Text("Total Price: \$${state.totalPrice.toStringAsFixed(2)}"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(builder: (context) => FinishPage()),
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
