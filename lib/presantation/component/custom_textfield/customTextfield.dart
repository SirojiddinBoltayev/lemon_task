import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_assets/app_assets.dart';
import '../../../constants/app_colors/app_colors.dart';
import '../../../constants/theme/app_textstyles/app_text_styles.dart';
import '../app_text/app_text.dart';
import '../circle_button_container.dart';
import '../custom_svg.dart';
import '../gradient_border.dart';

class AppCustomTextField extends StatefulWidget {
  final String title;
  final String? countryCode;
  final double? height;
  final int? maxLines;
  final int? minLines;
  final int? lineLength;
  final bool? isDateTimeValue;
  final bool? creditCard;
  final String labelText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final Color? textColor;
  final Function()? onChanged;
  final Function()? searchClearButton;
  final Function()? onSecureOnTap;
  final Function()? onTap;
  final Function(String?)? validator;
  final Function(String?)? onValueChanged;
  final bool? enabled;
  final bool? isLoading;
  final bool? searchActive;
  final bool? requiredField;
  final bool? obscureText;
  final bool? onSecureText;
  final bool? suffixIconActive;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? borderColor;
  final TextInputAction textInputAction;

  const AppCustomTextField(
      {super.key,
      this.isLoading,
      this.searchClearButton,
      this.onSecureOnTap,
      this.isDateTimeValue,
      this.borderColor,
      this.onSecureText,
      required this.controller,
      this.searchActive,
      this.prefixIcon,
      this.suffixIconActive,
      required this.title,
      required this.labelText,
      this.onChanged,
      this.onTap,
      this.suffixIcon,
      this.textColor,
      this.keyboardType,
      this.enabled = true,
      this.requiredField = false,
      this.obscureText,
      this.errorText,
      this.textInputAction = TextInputAction.next,
      this.height,
      this.countryCode,
      this.maxLines,
      this.minLines,
      this.lineLength,
      this.validator,
      this.onValueChanged,
      this.creditCard, this.inputFormatters});

  @override
  State<AppCustomTextField> createState() => _AppCustomTextFieldState();
}

class _AppCustomTextFieldState extends State<AppCustomTextField> {
  bool onSecurePass = false;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          widget.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.controller.text.length));
        }
      });
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    focusNode.unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.unfocus();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double borderRadius = 10.sp;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.title == ""
            ? 0.verticalSpace
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    widget.title,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  (widget.requiredField ?? false)
                      ? Text(
                          " *",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.red),
                        )
                      : const SizedBox(),
                ],
              ),
        widget.title == "" ? 0.verticalSpace : 8.verticalSpace,
        Container(
          decoration: BoxDecoration(
            color: widget.errorText?.isNotEmpty ?? false
                ? AppColors.red.withOpacity(0.1)
                : focusNode.hasFocus
                    ? AppColors.cF5F5F5
                    : AppColors.textFieldBackgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          height: widget.height ?? 44.sp,
          child: TextFormField(
            focusNode: focusNode,
            minLines: widget.minLines ?? 1,
            maxLines: widget.maxLines ?? 1,
            maxLength: widget.lineLength,
            onTapOutside: (e) {
              focusNode.unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            textAlign: TextAlign.start,
            enabled: widget.enabled,
            textAlignVertical: TextAlignVertical.center,
            onTap: () {
              widget.onTap?.call();
              FocusScope.of(context).requestFocus(focusNode);
            },
            validator: (v) {},
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            obscuringCharacter: "●",
            style: !(widget.enabled ?? true)
                ? AppTextStyles.euclidRegular.copyWith(
                    color: widget.textColor ?? Theme.of(context).disabledColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  )
                : widget.keyboardType == TextInputType.phone ||
                        widget.keyboardType == TextInputType.number
                    ? AppTextStyles.euclidRegular.copyWith(
                        color: widget.textColor ??
                            Theme.of(context).textTheme.titleLarge?.color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      )
                    : AppTextStyles.euclidRegular.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.titleLarge?.color),
            inputFormatters: widget.keyboardType == TextInputType.phone
                ? [
                    MaskedInputFormatter("## ###-##-##"),
                    FilteringTextInputFormatter.allow(RegExp(r'[()\d-\s]')),
                  ]
                : widget.keyboardType == TextInputType.number
                    ? widget.creditCard ?? false
                        ? [
                            MaskedInputFormatter("#### #### #### ####"),
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[()\d-\s]')),
                          ]
                        : widget.isDateTimeValue ?? false
                            ? [
                                MaskedInputFormatter('####-##-##'),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[()\d-\s\.]')),
                              ]
                            : [
                                CurrencyInputFormatter(
                                  // useSymbolPadding: true,
                                  thousandSeparator:
                                      ThousandSeparator.SpaceAndPeriodMantissa,
                                  mantissaLength: 0,
                                  leadingSymbol: "",
                                )
                              ]
                    : widget.inputFormatters ,
            obscureText: (widget.obscureText ?? false) ? onSecurePass : false,
            cursorColor: AppColors.primaryColor,
            cursorWidth: 1.sp,
            cursorHeight: 21.sp,
            decoration: InputDecoration(
                fillColor: AppColors.cF5F5F5,
                filled: false,
                counterStyle: widget.lineLength != null
                    ? const TextStyle(color: AppColors.labelColor)
                    : null,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.isLoading ?? false
                        ? Container(
                            height: 0.05.sh,
                            width: 0.05.sh,
                            padding: const EdgeInsets.all(8),
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              // value: 0.1,
                              backgroundColor: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0),
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : 0.verticalSpace,
                    widget.obscureText ?? false
                        ? InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              setState(() {});
                              onSecurePass = !onSecurePass;
                              widget.onSecureOnTap?.call();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: onSecurePass
                                  ? AppCustomSvgWidgetAsset(
                                      AppAssets.eyeIconSvg,
                                      color:
                                          widget.errorText?.isNotEmpty ?? false
                                              ? AppColors.red
                                              : Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.color,
                                      size: 24.sp,
                                      defaultColor: true,
                                    )
                                  : AppCustomSvgWidgetAsset(
                                      AppAssets.eyeOffIconSvg,
                                      color:
                                          widget.errorText?.isNotEmpty ?? false
                                              ? AppColors.red
                                              : Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.color,
                                      size: 24.sp,
                                      defaultColor: true,
                                    ),
                            ),
                          )
                        : (widget.searchActive ?? false)
                            ? (widget.controller.text != ""
                                ? SizedBox(
                                    width: 35.sp,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.sp),
                                      child: AppCircleButtonContainer(
                                        size: 30.sp,
                                        sizeDisable: true,
                                        backgroundColor: AppColors.transparent,
                                        icon: const AppCustomSvgWidgetAsset(
                                          AppAssets.registerIconSvg,
                                          color: AppColors.red,
                                          defaultColor: false,
                                        ),
                                        // title: '',
                                        isLoading: false,
                                        onPressed: () {
                                          widget.controller.clear();
                                          widget.searchClearButton?.call();
                                        },
                                      ),
                                    ),
                                  )
                                : 0.verticalSpace)
                            : (widget.suffixIconActive ?? true)
                                ? (widget.suffixIcon ?? 0.verticalSpace)
                                : widget.controller.text != ""
                                    ? (widget.suffixIcon ?? 0.verticalSpace)
                                    : 0.verticalSpace,
                    5.horizontalSpace
                  ],
                ),
                // filled: true,

                prefixIcon: widget.keyboardType == TextInputType.phone
                    ? Container(
                        // padding: EdgeInsets.only(left: 0.0.sp, right: 4.sp),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Container(
                            //     // alignment: Alignment.center,
                            //     margin:
                            //     EdgeInsets.symmetric(horizontal: 8.sp),
                            //     padding:
                            //     EdgeInsets.symmetric(vertical: 15.sp),
                            //     width: 1.3,
                            //     height: 20.sp,
                            //     decoration: BoxDecoration(
                            //         color: !(widget.enabled ?? true)
                            //             ? Theme.of(context).disabledColor
                            //             : AppColors.labelColor
                            //             .withOpacity(0.3),
                            //         borderRadius:
                            //         BorderRadius.circular(12)),
                            //     // child: Column(),
                            //   )
                          ],
                        ),
                      )
                    : widget.prefixIcon,
                prefixStyle: AppTextStyles.euclidRegular.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
                // prefixIconColor: AppColors.primaryColor,
                prefixIconConstraints: const BoxConstraints.tightForFinite(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 16.sp),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                        color: widget.errorText?.isNotEmpty ?? false
                            ? AppColors.red
                            : widget.borderColor ??
                                Theme.of(context).primaryColor)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                        color: widget.errorText?.isNotEmpty ?? false
                            ? AppColors.red
                            : widget.borderColor ??
                                Theme.of(context)
                                    .dividerColor
                                    .withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                        color: widget.errorText?.isNotEmpty ?? false
                            ? AppColors.red
                            : widget.borderColor ?? AppColors.transparent)),
                focusedBorder: GradientOutlineInputBorder(
                    height: widget.height ?? 44.sp,
                    borderRadius: BorderRadius.circular(borderRadius),
                    gradient: const LinearGradient(colors: [
                      AppColors.primaryLightColor,
                      AppColors.primaryColor,
                    ])),
                focusColor:
                    widget.borderColor ?? Theme.of(context).primaryColor,
                hintText: widget.keyboardType == TextInputType.phone
                    ? "00 000-00-00"
                    : widget.labelText,
                hintStyle: AppTextStyles.euclidRegular.copyWith(
                    color: !(widget.enabled ?? true)
                        ? AppColors.labelColor
                        : AppColors.labelColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp),
                // errorText: "$errorText",
                error: null),
            onChanged: (value) {
              if ((widget.keyboardType == TextInputType.phone)) {}
              widget.onValueChanged?.call(value);
              widget.onChanged?.call();
            },
          ),
        ),
        widget.errorText?.isNotEmpty ?? false
            ? 5.sp.verticalSpace
            : 0.verticalSpace,
        widget.errorText?.isNotEmpty ?? false
            ? AppText(
                widget.errorText ?? "",
                maxLines: 2,
                color: AppColors.red,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              )
            : 0.verticalSpace,
      ],
    );
  }
}
