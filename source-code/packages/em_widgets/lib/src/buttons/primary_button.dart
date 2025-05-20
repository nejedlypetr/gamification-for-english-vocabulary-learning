import 'package:em_theme/em_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PrimaryButtonSize { s, m, l, xl }

enum PrimaryButtonVariant {
  primary,
  neutral,
  neutralDark,
  success,
  successDark,
  successSolid,
  error,
  errorDark,
  errorSolid,
}

class EmPrimaryButton extends StatelessWidget {
  final String text;
  final int? indicator;
  final bool isLoading;
  final bool isDisabled;
  final bool isFullWidth;
  final bool useNotoSansFont;
  final IconData? prefixIcon;
  final PrimaryButtonSize size;
  final VoidCallback? onPressed;
  final PrimaryButtonVariant variant;

  const EmPrimaryButton({
    required this.text,
    required this.onPressed,
    this.indicator,
    this.prefixIcon,
    this.isLoading = false,
    this.isDisabled = false,
    this.isFullWidth = true,
    this.useNotoSansFont = false,
    this.size = PrimaryButtonSize.l,
    this.variant = PrimaryButtonVariant.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final (iconSize, textStyle, buttonSize) = switch (size) {
      PrimaryButtonSize.s => (
          20.0,
          context.textTheme.buttonS,
          Size.square(context.textScalerScale(40)),
        ),
      PrimaryButtonSize.m => (
          20.0,
          context.textTheme.buttonM,
          Size.square(context.textScalerScale(52)),
        ),
      PrimaryButtonSize.l => (
          24.0,
          context.textTheme.buttonL,
          Size.square(context.textScalerScale(70)),
        ),
      PrimaryButtonSize.xl => (
          24.0,
          context.textTheme.buttonL,
          Size.square(context.textScalerScale(82)),
        ),
    };

    final colors = context.colors;
    final (buttonColor, textColor) = switch ((variant, isDisabled)) {
      (PrimaryButtonVariant.primary, true) => (
          colors.interactive.accent.disabled,
          colors.text.neutral.disabled,
        ),
      (PrimaryButtonVariant.primary, false) => (
          colors.interactive.accent.primary,
          colors.text.neutral.inverted,
        ),
      (PrimaryButtonVariant.neutral, true) => (
          colors.background.lite,
          colors.interactive.neutral.primary,
        ),
      (PrimaryButtonVariant.neutral, false) => (
          colors.background.lite,
          colors.interactive.neutral.primary,
        ),
      (PrimaryButtonVariant.success, true) => (
          colors.feedback.success.alpha,
          colors.feedback.success.primary,
        ),
      (PrimaryButtonVariant.success, false) => (
          colors.feedback.success.alpha,
          colors.feedback.success.primary,
        ),
      (PrimaryButtonVariant.error, true) => (
          colors.feedback.error.alpha,
          colors.feedback.error.primary,
        ),
      (PrimaryButtonVariant.error, false) => (
          colors.feedback.error.alpha,
          colors.feedback.error.primary,
        ),
      (PrimaryButtonVariant.neutralDark, true) => (
          colors.interactive.neutral.primary.withAlpha(30),
          colors.interactive.neutral.primary,
        ),
      (PrimaryButtonVariant.neutralDark, false) => (
          colors.interactive.neutral.primary.withAlpha(30),
          colors.interactive.neutral.primary,
        ),
      (PrimaryButtonVariant.successDark, true) => (
          colors.feedback.success.primary.withAlpha(30),
          colors.feedback.success.primary,
        ),
      (PrimaryButtonVariant.successDark, false) => (
          colors.feedback.success.primary.withAlpha(30),
          colors.feedback.success.primary,
        ),
      (PrimaryButtonVariant.errorDark, true) => (
          colors.feedback.error.primary.withAlpha(30),
          colors.feedback.error.primary,
        ),
      (PrimaryButtonVariant.errorDark, false) => (
          colors.feedback.error.primary.withAlpha(30),
          colors.feedback.error.primary,
        ),
      (PrimaryButtonVariant.successSolid, true) => (
          colors.feedback.success.primary,
          colors.text.neutral.inverted,
        ),
      (PrimaryButtonVariant.successSolid, false) => (
          colors.feedback.success.primary,
          colors.text.neutral.inverted,
        ),
      (PrimaryButtonVariant.errorSolid, true) => (
          colors.feedback.error.primary,
          colors.text.neutral.inverted,
        ),
      (PrimaryButtonVariant.errorSolid, false) => (
          colors.feedback.error.primary,
          colors.text.neutral.inverted,
        ),
    };
    return IgnorePointer(
      ignoring: isDisabled || isLoading,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          minimumSize: buttonSize,
          foregroundColor: textColor,
          backgroundColor: buttonColor,
          visualDensity: VisualDensity.standard,
          padding: EdgeInsets.symmetric(
            horizontal: context.textScalerScale(14),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.textScalerScale(24)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
          children: [
            if (isLoading)
              SizedBox(
                width: context.textScalerScale(iconSize),
                height: context.textScalerScale(iconSize - 4),
                child: FittedBox(
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? CupertinoActivityIndicator(color: textColor)
                      : CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(textColor),
                        ),
                ),
              )
            else if (prefixIcon != null)
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: Icon(
                  prefixIcon,
                  size: iconSize,
                  color: textColor,
                  applyTextScaling: true,
                ),
              ),
            Flexible(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: indicator == null ? 0 : 14,
                    ),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: useNotoSansFont
                          ? textStyle.copyWith(
                              color: textColor,
                              fontFamily: 'NotoSans',
                              fontWeight: FontWeight.w600,
                            )
                          : textStyle.withColor(textColor),
                    ),
                  ),
                  if (indicator != null)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 22,
                        height: 22,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colors.feedback.error.primary,
                          border: Border.all(
                            width: 2,
                            color: context.colors.feedback.error.alpha,
                          ),
                        ),
                        child: FittedBox(
                          child: Text(
                            indicator.toString(),
                            style: context.textTheme.caption.bold.withColor(
                              textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
