import 'package:em_theme/em_theme.dart';
import 'package:flutter/widgets.dart';

class VariantAppTheme extends InheritedWidget {
  final AppTheme data;

  const VariantAppTheme({
    required this.data,
    required super.child,
    super.key,
  });

  static AppTheme of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<VariantAppTheme>();
    return widget!.data;
  }

  @override
  bool updateShouldNotify(covariant VariantAppTheme oldWidget) {
    return data != oldWidget.data;
  }
}
