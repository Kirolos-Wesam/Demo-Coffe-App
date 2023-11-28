import 'package:coffeeapp/module/OrderScreen/cubit/order_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Center(child: Text('Order Screen'));
      },
    );
  }
}
