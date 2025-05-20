import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'default', type: EmStreakBadge)
Widget buildStreakBadgeUseCase(BuildContext context) {
  return const EmStreakBadge(
    streakText: 'day\nstreak',
    streakCount: 10,
  );
}
