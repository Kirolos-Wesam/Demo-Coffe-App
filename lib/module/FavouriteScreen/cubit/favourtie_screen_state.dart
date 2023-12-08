part of 'favourtie_screen_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteScreenInitial extends FavoriteState {}

final class GetFavoriteLoadingState extends FavoriteState {}

final class GetFavoriteSuccessState extends FavoriteState {}

final class GetFavoriteErrorState extends FavoriteState {}

final class RemoveFavoriteLoadingState extends FavoriteState {}

final class RemoveFavoriteSuccessState extends FavoriteState {}

final class RemoveFavoriteErrorState extends FavoriteState {}
