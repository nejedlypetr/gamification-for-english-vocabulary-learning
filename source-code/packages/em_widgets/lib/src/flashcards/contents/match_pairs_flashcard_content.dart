import 'dart:async';

import 'package:collection/collection.dart';
import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MatchPair {
  final String item1;
  final String item2;

  const MatchPair({required this.item1, required this.item2});
}

class EmMatchPairsFlashcardContent extends EmFlashcardContent {
  final String instructions;
  final List<MatchPair> pairs;
  final bool equalColumnWidths;
  final VoidCallback? onMatchComplete;

  const EmMatchPairsFlashcardContent({
    required this.pairs,
    required this.instructions,
    this.onMatchComplete,
    this.equalColumnWidths = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _MatchPairsGame(
      pairs: pairs,
      instructions: instructions,
      onMatchComplete: onMatchComplete,
      equalColumnWidths: equalColumnWidths,
    );
  }
}

class _MatchPairsGame extends HookWidget {
  final String instructions;
  final List<MatchPair> pairs;
  final bool equalColumnWidths;
  final VoidCallback? onMatchComplete;

  const _MatchPairsGame({
    required this.pairs,
    required this.instructions,
    required this.equalColumnWidths,
    this.onMatchComplete,
  });

  @override
  Widget build(BuildContext context) {
    final selectedLeftItem = useState<String?>(null);
    final selectedRightItem = useState<String?>(null);
    final matchedPairs = useState<Set<MatchPair>>({});

    final incorrectTimer = useState<Timer?>(null);
    final incorrectPair = useState<({String left, String right})?>(null);

    final leftItems = useMemoized(
      () => pairs.map((pair) => pair.item1).toList()..shuffle(),
      [pairs],
    );
    final rightItems = useMemoized(
      () => pairs.map((pair) => pair.item2).toList()..shuffle(),
      [pairs],
    );

    useEffect(
      () {
        return () => incorrectTimer.value?.cancel();
      },
      [],
    );

    void checkMatch() {
      final leftValue = selectedLeftItem.value;
      final rightValue = selectedRightItem.value;

      if (leftValue == null || rightValue == null) {
        return;
      }

      final matchingPair = pairs.firstWhereOrNull(
        (pair) => pair.item1 == leftValue && pair.item2 == rightValue,
      );

      if (matchingPair == null) {
        incorrectPair.value = (left: leftValue, right: rightValue);
        selectedLeftItem.value = null;
        selectedRightItem.value = null;

        incorrectTimer.value?.cancel();
        incorrectTimer.value = Timer(const Duration(milliseconds: 1000), () {
          incorrectPair.value = null;
        });
        return;
      }

      matchedPairs.value = {...matchedPairs.value, matchingPair};
      selectedLeftItem.value = null;
      selectedRightItem.value = null;

      if (matchedPairs.value.length == pairs.length) {
        onMatchComplete?.call();
      }
    }

    void toggleLeftItem(String item) {
      if (selectedLeftItem.value == item) {
        selectedLeftItem.value = null;
        return;
      }
      selectedLeftItem.value = item;
      checkMatch();
    }

    void toggleRightItem(String item) {
      if (selectedRightItem.value == item) {
        selectedRightItem.value = null;
        return;
      }
      selectedRightItem.value = item;
      checkMatch();
    }

    MatchButtonVariant getButtonVariant(
      String item,
      String? selectedItem,
      bool Function(MatchPair) matchCheck,
    ) {
      if (matchedPairs.value.any(matchCheck)) {
        return MatchButtonVariant.correct;
      }

      final currentIncorrectPair = incorrectPair.value;
      if (currentIncorrectPair != null) {
        final leftMatch = matchCheck(
          MatchPair(item1: currentIncorrectPair.left, item2: ''),
        );
        final rightMatch = matchCheck(
          MatchPair(item1: '', item2: currentIncorrectPair.right),
        );

        if (leftMatch || rightMatch) {
          return MatchButtonVariant.incorrect;
        }
      }

      return selectedItem == item
          ? MatchButtonVariant.active
          : MatchButtonVariant.normal;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16).copyWith(bottom: 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              instructions,
              overflow: TextOverflow.ellipsis,
              style: context.theme.textTheme.labelS,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12).copyWith(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      for (final item in leftItems)
                        EmMatchButton(
                          text: item,
                          onPressed: () => toggleLeftItem(item),
                          isDisabled: incorrectPair.value != null,
                          variant: getButtonVariant(
                            item,
                            selectedLeftItem.value,
                            (pair) => pair.item1 == item,
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: equalColumnWidths ? 1 : 2,
                  child: Column(
                    children: [
                      for (final item in rightItems)
                        EmMatchButton(
                          text: item,
                          onPressed: () => toggleRightItem(item),
                          isDisabled: incorrectPair.value != null,
                          variant: getButtonVariant(
                            item,
                            selectedRightItem.value,
                            (pair) => pair.item2 == item,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
