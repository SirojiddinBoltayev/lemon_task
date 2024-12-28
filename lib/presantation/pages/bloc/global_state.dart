part of 'global_bloc.dart';

class GlobalState {
  CardInfo? cardModel;

  GlobalState({this.cardModel});

  factory GlobalState.init() {
    return GlobalState(
      );
  }

  GlobalState copyWith({ CardInfo? cardModel}) {
    return GlobalState(
        cardModel: cardModel ?? this.cardModel);
  }
}
