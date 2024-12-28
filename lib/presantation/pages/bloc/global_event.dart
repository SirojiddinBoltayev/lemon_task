part of 'global_bloc.dart';

@immutable
sealed class GlobalEvent {}

final class CreditCardScannerEvent extends GlobalEvent {
  final  CardInfo? cardModel;

  CreditCardScannerEvent({required this.cardModel});
}

