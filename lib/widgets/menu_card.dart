import 'package:flutter/material.dart';
import '../models/menu_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';

class MenuCard extends StatelessWidget {
  final MenuModel menu;

  const MenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    final diskon = menu.getDiscountedPrice();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              menu.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Text(
              "Harga asli: Rp ${menu.price}",
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),

            Text(
              "Harga diskon: Rp $diskon",
              style: const TextStyle(color: Colors.green, fontSize: 16),
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.read<OrderCubit>().addToOrder(menu);
              },
              child: const Text("Tambah Pesanan"),
            ),
          ],
        ),
      ),
    );
  }
}
