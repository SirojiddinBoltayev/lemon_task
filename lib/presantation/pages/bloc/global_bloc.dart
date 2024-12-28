import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ml_card_scanner/ml_card_scanner.dart';
// import 'package:flutter_credit_card_scanner/credit_card.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState.init()) {
    on<CreditCardScannerEvent>(_onCreditCardScannerEvent);
  }

  _onCreditCardScannerEvent(
      CreditCardScannerEvent event, emit)  {
    emit(state.copyWith(cardModel: event.cardModel));
  }
}


