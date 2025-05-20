import 'package:flutter/material.dart';

class AppColorTheme {
  final TextColors text;
  final FeedbackColors feedback;
  final BackgroundColors background;
  final InteractiveColors interactive;
  final ProgressTrackerColors progressTracker;

  AppColorTheme({
    required this.text,
    required this.feedback,
    required this.background,
    required this.interactive,
    required this.progressTracker,
  });
}

class FeedbackColors {
  final FeedbackColorsVariants info;
  final FeedbackColorsVariants success;
  final FeedbackColorsVariants error;
  final FeedbackColorsVariants warning;
  final FeedbackColorsVariants neutral;

  FeedbackColors({
    required this.info,
    required this.success,
    required this.error,
    required this.warning,
    required this.neutral,
  });
}

class FeedbackColorsVariants {
  final Color primary;
  final Color alpha;

  FeedbackColorsVariants({
    required this.primary,
    required this.alpha,
  });
}

class InteractiveColors {
  final InteractiveColorsVariants accent;
  final InteractiveColorsVariants secondary;
  final InteractiveColorsVariants tertiary;
  final InteractiveColorsVariants neutral;
  final InteractiveColorsVariants destructive;

  InteractiveColors({
    required this.accent,
    required this.secondary,
    required this.tertiary,
    required this.neutral,
    required this.destructive,
  });
}

class InteractiveColorsVariants {
  final Color primary;
  final Color disabled;

  InteractiveColorsVariants({
    required this.primary,
    required this.disabled,
  });
}

class TextColors {
  final TextColorsVariants accent;
  final TextColorsVariants neutral;

  TextColors({
    required this.accent,
    required this.neutral,
  });
}

class TextColorsVariants {
  final Color primary;
  final Color disabled;
  final Color inverted;

  TextColorsVariants({
    required this.primary,
    required this.disabled,
    required this.inverted,
  });
}

class BackgroundColors {
  final Color primary;
  final Color inverted;
  final Color lite;

  BackgroundColors({
    required this.primary,
    required this.inverted,
    required this.lite,
  });
}

class ProgressTrackerColors {
  final Color stage1;
  final Color stage2;
  final Color stage3;
  final Color stage4;
  final Color stage5;
  final Color stage1Alpha;
  final Color stage2Alpha;
  final Color stage3Alpha;
  final Color stage4Alpha;
  final Color stage5Alpha;

  ProgressTrackerColors({
    required this.stage1,
    required this.stage2,
    required this.stage3,
    required this.stage4,
    required this.stage5,
    required this.stage1Alpha,
    required this.stage2Alpha,
    required this.stage3Alpha,
    required this.stage4Alpha,
    required this.stage5Alpha,
  });
}
