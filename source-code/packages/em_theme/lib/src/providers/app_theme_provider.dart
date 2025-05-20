import 'package:em_theme/src/theme/app_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AppThemeProvider extends StatelessWidget {
  final Widget child;
  final AppTheme theme;

  const AppThemeProvider({required this.theme, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.value(value: theme, child: child);
  }
}
