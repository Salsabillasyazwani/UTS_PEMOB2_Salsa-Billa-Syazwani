import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';
import '../models/menu_model.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({super.key});

  void showSnack(BuildContext context, String msg, Color color, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: const Duration(milliseconds: 800),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(msg),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ringkasan Pesanan"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<OrderCubit>().clearOrder();
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),

      body: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) {
          switch (state.action) {
            case "add":
              showSnack(context, "Item ditambahkan!", Colors.green, Icons.add);
              break;
            case "remove":
              showSnack(context, "Item dihapus!", Colors.red, Icons.delete);
              break;
            case "update":
              showSnack(
                context,
                "Jumlah diperbarui!",
                Colors.orange,
                Icons.edit,
              );
              break;
            case "clear":
              showSnack(
                context,
                "Pesanan dibersihkan!",
                Colors.blue,
                Icons.refresh,
              );
              break;
          }
        },

        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            final cubit = context.read<OrderCubit>();

            int total = state.orders.isEmpty ? 0 : cubit.getTotalPrice();
            double finalTotal = total.toDouble();

            if (total > 100000) {
              finalTotal = total * 0.9;
            }

            return Column(
              children: [
                Expanded(
                  child: state.orders.isEmpty
                      ? const Center(
                          child: Text(
                            "Belum ada pesanan",
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : ListView(
                          children: state.orders.map((item) {
                            final MenuModel menu = item["menu"];
                            final int qty = item["qty"];

                            return Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Text(menu.name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Harga: Rp ${menu.getDiscountedPrice()}",
                                    ),
                                    Text("Qty: $qty"),
                                  ],
                                ),

                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // button kurang qty
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<OrderCubit>()
                                            .updateQuantity(menu, qty - 1);
                                      },
                                    ),

                                    // button tambah qty
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<OrderCubit>()
                                            .updateQuantity(menu, qty + 1);
                                      },
                                    ),

                                    // button hapus
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.black54,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<OrderCubit>()
                                            .removeFromOrder(menu);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ),

                Text("Total sebelum diskon: Rp $total"),

                if (total > 100000)
                  Text(
                    "Diskon 10%: Rp ${(total * 0.1).toInt()}",
                    style: const TextStyle(color: Colors.green),
                  ),

                const SizedBox(height: 10),

                Text(
                  "Total Akhir: Rp ${finalTotal.toInt()}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
