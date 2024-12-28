
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lemon_task/presantation/component/circle_button_container.dart';
import 'package:lemon_task/presantation/component/credit_card.dart';
import 'package:lemon_task/presantation/component/custom_textfield/customTextfield.dart';
import 'package:lemon_task/presantation/extension/masked_credit_card.dart';
import 'package:lemon_task/presantation/pages/home/create_card_screen/scan_credit_card2.dart';
import 'package:lemon_task/presantation/resources/app_navigator.dart';
import 'package:ml_card_scanner/ml_card_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../bloc/global_bloc.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({super.key});

  static const routeName = '/create_card';

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  final cardNumber = TextEditingController();
  final validThru = TextEditingController();
  final cardName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            child: BlocConsumer<GlobalBloc, GlobalState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return Column(
                  children: [
                    20.sp.verticalSpace,
                    CreditCard(
                      status: CardIsEmpty.isNotEmpty,
                      cardNumber: state.cardModel?.number ?? "",
                      cardExpiry: state.cardModel?.expiry ?? "",
                        // cardType: CardType.values.byName(state.cardModel?.type ?? "",)
                    ),
                    20.sp.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AppCustomTextField(
                            controller: cardNumber,
                            creditCard: true,
                            keyboardType: TextInputType.number,
                            title: "Karta raqami",
                            labelText: "0000 0000 0000 0000",
                            onChanged: () {
                              context
                                  .read<GlobalBloc>()
                                  .add(CreditCardScannerEvent(
                                      cardModel: CardInfo(
                                    number: cardNumber.text,
                                    type: state.cardModel?.type ?? "",
                                    expiry: state.cardModel?.expiry ?? "",
                                  )));
                            },
                          ),
                        ),
                        12.sp.horizontalSpace,
                        AppCircleButtonContainer(
                            icon: Icon(Icons.document_scanner_outlined,
                                size: 20.sp),
                            onPressed: () async {
                              if (await Permission.camera.request().isGranted) {
                                AppNavigator.push(CameraPage.routeName, extra: {
                                  "onScan": (CardInfo? value) {
                                    cardNumber.text = value?.number.replaceAll(" ", "").maskedCreditCard ?? "";
                                    validThru.text = value?.expiry ?? "";
                                    if (cardNumber.text.isNotEmpty &&
                                        validThru.text.isNotEmpty) {
                                      AppNavigator.pop();

                                      context.read<GlobalBloc>().add(
                                          CreditCardScannerEvent(
                                              cardModel: value));
                                    }
                                    // setState(() {});
                                  }
                                });
                              }
                            }),
                      ],
                    ),
                    12.sp.verticalSpace,
                    AppCustomTextField(
                      controller: validThru,
                      // keyboardType: TextInputType.number,

                      inputFormatters: [
                        MaskedInputFormatter("00/00"),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[()\d-\s\./]'))
                      ],
                      onChanged: () {
                        // context.read<GlobalBloc>().add(CreditCardScannerEvent(
                        //     cardModel: CreditCardModel(
                        //         number: state.cardModel?.number ?? "",
                        //         holderName: state.cardModel?.holderName ?? "",
                        //         expirationMonth: validThru.text,
                        //         expirationYear: '')));
                      },
                      title: "Kartaning foydalanish muddati",
                      labelText: "OO/YY",
                    ),
                    12.sp.verticalSpace,
                    AppCustomTextField(
                      controller: cardName,
                      // keyboardType: TextInputType.number,
                      onChanged: () {
                        cardName.text = cardName.text.toUpperCase();
                        // context.read<GlobalBloc>().add(CreditCardScannerEvent(
                        //     cardModel: CreditCardModel(
                        //         number: state.cardModel?.number ?? "",
                        //         holderName: cardName.text ?? "",
                        //         expirationMonth:
                        //             state.cardModel?.expirationMonth ?? "",
                        //         expirationYear: '')));
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                            RegExp(r'[()\d-\s\./]'))
                      ],
                      title: "Karta nomi",
                      labelText: "Nomini kiriting",
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
