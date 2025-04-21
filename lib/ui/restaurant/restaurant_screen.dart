import 'package:flutter/material.dart';
import 'package:myapp/model/dish.dart';
import 'package:myapp/model/restaurant.dart';
import 'package:myapp/ui/_core/bag_provider.dart';
import 'package:myapp/ui/_core/widgets/appBar.dart';
import 'package:provider/provider.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: restaurant.name),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/${restaurant.imagePath}', width: 160),
            ),
            SizedBox(height: 24),
            Text(
              'Pratos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children: List.generate(restaurant.dishes.length, (index) {
                Dish dish = restaurant.dishes[index];
                return ListTile(
                  leading: Image.asset('assets/dishes/default.png', width: 48),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  title: Text(dish.name),
                  subtitle: Text('R\$ ${dish.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<BagProvider>().addAllDishes([dish]);
                    },
                    icon: Icon(Icons.add_circle_outline),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
