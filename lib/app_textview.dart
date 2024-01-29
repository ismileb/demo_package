library app_text_view;
import 'package:flutter/material.dart';
import 'app_fonts.dart';

enum AppTextStyle { textLight, textDark, textUndefined }

class AppTextView extends StatelessWidget {
  final String? text;
  final Color? color;
  final Color? secondaryColor;
  final Color? backGroundColor;
  final FontWeight? fontWeight;
  final FontWeight? secondaryFontWeight;
  final TextAlign? textAlign;
  final double? fontSize;
  final double? secondaryFontSize;
  final TextOverflow? overflow;
  final int? maxLine;
  final int? secondaryMaxLine;
  final bool? softWrap;
  final Function()? onTap;
  final double? topPadding;
  final double? rightPadding;
  final double? leftPadding;
  final double? topMargin;
  final double? secondaryTopMargin;
  final double? leftMargin;
  final double? rightMargin;
  final double? bottomMargin;
  final double? bottomPadding;
  final TextDecoration? textDecoration;
  final Widget? prefix;
  final dynamic translationArgs;
  final String? secondaryText;
  final double? height;
  final Color? textDecorationColor;
  final TextStyle? textStyle;

  const AppTextView(
      {super.key,
      required this.text,
      this.color,
      this.fontWeight,
      this.textAlign,
      this.fontSize,
      this.overflow,
      this.maxLine,
      this.softWrap,
      this.onTap,
      this.topPadding,
      this.bottomPadding,
      this.leftPadding,
      this.rightPadding,
      this.textDecoration,
      this.backGroundColor,
      this.bottomMargin,
      this.topMargin,
      this.prefix,
      this.leftMargin,
      this.rightMargin,
      this.secondaryText,
      this.secondaryColor,
      this.secondaryFontSize,
      this.secondaryFontWeight,
      this.secondaryMaxLine,
      this.translationArgs,
      this.secondaryTopMargin,
      this.height,
      this.textDecorationColor,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: topPadding ?? 0,
          bottom: bottomPadding ?? 0,
          left: leftPadding ?? 0,
          right: rightPadding ?? 0),
      margin: EdgeInsets.only(
          top: topMargin ?? 0,
          bottom: bottomMargin ?? 0,
          left: leftMargin ?? 0,
          right: rightMargin ?? 0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text != null
                  ? text!.isEmpty
                      ? 'N/A'
                      : text!
                  : 'N/A',
              //    text!,
              softWrap: softWrap ?? true,
              textAlign: textAlign,
              overflow: overflow ?? TextOverflow.ellipsis,
              maxLines: maxLine ?? 5,
              style: textStyle ??
                  TextStyle(
                      fontSize: fontSize ?? AppFonts.size16,
                      fontWeight: fontWeight,
                      color: color,
                      decoration: textDecoration,
                      decorationColor: textDecorationColor,
                      backgroundColor: backGroundColor,
                      height: height),
            ),
            secondaryText == null
                ? const SizedBox(
                    height: 0,
                    width: 0,
                  )
                : Container(
                    margin: EdgeInsets.only(top: secondaryTopMargin ?? 4),
                    child: Text(
                      secondaryText ?? "",
                      softWrap: softWrap ?? true,
                      textAlign: textAlign,
                      overflow: overflow ?? TextOverflow.ellipsis,
                      maxLines: secondaryMaxLine ?? 5,
                      style: TextStyle(
                          fontSize: secondaryFontSize ?? AppFonts.size14,
                          fontWeight: secondaryFontWeight,
                          color: secondaryColor,
                          decoration: textDecoration,
                          backgroundColor: backGroundColor,
                          height: height),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
