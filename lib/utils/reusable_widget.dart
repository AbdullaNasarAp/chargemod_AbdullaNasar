import 'package:abdulla_nasar/utils/constant.dart';
import 'package:abdulla_nasar/utils/hex_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class CustomFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(
          giveText: labelText,
          fontsize: 12,
          fontweight: FontWeight.w700,
        ),
        kHeight(8),
        TextFormField(
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            hintText: hintText,
            hintStyle: textStyle(
              textColor: HexColor("666766"),
              fontsize: 12,
            ),
            labelText: labelText,
            labelStyle: textStyle(
              textColor: HexColor("666766"),
              fontsize: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: HexColor("E4DFDF")),
            ),
            enabled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: HexColor("E4DFDF"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}
