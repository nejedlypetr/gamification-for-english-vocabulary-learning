import 'package:flutter/widgets.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get notoSans => copyWith(fontFamily: 'NotoSans');
  TextStyle get pacifico => copyWith(fontFamily: 'Pacifico');

  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
  TextStyle get black => copyWith(fontWeight: FontWeight.w900);

  TextStyle withColor(Color color) => copyWith(color: color);
}
