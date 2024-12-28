import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lemon_task/app.dart';
import 'package:lemon_task/constants/app_assets/app_assets.dart';
import 'package:lemon_task/presantation/component/app_text/app_text.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../../../../constants/app_colors/app_colors.dart';

class NfcScanCreditCard extends StatefulWidget {
  // final Function(NfcTag tag) onSuccess;

  const NfcScanCreditCard({super.key});

  static String routeName = "/nfc_scan_credit_card";

  @override
  State<NfcScanCreditCard> createState() => _NfcScanCreditCardState();
}

class _NfcScanCreditCardState extends State<NfcScanCreditCard> {
  NfcManager nfcManager = NfcManager.instance;
  NfcTag? nfcTag;
  NfcResponseModel? nfcResponseModel;

  @override
  void initState() {
    super.initState();

    // nfcManager.startSession(onDiscovered: (NfcTag tag) async {
    //   // Do something with an NfcTag instance.
    //   if (tag.handle.isNotEmpty) {
    //     // widget.onSuccess.call(tag);
    //     setState(() {
    //       final myJson = Map<String, dynamic>.from(tag.data as Map);
    //
    //       nfcResponseModel =
    //           NfcResponseModel.fromJson(jsonDecode(json.encode(myJson)));
    //     });
    //     nfcTag = tag;
    //     // nfcManager.stopSession();
    //   }
    // }, onError: (error) async {
    //   log(error.toString());
    //   log(error.type.toString());
    //   log(error.message.toString());
    //   log(error.details.toString());
    // });
  }

  @override
  void dispose() {
    _tagRead();
    super.dispose();
    nfcManager.stopSession();
  }

  void _tagRead() {
    nfcManager.startSession(
        onDiscovered: (NfcTag tag) async {

          debugPrint('NFC tag discovered:-------------------------${tag.data}');

          // Do something with an NfcTag instance.
      if (tag.handle.isNotEmpty) {
        // widget.onSuccess.call(tag);
        setState(() {
          final myJson = Map<String, dynamic>.from(tag.data as Map);

          nfcResponseModel =
              NfcResponseModel.fromJson(jsonDecode(json.encode(myJson)));
        });
        nfcTag = tag;
        // nfcManager.stopSession();
      }
    }, onError: (error) async {
      log(error.toString());
      log(error.type.toString());
      log(error.message.toString());
      log(error.details.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("Nfc scan credit card",
            color: AppColors.white, fontSize: 22),
      ),
      body: FutureBuilder(
        future: NfcManager.instance.isAvailable(),
        builder: (context, ss) =>
        // ss.data != true
            // ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
            // :
        Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: AppText(
                            "NFC ni yoqing va kartani qurilmangizga qo‘ying"),
                      ),
                      Lottie.asset(AppAssets.nfcScanLottie),

                      ElevatedButton(
                        onPressed: _tagRead,
                        child: const Text("Tag Read"),
                      ),

                      // isodep
                      AppText(
                          maxLines: 3,
                          "isodep->historicalBytes: ${(nfcResponseModel?.isodep?.historicalBytes ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "isodep->hiLayerResponse: ${(nfcResponseModel?.isodep?.hiLayerResponse ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "isodep->identifier: ${(nfcResponseModel?.isodep?.identifier ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "isodep->isExtendedLengthApduSupported: ${(nfcResponseModel?.isodep?.isExtendedLengthApduSupported ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "isodep->maxTransceiveLength: ${(nfcResponseModel?.isodep?.maxTransceiveLength ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "isodep->timeout: ${(nfcResponseModel?.isodep?.timeout ?? "").toString()}"),

                      12.verticalSpace,

                      // mifareclassic
                      AppText(
                          maxLines: 3,
                          "mifareclassic->timeout: ${(nfcResponseModel?.mifareclassic?.timeout ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "mifareclassic->maxTransceiveLength: ${(nfcResponseModel?.mifareclassic?.maxTransceiveLength ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "mifareclassic->identifier: ${(nfcResponseModel?.mifareclassic?.identifier ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "mifareclassic->type: ${(nfcResponseModel?.mifareclassic?.type ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "mifareclassic->size: ${(nfcResponseModel?.mifareclassic?.size ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "mifareclassic->blockCount: ${(nfcResponseModel?.mifareclassic?.blockCount ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "mifareclassic->sectorCount: ${(nfcResponseModel?.mifareclassic?.sectorCount ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "mifareclassic->sectorCount: ${(nfcResponseModel?.mifareclassic?.sectorCount ?? "").toString()}"),
                      12.verticalSpace,
                      // ndefformatable
                      AppText(
                          maxLines: 3,
                          "ndefformatable->identifier: ${(nfcResponseModel?.ndefformatable?.identifier ?? "").toString()}"),
                      12.verticalSpace,

                      // nfca
                      AppText(
                          maxLines: 3,
                          "nfca->identifier: ${(nfcResponseModel?.nfca?.identifier ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "nfca->maxTransceiveLength: ${(nfcResponseModel?.nfca?.maxTransceiveLength ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "nfca->timeout: ${(nfcResponseModel?.nfca?.timeout ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "nfca->atqa: ${(nfcResponseModel?.nfca?.atqa ?? "").toString()}"),
                      AppText(
                          maxLines: 3,
                          "nfca->sak: ${(nfcResponseModel?.nfca?.sak ?? "").toString()}"),

                      12.verticalSpace,
                      // handle
                      AppText(
                          maxLines: 3,
                          "handle: ${nfcTag?.handle.toString() ?? " "}"),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final nfcResponseModel = nfcResponseModelFromJson(jsonString);

NfcResponseModel nfcResponseModelFromJson(String str) =>
    NfcResponseModel.fromJson(json.decode(str));

String nfcResponseModelToJson(NfcResponseModel data) =>
    json.encode(data.toJson());

class NfcResponseModel {
  final Isodep? isodep;
  final Nfca? nfca;
  final Mifareclassic? mifareclassic;
  final Ndefformatable? ndefformatable;

  NfcResponseModel({
    this.isodep,
    this.nfca,
    this.mifareclassic,
    this.ndefformatable,
  });

  factory NfcResponseModel.fromJson(Map<String, dynamic> json) =>
      NfcResponseModel(
        isodep: json["isodep"] == null ? null : Isodep.fromJson(json["isodep"]),
        nfca: json["nfca"] == null ? null : Nfca.fromJson(json["nfca"]),
        mifareclassic: json["mifareclassic"] == null
            ? null
            : Mifareclassic.fromJson(json["mifareclassic"]),
        ndefformatable: json["ndefformatable"] == null
            ? null
            : Ndefformatable.fromJson(json["ndefformatable"]),
      );

  Map<String, dynamic> toJson() => {
        "isodep": isodep?.toJson(),
        "nfca": nfca?.toJson(),
        "mifareclassic": mifareclassic?.toJson(),
        "ndefformatable": ndefformatable?.toJson(),
      };
}

class Isodep {
  final List<int>? identifier;
  final dynamic hiLayerResponse;
  final List<int>? historicalBytes;
  final bool? isExtendedLengthApduSupported;
  final int? maxTransceiveLength;
  final int? timeout;

  Isodep({
    this.identifier,
    this.hiLayerResponse,
    this.historicalBytes,
    this.isExtendedLengthApduSupported,
    this.maxTransceiveLength,
    this.timeout,
  });

  factory Isodep.fromJson(Map<String, dynamic> json) => Isodep(
        identifier: json["identifier"] == null
            ? []
            : List<int>.from(json["identifier"]!.map((x) => x)),
        hiLayerResponse: json["hiLayerResponse"],
        historicalBytes: json["historicalBytes"] == null
            ? []
            : List<int>.from(json["historicalBytes"]!.map((x) => x)),
        isExtendedLengthApduSupported: json["isExtendedLengthApduSupported"],
        maxTransceiveLength: json["maxTransceiveLength"],
        timeout: json["timeout"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier == null
            ? []
            : List<dynamic>.from(identifier!.map((x) => x)),
        "hiLayerResponse": hiLayerResponse,
        "historicalBytes": historicalBytes == null
            ? []
            : List<dynamic>.from(historicalBytes!.map((x) => x)),
        "isExtendedLengthApduSupported": isExtendedLengthApduSupported,
        "maxTransceiveLength": maxTransceiveLength,
        "timeout": timeout,
      };
}

class Mifareclassic {
  final List<int>? identifier;
  final int? blockCount;
  final int? maxTransceiveLength;
  final int? sectorCount;
  final int? size;
  final int? timeout;
  final int? type;

  Mifareclassic({
    this.identifier,
    this.blockCount,
    this.maxTransceiveLength,
    this.sectorCount,
    this.size,
    this.timeout,
    this.type,
  });

  factory Mifareclassic.fromJson(Map<String, dynamic> json) => Mifareclassic(
        identifier: json["identifier"] == null
            ? []
            : List<int>.from(json["identifier"]!.map((x) => x)),
        blockCount: json["blockCount"],
        maxTransceiveLength: json["maxTransceiveLength"],
        sectorCount: json["sectorCount"],
        size: json["size"],
        timeout: json["timeout"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier == null
            ? []
            : List<dynamic>.from(identifier!.map((x) => x)),
        "blockCount": blockCount,
        "maxTransceiveLength": maxTransceiveLength,
        "sectorCount": sectorCount,
        "size": size,
        "timeout": timeout,
        "type": type,
      };
}

class Ndefformatable {
  final List<int>? identifier;

  Ndefformatable({
    this.identifier,
  });

  factory Ndefformatable.fromJson(Map<String, dynamic> json) => Ndefformatable(
        identifier: json["identifier"] == null
            ? []
            : List<int>.from(json["identifier"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier == null
            ? []
            : List<dynamic>.from(identifier!.map((x) => x)),
      };
}

class Nfca {
  final List<int>? identifier;
  final List<int>? atqa;
  final int? maxTransceiveLength;
  final int? sak;
  final int? timeout;

  Nfca({
    this.identifier,
    this.atqa,
    this.maxTransceiveLength,
    this.sak,
    this.timeout,
  });

  factory Nfca.fromJson(Map<String, dynamic> json) => Nfca(
        identifier: json["identifier"] == null
            ? []
            : List<int>.from(json["identifier"]!.map((x) => x)),
        atqa: json["atqa"] == null
            ? []
            : List<int>.from(json["atqa"]!.map((x) => x)),
        maxTransceiveLength: json["maxTransceiveLength"],
        sak: json["sak"],
        timeout: json["timeout"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier == null
            ? []
            : List<dynamic>.from(identifier!.map((x) => x)),
        "atqa": atqa == null ? [] : List<dynamic>.from(atqa!.map((x) => x)),
        "maxTransceiveLength": maxTransceiveLength,
        "sak": sak,
        "timeout": timeout,
      };
}
