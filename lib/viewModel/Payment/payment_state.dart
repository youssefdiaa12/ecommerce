part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}
class intialPayment extends PaymentState {}
class LoadingAuthenticationPayment extends PaymentState {}
class ErrorAuthPayment extends PaymentState {}
class SuccssesAuthPayment extends PaymentState {}
class LoadingOrderId extends PaymentState {}
class ErrorOrderId extends PaymentState {}
class SuccssesOrderId extends PaymentState {}
class LoadingTokenPaymentCard extends PaymentState {}
class ErrorTokenPaymentCard extends PaymentState {}
class SuccssesTokenPaymentCard extends PaymentState {}
class LoadingTokenPaymentKiosk extends PaymentState {}
class ErrorTokenKiosk extends PaymentState {}
class SuccssesKiosk extends PaymentState {}
class LoadingReferenceCode extends PaymentState {}
class ErrorReferenceCode extends PaymentState {}
class SuccssesReferenceCode extends PaymentState {}