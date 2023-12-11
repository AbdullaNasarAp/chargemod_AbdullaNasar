import 'package:abdulla_nasar/utils/constant.dart';
import 'package:flutter/material.dart';

Widget text(
        {required String giveText,
        double fontsize = 14,
        FontWeight fontweight = FontWeight.normal,
        Color textColor = const Color(0xFF2B3453),
        double? textHeight,
        TextDecoration? underline,
        int? maxLine,
        double? letterSpacing,
        TextAlign textAlignment = TextAlign.start}) =>
    Text(
      giveText,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlignment,
      style: textStyle(
        letterSpacing: letterSpacing,
        underline: underline,
        fontsize: fontsize,
        fontfamily: AppConstants.fontFamily,
        fontweight: fontweight,
        textColor: textColor,
        textHeight: textHeight,
      ),
    );

TextStyle textStyle(
    {FontWeight? fontweight,
    Color? textColor,
    double? textHeight,
    String fontfamily = AppConstants.fontFamily,
    double? fontsize,
    double? letterSpacing,
    TextDecoration? underline}) {
  return TextStyle(
    letterSpacing: letterSpacing,
    decoration: underline,
    color: textColor,
    fontFamily: fontfamily,
    fontSize: fontsize,
    fontWeight: fontweight,
    height: textHeight,
  );
}

Widget kWidth(double width) {
  return SizedBox(
    width: width,
  );
}

Widget kHeight(double height) {
  return SizedBox(
    height: height,
  );
}
