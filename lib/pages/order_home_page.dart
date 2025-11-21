import 'package:flutter/material.dart';
import '../models/menu_model.dart';
import '../widgets/menu_card.dart';
import 'category_stack_page.dart';

class OrderHomePage extends StatefulWidget {
  const OrderHomePage({super.key});

  @override
  State<OrderHomePage> createState() => _OrderHomePageState();
}

class _OrderHomePageState extends State<OrderHomePage> {
  String selectedCategory = "Makanan";

  List<MenuModel> menus = [
    MenuModel(
      id: "1",
      name: "Ayam Goreng",
      price: 20000,
      category: "Makanan",
      discount: 0.1,
    ),
    MenuModel(
      id: "2",
      name: "Sambel terasi",
      price: 2500,
      category: "Makanan",
      discount: 0.05,
    ),

    MenuModel(
      id: "3",
      name: "Jus alpukat",
      price: 10000,
      category: "Minuman",
      discount: 0.0,
    ),
    MenuModel(
      id: "4",
      name: "Jus mangga",
      price: 10000,
      category: "Minuman",
      discount: 0.1,
    ),

    MenuModel(
      id: "5",
      name: "mie baso urat",
      price: 15000,
      category: "Makanan",
      discount: 0.05,
    ),
    MenuModel(
      id: "6",
      name: "air meneral",
      price: 2500,
      category: "Minuman",
      discount: 0.05,
    ),
    MenuModel(
      id: "2",
      name: "Chiken katsu + nasi",
      price: 25000,
      category: "Makanan",
      discount: 0.05,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredMenus = menus
        .where((m) => m.category == selectedCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("RUMAH MAKAN SABIL"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/summary"),
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: CategoryStackPage(
              onSelect: (cat) => setState(() => selectedCategory = cat),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMenus.length,
              itemBuilder: (_, i) => MenuCard(menu: filteredMenus[i]),
            ),
          ),
        ],
      ),
    );
  }
}
