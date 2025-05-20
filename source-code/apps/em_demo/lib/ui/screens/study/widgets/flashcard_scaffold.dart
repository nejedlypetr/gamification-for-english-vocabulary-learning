import 'package:auto_route/auto_route.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:english_mind_demo/ui/hooks/managers/managers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FlashcardScaffold extends HookWidget {
  final Widget buttons;
  final VoidCallback? onPrevious;
  final EmFlashcardType flashcardType;

  const FlashcardScaffold({
    required this.buttons,
    required this.flashcardType,
    this.onPrevious,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final manager = useStudyManager();

    return EmFlashcardScaffold(
      buttons: buttons,
      onSettings: () {},
      onClose: context.back,
      flashcardType: flashcardType,
      totalCards: manager.totalCards,
      currentCardIndex: manager.currentIndex,
      onPrevious: () {
        onPrevious?.call();
        manager.previous();
      },
    );
  }
}
