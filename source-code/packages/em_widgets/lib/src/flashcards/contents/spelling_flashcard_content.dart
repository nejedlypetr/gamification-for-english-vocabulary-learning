import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

enum EmSpellingFlashcardContentVariant {
  normal,
  success,
  error;

  PrimaryButtonVariant toButtonVariant() => switch (this) {
        error => PrimaryButtonVariant.errorDark,
        normal => PrimaryButtonVariant.neutralDark,
        success => PrimaryButtonVariant.successDark,
      };

  EmFillBlankTextFieldVariant toTextFieldVariant() => switch (this) {
        error => EmFillBlankTextFieldVariant.error,
        normal => EmFillBlankTextFieldVariant.normal,
        success => EmFillBlankTextFieldVariant.success,
      };
}

class EmSpellingFlashcardContent extends EmFlashcardContent {
  final int fid;
  final String ipa;
  final String word;
  final String hintText;
  final String definition;
  final String instructions;
  final FocusNode focusNode;
  final String errorFeedback;
  final String successFeedback;
  final String exampleSentence;
  final VoidCallback onSubmitted;
  final VoidCallback onAudioPressed;
  final TextEditingController? textController;
  final EmSpellingFlashcardContentVariant variant;

  const EmSpellingFlashcardContent({
    required this.fid,
    required this.ipa,
    required this.word,
    required this.hintText,
    required this.focusNode,
    required this.definition,
    required this.onSubmitted,
    required this.instructions,
    required this.errorFeedback,
    required this.onAudioPressed,
    required this.successFeedback,
    required this.exampleSentence,
    this.variant = EmSpellingFlashcardContentVariant.error,
    this.textController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final labelWidget = switch (variant) {
      EmSpellingFlashcardContentVariant.normal => SizedBox(
          height: 24,
          child: Text(
            instructions,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.labelS,
          ),
        ),
      EmSpellingFlashcardContentVariant.success => EmFeedbackLabel(
          text: successFeedback,
          variant: FeedbackLabelVariant.success,
        ),
      EmSpellingFlashcardContentVariant.error => EmFeedbackLabel(
          text: errorFeedback,
          variant: FeedbackLabelVariant.error,
        ),
    };

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          GestureDetector(
            onTap: focusNode.unfocus,
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                if (!focusNode.hasFocus) ...[
                  Align(alignment: Alignment.topLeft, child: labelWidget),
                  const SizedBox.square(dimension: 32),
                  EmVocabularyImage(fid: fid, dimension: 100),
                  const SizedBox.square(dimension: 16),
                  Text(
                    variant == EmSpellingFlashcardContentVariant.normal
                        ? ''
                        : word,
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.heading1,
                  ),
                ],
                SizedBox.square(dimension: focusNode.hasFocus ? 4 : 32),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    definition,
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.labelM.medium,
                  ),
                ),
                SizedBox.square(dimension: focusNode.hasFocus ? 12 : 28),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                EmFillBlankTextField(
                  word: word,
                  focusNode: focusNode,
                  onSubmitted: onSubmitted,
                  sentence: exampleSentence,
                  controller: textController,
                  variant: variant.toTextFieldVariant(),
                ),
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: EmPrimaryButton(
                    isFullWidth: false,
                    size: PrimaryButtonSize.s,
                    onPressed: onAudioPressed,
                    variant: variant.toButtonVariant(),
                    prefixIcon: HeroiconsOutline.speakerWave,
                    text: variant == EmSpellingFlashcardContentVariant.normal
                        ? hintText
                        : '/$ipa/',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
