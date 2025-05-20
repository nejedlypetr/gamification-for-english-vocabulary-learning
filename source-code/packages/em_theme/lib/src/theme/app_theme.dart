import 'package:em_theme/em_theme.dart';
import 'package:flutter/material.dart';

enum AppThemeMode { light, dark }

class AppTheme {
  final AppThemeMode themeMode;

  AppTheme(this.themeMode);

  String get _fontFamily => 'ReadexPro';

  AppTextTheme get textTheme => AppTextTheme(
        heading1: TextStyle(
          fontSize: 32,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w700,
          color: colors.text.neutral.primary,
        ),
        heading2: TextStyle(
          fontSize: 28,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w700,
          color: colors.text.neutral.primary,
        ),
        title1: TextStyle(
          fontSize: 24,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w600,
          color: colors.text.neutral.primary,
        ),
        title2: TextStyle(
          fontSize: 20,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w600,
          color: colors.text.neutral.primary,
        ),
        labelL: TextStyle(
          fontSize: 18,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w600,
          color: colors.text.neutral.primary,
        ),
        labelM: TextStyle(
          fontSize: 16,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w500,
          color: colors.text.neutral.primary,
        ),
        labelS: TextStyle(
          fontSize: 14,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w500,
          color: colors.text.neutral.primary,
        ),
        buttonL: TextStyle(
          fontSize: 20,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w600,
          color: colors.text.neutral.primary,
        ),
        buttonM: TextStyle(
          fontSize: 16,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w500,
          color: colors.text.neutral.primary,
        ),
        buttonS: TextStyle(
          fontSize: 16,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w500,
          color: colors.text.neutral.primary,
        ),
        caption: TextStyle(
          fontSize: 12,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w400,
          color: colors.text.neutral.primary,
        ),
        footnote: TextStyle(
          fontSize: 10,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w400,
          color: colors.text.neutral.primary,
        ),
      );

  AppColorTheme get colors => AppColorTheme(
        feedback: FeedbackColors(
          info: FeedbackColorsVariants(
            primary: const Color(0xff387EA9),
            alpha: const Color(0xffD7E5EE),
          ),
          success: FeedbackColorsVariants(
            primary: const Color(0xff27AE60),
            alpha: const Color(0xffD4EFDF),
          ),
          error: FeedbackColorsVariants(
            primary: const Color(0xffFB5555),
            alpha: const Color(0xffFDDFDD),
          ),
          warning: FeedbackColorsVariants(
            primary: const Color(0xffFC903E),
            alpha: const Color(0xffFEE9D8),
          ),
          neutral: FeedbackColorsVariants(
            primary: const Color(0xff535353),
            alpha: const Color(0xffF1F3F2),
          ),
        ),
        text: TextColors(
          accent: TextColorsVariants(
            primary: const Color(0xffFC903E),
            disabled: const Color(0xffFC903E),
            inverted: const Color(0xffFC903E),
          ),
          neutral: TextColorsVariants(
            primary: const Color(0xff2C3D4F),
            disabled: const Color(0xccFFFFFF),
            inverted: const Color(0xffFFFFFF),
          ),
        ),
        background: BackgroundColors(
          primary: const Color(0xffFCEDE1),
          inverted: const Color(0xffFFFFFF),
          lite: const Color(0xffEDEDED),
        ),
        interactive: InteractiveColors(
          accent: InteractiveColorsVariants(
            primary: const Color(0xffFC903E),
            disabled: const Color(0xffFED3B2),
          ),
          secondary: InteractiveColorsVariants(
            primary: const Color(0xff27AE60),
            disabled: const Color(0xffA9DFBF),
          ),
          tertiary: InteractiveColorsVariants(
            primary: const Color(0xff387EA9),
            disabled: const Color(0xffB0CBDD),
          ),
          neutral: InteractiveColorsVariants(
            primary: const Color(0xff535353),
            disabled: const Color(0xffA5A5A5),
          ),
          destructive: InteractiveColorsVariants(
            primary: const Color(0xffFB5555),
            disabled: const Color(0xffFDBBBB),
          ),
        ),
        progressTracker: ProgressTrackerColors(
          stage1: const Color(0xffA880DB),
          stage2: const Color(0xffFB55CF),
          stage3: const Color(0xffFC903E),
          stage4: const Color(0xff387EA9),
          stage5: const Color(0xff27AE60),
          stage1Alpha: const Color(0xffEEE6F8),
          stage2Alpha: const Color(0xffFEDDF5),
          stage3Alpha: const Color(0xffFEE9D8),
          stage4Alpha: const Color(0xffD7E5EE),
          stage5Alpha: const Color(0xffD4EFDF),
        ),
      );
}
