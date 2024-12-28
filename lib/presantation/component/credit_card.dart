import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lemon_task/presantation/component/app_glassmorphism_style.dart';
import 'package:lemon_task/presantation/pages/home/create_card_screen/create_card_screen.dart';
import 'package:lemon_task/presantation/resources/app_navigator.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../constants/app_colors/app_colors.dart';
import '../../constants/theme/app_textstyles/app_text_styles.dart';

class CreditCard extends StatelessWidget {
  final CardIsEmpty status;
  final String? cardNumber;
  final String? cardName;
  final String? cardExpiry;
  final String? cardCvv;
  final CardType? cardType;

  const CreditCard(
      {super.key,
      required this.status,
      this.cardNumber,
      this.cardName,
      this.cardExpiry,
      this.cardCvv,
      this.cardType});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
        child: cardStatusChecker(status),
      ),
    );
  }

  cardStatusChecker(CardIsEmpty cardIsEmpty) {
    switch (cardIsEmpty) {
      case CardIsEmpty.empty:
        return _createCardEmpty();
      case CardIsEmpty.isNotEmpty:
        return _createCardIsNotEmpty(
          cardNumber: cardNumber,
          cardName: cardName,
          cardExpiry: cardExpiry,
          cardCvv: cardCvv,
          cardType: cardType,
        );
    }
  }

  _createCardEmpty() {
    return SizedBox(
      width: 300.sp,
      height: 200.sp,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const CreditCardUi(
            cardHolderFullName: '',
            cardNumber: '',
            validThru: '',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: AppGlassMorphism(
              borderRadius: BorderRadius.circular(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'Hozircha karta mavjud emas',
                        style: AppTextStyles.euclidMedium
                            .copyWith(color: AppColors.white, fontSize: 14.sp),
                      ),
                      8.verticalSpace,
                      Text(
                        "Ilovadan foydalanish uchun karta qo'shing",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.euclidMedium
                            .copyWith(color: AppColors.white, fontSize: 14.sp),
                      ),
                      12.verticalSpace,
                      Material(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(6.sp),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            AppNavigator.push(CreateCardScreen.routeName);
                          },
                          child: SizedBox(
                            height: 26.sp,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 18.sp,
                                  ),
                                  6.sp.horizontalSpace,
                                  Text(
                                    // textAlign: TextAlign.end,
                                    textAlign: TextAlign.center,
                                    "Qo'shish",
                                    style: AppTextStyles.euclidMedium
                                        .copyWith(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _createCardIsNotEmpty({
    String? cardNumber,
    String? cardName,
    String? cardExpiry,
    String? cardCvv,
    CardType? cardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CreditCardUi(
          cardHolderFullName: cardName ?? 'Full name',
          cardNumber: cardNumber ?? "xxxx xxxx xxxx xxxx",
          validThru: cardExpiry ?? 'xx/xx',
          cvvNumber: "",
          cardType: CardType.other,
          enableFlipping: true,
          placeNfcIconAtTheEnd: true,
          doesSupportNfc: false,
        ),
      ],
    );
  }
}

enum CardIsEmpty { empty, isNotEmpty }

// enum CardType {
//   uzcard,
//   humo,
// }
