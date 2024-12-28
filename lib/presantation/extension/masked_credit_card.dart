
import 'masked_text.dart';

extension NumberExtension on String {
  String get maskedCreditCard {
    String country  = "9999 9999 9999 9999";

    MagicMask mask = MagicMask.buildMask('\\$country');
    return mask.getMaskedString(this);
  }}