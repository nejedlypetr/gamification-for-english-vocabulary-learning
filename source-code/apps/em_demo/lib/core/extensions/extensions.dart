import 'package:em_vocabulary/em_vocabulary.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:english_mind_demo/core/l10n/app_localizations.g.dart';
import 'package:english_mind_demo/data/models/flashcard_srs_metadata.dart';
import 'package:flutter/material.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension DefinitionExtension on List<Definition> {
  List<EmDefinition> toEmDefinitions() {
    return map(
      (definition) => EmDefinition(
        definition: definition.definition,
        examples: definition.examples,
      ),
    ).toList();
  }
}

extension FlashcardSrsMetadataExtension on FlashcardSrsMetadata {
  WordProgressTrackerStage get stage {
    return switch (interval) {
      < 4_320 => WordProgressTrackerStage.stage1, // Less than 3 days
      < 10_080 => WordProgressTrackerStage.stage2, // Less than 1 week
      < 30_240 => WordProgressTrackerStage.stage3, // Less than 3 weeks
      < 129_600 => WordProgressTrackerStage.stage4, // Less than 3 months
      _ => WordProgressTrackerStage.stage5, // 3 months or more
    };
  }
}

extension DateTimeExtension on DateTime {
  bool isSameYearMonthDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
