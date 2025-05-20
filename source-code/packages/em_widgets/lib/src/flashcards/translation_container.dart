import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EmTranslationContainer extends HookWidget {
  final FlagIcon flagIcon;
  final List<String> translations;

  const EmTranslationContainer({
    required this.flagIcon,
    required this.translations,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    final slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(curve: Curves.easeOutQuint, parent: animationController),
    );

    useEffect(
      () {
        animationController.forward();
        return null;
      },
      [],
    );

    return Container(
      padding: const EdgeInsets.all(6).copyWith(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: context.colors.feedback.warning.alpha,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: context.textScaler.scale(12),
          children: [
            EmFlagIcon(flagIcon),
            ...translations.map(
              (translation) => SlideTransition(
                position: slideAnimation,
                child: FadeTransition(
                  opacity: animationController,
                  child: Text(
                    translation,
                    style: context.theme.textTheme.labelS.medium.withColor(
                      context.colors.feedback.warning.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
