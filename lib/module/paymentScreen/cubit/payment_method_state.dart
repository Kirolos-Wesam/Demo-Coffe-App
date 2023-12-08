part of 'payment_method_cubit.dart';

@immutable
sealed class PaymentMethodState {}

final class PaymentMethodInitial extends PaymentMethodState {}

final class ShowAddCardState extends PaymentMethodState {}

final class AddPaymentCardLoadingState extends PaymentMethodState {}

final class AddPaymentCardSuccessState extends PaymentMethodState {}

final class AddPaymentCardErrorState extends PaymentMethodState {}

final class GetPaymentCardLoadingState extends PaymentMethodState {}

final class GetPaymentCardSuccessState extends PaymentMethodState {}

final class GetPaymentCardErrorState extends PaymentMethodState {}
