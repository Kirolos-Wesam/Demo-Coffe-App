part of 'home_screen_cubit.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

final class ChangeNavBottomState extends HomeScreenState {}

final class GetProfileLoadingState extends HomeScreenState {}

final class GetProfileSuccessState extends HomeScreenState {}

final class GetProfileErrorState extends HomeScreenState {}


