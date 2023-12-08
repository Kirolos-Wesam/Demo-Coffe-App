part of 'product_info_cubit.dart';

@immutable
sealed class ProductInfoState {}

final class ProductInfoInitial extends ProductInfoState {}

final class ChangeSizeButtonsState extends ProductInfoState {}

final class AddFavoriteLoadingState extends ProductInfoState {}

final class CheckFavoriteState extends ProductInfoState {}

final class AddFavoriteSuccessState extends ProductInfoState {}

final class DeleteFavoriteSuccessState extends ProductInfoState {}

final class AddFavoriteErrorState extends ProductInfoState {}

final class AddOrderLoadingState extends ProductInfoState {}

final class AddOrderSuccessState extends ProductInfoState {}

final class AddOrderErrorState extends ProductInfoState {}
