import 'package:flutter/material.dart';
import 'package:myapp/model/dish.dart';
import 'package:myapp/ui/_core/bag_provider.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BagProvider bagProvider = Provider.of<BagProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sacola'),
        actions: [
          TextButton(
            onPressed: () {
              bagProvider.clearBag();
            },
            child: Text(
              'Limpar',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pedido',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                children:
                    bagProvider.dishesOnBag.isNotEmpty
                        ? List.generate(
                          bagProvider.getMapByAmount().keys.length,
                          (index) {
                            Dish dish =
                                bagProvider
                                    .getMapByAmount()
                                    .keys
                                    .toList()[index];
                            return ListTile(
                              leading: Image.asset(
                                'assets/dishes/default.png',
                                width: 48,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                              title: Text(dish.name),
                              subtitle: Text(
                                'R\$ ${dish.price.toStringAsFixed(2)}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      bagProvider.removeDish(dish);
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                  Text(
                                    bagProvider
                                        .getMapByAmount()[dish]
                                        .toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      bagProvider.addAllDishes([dish]);
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                        : [
                          Center(
                            heightFactor: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Sacola vazia",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                Icon(
                                  Icons.remove_shopping_cart,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
