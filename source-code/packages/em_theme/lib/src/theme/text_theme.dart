import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/widgets.dart';

part 'text_theme.g.dart';

@CopyWith()
class AppTextTheme {
  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle title1;
  final TextStyle title2;
  final TextStyle labelL;
  final TextStyle labelM;
  final TextStyle labelS;
  final TextStyle buttonM;
  final TextStyle buttonL;
  final TextStyle buttonS;
  final TextStyle caption;
  final TextStyle footnote;

  const AppTextTheme({
    required this.heading1,
    required this.heading2,
    required this.title1,
    required this.title2,
    required this.labelL,
    required this.labelM,
    required this.labelS,
    required this.buttonL,
    required this.buttonM,
    required this.buttonS,
    required this.caption,
    required this.footnote,
  });
}
