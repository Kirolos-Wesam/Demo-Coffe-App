import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_screen_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderScreenInitial());
}
