part of 'order_screen_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderScreenInitial extends OrderState {}

final class GetOrderLoadingState extends OrderState {}

final class GetOrderSuccussState extends OrderState {}

final class GetOrderErrorState extends OrderState {}

final class CountPlusState extends OrderState {}

final class CountMinusState extends OrderState {}

final class CheckOutOrderLoadingState extends OrderState {}

final class CheckOutOrderSuccussState extends OrderState {}

final class CheckOutOrderErrorState extends OrderState {}

final class RemoveOrderSuccessState extends OrderState {}

final class CheckOutDoneState extends OrderState {}
