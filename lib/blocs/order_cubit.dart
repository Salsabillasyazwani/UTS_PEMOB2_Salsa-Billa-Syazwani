import 'package:bloc/bloc.dart';
import '../models/menu_model.dart';

class OrderState {
  final List<Map<String, dynamic>> orders;
  final String action; // add, remove, update, clear

  OrderState({required this.orders, this.action = ""});

  OrderState copyWith({List<Map<String, dynamic>>? orders, String? action}) {
    return OrderState(
      orders: orders ?? this.orders,
      action: action ?? this.action,
    );
  }
}

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState(orders: []));

  // ADD
  void addToOrder(MenuModel menu) {
    final index = state.orders.indexWhere((item) => item["menu"].id == menu.id);

    if (index != -1) {
      updateQuantity(menu, state.orders[index]["qty"] + 1);
      emit(state.copyWith(action: "update"));
      return;
    }

    final updated = List<Map<String, dynamic>>.from(state.orders)
      ..add({"menu": menu, "qty": 1});

    emit(state.copyWith(orders: updated, action: "add"));
  }

  // REMOVE
  void removeFromOrder(MenuModel menu) {
    final updated = state.orders
        .where((item) => item["menu"].id != menu.id)
        .toList();

    emit(state.copyWith(orders: updated, action: "remove"));
  }

  // UPDATE QTY
  void updateQuantity(MenuModel menu, int qty) {
    if (qty <= 0) {
      removeFromOrder(menu);
      return;
    }

    final updated = state.orders.map((item) {
      if (item["menu"].id == menu.id) {
        return {"menu": menu, "qty": qty};
      }
      return item;
    }).toList();

    emit(state.copyWith(orders: updated, action: "update"));
  }

  int getTotalPrice() {
    int total = 0;

    for (var item in state.orders) {
      final menu = item["menu"] as MenuModel;
      final qty = item["qty"] as int;

      total += (menu.getDiscountedPrice() * qty).toInt();
    }

    return total;
  }

  // CLEAR
  void clearOrder() {
    emit(state.copyWith(orders: [], action: "clear"));
  }
}
