part of 'order_history_cubit.dart';

@immutable
sealed class OrderHistoryState {}

final class OrderHistoryInitial extends OrderHistoryState {}

final class GetOrderHistoryLoadingState extends OrderHistoryState {}

final class GetOrderHistorySuccessState extends OrderHistoryState {}

final class GetOrderHistoryErrorState extends OrderHistoryState {}

final class GetProductsOrderHistoryLoadingState extends OrderHistoryState {}

final class GetProductsOrderHistorySuccessState extends OrderHistoryState {}

final class GetProductsOrderHistoryErrorState extends OrderHistoryState {}