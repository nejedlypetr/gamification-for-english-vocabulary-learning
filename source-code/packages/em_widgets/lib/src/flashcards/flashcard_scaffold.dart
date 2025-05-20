import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';

class EmFlashcardScaffold extends StatelessWidget {
  final Widget buttons;
  final int totalCards;
  final int currentCardIndex;
  final EmFlashcardType flashcardType;
  final VoidCallback onClose;
  final VoidCallback onPrevious;
  final VoidCallback onSettings;

  const EmFlashcardScaffold({
    required this.buttons,
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
    return ColoredBox(
      color: Colors.black.withAlpha(60),
      child: SafeArea(
        minimum: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EmFlashcardContainer(
              onClose: onClose,
              onPrevious: onPrevious,
              onSettings: onSettings,
              totalCards: totalCards,
              flashcardType: flashcardType,
              currentCardIndex: currentCardIndex,
            ),
            const SizedBox(height: 12),
            buttons,
          ],
        ),
      ),
    );
  }
}
