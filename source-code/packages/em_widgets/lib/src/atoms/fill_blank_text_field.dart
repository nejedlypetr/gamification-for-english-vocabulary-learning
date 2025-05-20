import 'package:em_theme/em_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum EmFillBlankTextFieldVariant { normal, success, error }

class EmFillBlankTextField extends HookWidget {
  final String word;
  final String sentence;
  final FocusNode focusNode;
  final VoidCallback onSubmitted;
  final TextEditingController? controller;
  final EmFillBlankTextFieldVariant variant;

  const EmFillBlankTextField({
    required this.word,
    required this.sentence,
    required this.focusNode,
    required this.onSubmitted,
    this.variant = EmFillBlankTextFieldVariant.normal,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final regex = RegExp(
      '(${word.capitalize()})',
      caseSensitive: word == word.capitalize(),
    );

    final match = regex.firstMatch(sentence);

    final parts = match == null
        ? ['Error occurred, type anything to continue', '']
        : [
            sentence.substring(0, match.start),
            sentence.substring(match.end),
          ];

    final beforeWords = useMemoized(
      () => parts[0].trim().split(' '),
      [sentence, word],
    );
    final afterWords = useMemoized(
      () => parts[1].trim().split(' '),
      [sentence, word],
    );

    final hasLeadingSpace = parts[1].startsWith(' ');

    final colors = context.theme.colors;
    final (color, bgColor) = switch (variant) {
      EmFillBlankTextFieldVariant.error => (
          colors.feedback.error.primary,
          colors.feedback.error.alpha,
        ),
      EmFillBlankTextFieldVariant.success => (
          colors.feedback.success.primary,
          colors.feedback.success.alpha,
        ),
      EmFillBlankTextFieldVariant.normal => (
          context.colors.interactive.neutral.primary.withAlpha(50),
          colors.background.lite,
        ),
    };

    return GestureDetector(
      onTap: focusNode.requestFocus,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 3),
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ...beforeWords.map(
              (word) => Text(
                '$word ',
                style: context.theme.textTheme.labelS.medium,
              ),
            ),
            IntrinsicWidth(
              child: TextField(
                autocorrect: false,
                focusNode: focusNode,
                controller: controller,
                enableSuggestions: false,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    onSubmitted();
                  }
                },
                enabled: variant == EmFillBlankTextFieldVariant.normal,
                cursorColor: context.theme.colors.feedback.warning.primary,
                style: context.theme.textTheme.labelS.medium.withColor(
                  context.theme.colors.feedback.warning.primary,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: '...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintStyle: context.theme.textTheme.labelS.medium.withColor(
                    context.theme.colors.interactive.neutral.disabled,
                  ),
                ),
              ),
            ),
            ...afterWords.asMap().entries.map(
                  (entry) => Text(
                    '${entry.key == 0 && hasLeadingSpace ? ' ' : ''}${entry.value} ',
                    style: context.theme.textTheme.labelS.medium,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
