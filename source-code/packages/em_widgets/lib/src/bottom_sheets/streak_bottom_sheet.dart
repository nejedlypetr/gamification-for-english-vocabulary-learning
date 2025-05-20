import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

enum EmStreakBottomSheetVariant { inactivated, almostActivated, activated }

class EmStreakBottomSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final String instruction1;
  final String instruction2;
  final String buttonText;
  final VoidCallback onPressed;
  final EmStreakBottomSheetVariant variant;

  const EmStreakBottomSheet({
    required this.title,
    required this.subtitle,
    required this.instruction1,
    required this.instruction2,
    required this.buttonText,
    required this.onPressed,
    required this.variant,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EmBottomSheet(
      title: title,
      prefixIcon: EmCircularIcon(
        HeroiconsSolid.fire,
        iconColor: context.colors.feedback.warning.primary,
        backgroundColor: context.colors.feedback.warning.alpha,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle, style: context.textTheme.labelM),
          const SizedBox.square(dimension: 12),
          Row(
            spacing: 8,
            children: [
              Icon(
                HeroiconsSolid.checkCircle,
                size: 28,
                color: variant == EmStreakBottomSheetVariant.almostActivated
                    ? context.colors.feedback.success.primary
                    : context.colors.interactive.neutral.disabled,
              ),
              Expanded(
                child: Text(instruction1, style: context.textTheme.labelS),
              ),
            ],
          ),
          const SizedBox.square(dimension: 4),
          Row(
            spacing: 8,
            children: [
              Icon(
                HeroiconsSolid.checkCircle,
                size: 28,
                color: context.colors.interactive.neutral.disabled,
              ),
              Expanded(
                child: Text(instruction2, style: context.textTheme.labelS),
              ),
            ],
          ),
          const SizedBox.square(dimension: 24),
          EmPrimaryButton(
            text: buttonText,
            onPressed: onPressed,
            size: PrimaryButtonSize.xl,
          ),
        ],
      ),
    );
  }
}
