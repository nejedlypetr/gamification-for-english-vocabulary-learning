import 'package:em_theme/em_theme.dart';
import 'package:english_mind_widgetbook/addons/theme.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      directories: directories,
      addons: [
        GridAddon(10),
        ThemeAddon<AppTheme>(
          themes: [
            WidgetbookTheme(data: AppTheme(AppThemeMode.light), name: 'LIGHT'),
            WidgetbookTheme(data: AppTheme(AppThemeMode.dark), name: 'DARK'),
          ],
          themeBuilder: (context, theme, child) {
            return AppThemeProvider(
              theme: theme,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: VariantAppTheme(data: theme, child: child),
                ),
              ),
            );
          },
        ),
        TextScaleAddon(min: 1.0, initialScale: 1),
        DeviceFrameAddon(
          devices: [
            Devices.ios.iPhoneSE,
            Devices.ios.iPhone12,
            Devices.ios.iPhone13,
            Devices.ios.iPhone13Mini,
            Devices.ios.iPhone13ProMax,
            Devices.android.smallPhone,
            Devices.android.mediumPhone,
            Devices.android.bigPhone,
            Devices.ios.iPad,
            Devices.ios.iPadAir4,
          ],
        ),
        AlignmentAddon(initialAlignment: Alignment.topLeft),
      ],
      appBuilder: (context, child) {
        return SafeArea(
          child: Padding(padding: const EdgeInsets.all(60), child: child),
        );
      },
    );
  }
}
