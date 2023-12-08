part of 'products_screen_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsScreenInitial extends ProductsState {}

final class GetUserLoadingState extends ProductsState {}

final class GetUserSuccessState extends ProductsState {}

final class SwitchButtonState extends ProductsState {}

final class GetUserErrorState extends ProductsState {}

final class OffersProductsLoadingState extends ProductsState {}

final class OffersProductsSuccessState extends ProductsState {}

final class OffersProductsErrorState extends ProductsState {}

final class GetProductsLoadingState extends ProductsState {}

final class GetProductsSuccessState extends ProductsState {}

final class GetProductsErrorState extends ProductsState {}



