import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class EmFlashcardContainer extends StatelessWidget {
  final int totalCards;
  final int currentCardIndex;
  final VoidCallback onClose;
  final VoidCallback onPrevious;
  final VoidCallback onSettings;
  final EmFlashcardType flashcardType;

  const EmFlashcardContainer({
    required this.onClose,
    required this.onPrevious,
    required this.onSettings,
    required this.totalCards,
    required this.flashcardType,
    required this.currentCardIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.background.inverted,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              blurRadius: 24,
              spreadRadius: 8,
              color: context.colors.background.inverted.withAlpha(120),
            ),
          ],
        ),
        child: Column(
          children: [
            _FlashcardTopBar(
              totalCards: totalCards,
              onClosePressed: onClose,
              onPreviousPressed: onPrevious,
              onSettingsPressed: onSettings,
              currentCardIndex: currentCardIndex,
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: flashcardType.getContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlashcardTopBar extends StatelessWidget {
  final int totalCards;
  final int currentCardIndex;
  final VoidCallback onClosePressed;
  final VoidCallback onPreviousPressed;
  final VoidCallback onSettingsPressed;

  const _FlashcardTopBar({
    required this.totalCards,
    required this.onClosePressed,
    required this.onPreviousPressed,
    required this.onSettingsPressed,
    required this.currentCardIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 12,
            children: [
              EmIconButton(HeroiconsSolid.xMark, onPressed: onClosePressed),
              Expanded(
                child: Text(
                  '${currentCardIndex + 1} / $totalCards',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelM,
                ),
              ),
              EmIconButton(
                HeroiconsSolid.arrowUturnLeft,
                onPressed: onPreviousPressed,
              ),
              // EmIconButton(
              //   HeroiconsSolid.ellipsisHorizontal,
              //   onPressed: onSettingsPressed,
              // ),
            ],
          ),
        ),
        TweenAnimationBuilder<double>(
          curve: Curves.easeInOut,
          tween: Tween<double>(
            begin: currentCardIndex / totalCards,
            end: (currentCardIndex + 1) / totalCards,
          ),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, _) => LinearProgressIndicator(
            value: value,
            minHeight: 4,
            color: context.colors.interactive.accent.primary,
            backgroundColor: context.colors.interactive.accent.disabled,
          ),
        ),
      ],
    );
  }
}
