import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/order_model.dart';
import '../../../order/order_view.dart';
import '../bloc/restaurant_detail_bloc.dart';
import '../bloc/restaurant_detail_event.dart';
import '../bloc/restaurant_detail_state.dart';
import '../../../common/finish_page.dart';
import '../../widgets/food_widgets.dart';

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
      create: (context) =>
      RestaurantBloc(menu)
        ..add(LoadMenu()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(name, style: TextStyle(color: primaryTextColor)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(image, width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover),
              ),
              SizedBox(height: 6),
              Text(name,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              SizedBox(height: 2),
              Text(address, style: TextStyle(fontSize: 16, color: greyColor)),
              SizedBox(height: 2),
              Text('Menu',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Expanded(
                child: BlocBuilder<RestaurantBloc, RestaurantState>(
                  builder: (context, state) {
                    if (state is RestaurantLoaded) {
                      return ListView.builder(
                        itemCount: menu.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 3.0,
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                    menu[index]["image"]!, width: 50,
                                    height: 50,
                                    fit: BoxFit.cover),
                              ),
                              title: Text(menu[index]["name"]!,
                                  style: TextStyle(fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              subtitle: Text(menu[index]["price"]!,
                                  style: TextStyle(color: Colors.grey[700])),
                              trailing: Container(
                                width: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    buildQuantityButton(
                                      icon: Icons.remove,
                                      color: redColor,
                                      size: 20, // Smaller icon size
                                      onPressed: () {
                                        context.read<RestaurantBloc>().add(
                                            DecrementQuantity(index));
                                      },
                                    ),
                                    SizedBox(width: 2,),
                                    Text(
                                      state.quantities[index].toString(),
                                      style: TextStyle(fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 2,),
                                    buildQuantityButton(
                                      icon: Icons.add,
                                      color: greenColor,
                                      size: 20,
                                      onPressed: () {
                                        context.read<RestaurantBloc>().add(
                                            IncrementQuantity(index));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              SizedBox(height: 16),
              BlocBuilder<RestaurantBloc, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantLoaded) {
                    return Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total: \$${state.totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: primaryTextColor),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: primaryColor,
                              backgroundColor: primaryColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () async {
                              final selectedItems = <OrderItem>[];
                              for (int i = 0; i < state.quantities.length; i++) {
                                if (state.quantities[i]! > 0) {
                                  selectedItems.add(
                                    OrderItem(
                                      restaurantName: name,
                                      itemName: menu[i]["name"]!,
                                      quantity: state.quantities[i] ?? 0,
                                      price: double.parse(menu[i]["price"]!.replaceAll('\$', '')),
                                    ),
                                  );
                                }
                              }
                              await saveOrders(selectedItems);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Order Summary"),
                                    content: Container(
                                      width: double.maxFinite,
                                      height: 300,
                                      child: OrderView(),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("OK", style: TextStyle(color: primaryColor)),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FinishPage()));
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },


                            child: Text(
                                "Order Now", style: TextStyle(fontSize: 18)),
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
