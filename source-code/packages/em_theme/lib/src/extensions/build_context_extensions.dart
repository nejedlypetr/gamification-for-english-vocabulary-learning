import 'package:em_theme/em_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension BuildContextExtension on BuildContext {
  AppTheme get theme => Provider.of<AppTheme>(this, listen: false);

  AppTextTheme get textTheme => theme.textTheme;
  AppColorTheme get colors => theme.colors;

  MediaQueryData get mq => MediaQuery.of(this);

  TextScaler get textScaler => mq.textScaler;
  double textScalerScale(double value) => textScaler.scale(value);
}
