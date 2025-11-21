import 'package:flutter/material.dart';

class CategoryStackPage extends StatefulWidget {
  final Function(String) onSelect;

  const CategoryStackPage({super.key, required this.onSelect});

  @override
  State<CategoryStackPage> createState() => _CategoryStackPageState();
}

class _CategoryStackPageState extends State<CategoryStackPage> {
  String activeCategory = "Makanan";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 20,
          child: GestureDetector(
            onTap: () {
              setState(() => activeCategory = "Makanan");
              widget.onSelect("Makanan");
            },
            child: Chip(
              label: const Text("Makanan"),
              backgroundColor: activeCategory == "Makanan"
                  ? const Color.fromARGB(255, 235, 162, 80)
                  : Colors.grey,
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 140,
          child: GestureDetector(
            onTap: () {
              setState(() => activeCategory = "Minuman");
              widget.onSelect("Minuman");
            },
            child: Chip(
              label: const Text("Minuman"),
              backgroundColor: activeCategory == "Minuman"
                  ? const Color.fromARGB(255, 235, 162, 80)
                  : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
