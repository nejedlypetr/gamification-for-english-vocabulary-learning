import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

enum EmPronunciationFlashcardContentVariant { initial, correct, incorrect }

class EmPronunciationFlashcardContent extends EmFlashcardContent {
  final int fid;
  final String ipa;
  final String word;
  final String instructions;
  final String feedbackCorrect;
  final String feedbackIncorrect;
  final VoidCallback onPronounce;
  final List<String> partOfSpeechList;
  final EmPronunciationFlashcardContentVariant variant;

  const EmPronunciationFlashcardContent({
    required this.fid,
    required this.ipa,
    required this.word,
    required this.variant,
    required this.onPronounce,
    required this.instructions,
    required this.feedbackCorrect,
    required this.partOfSpeechList,
    required this.feedbackIncorrect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final labelWidget = switch (variant) {
      EmPronunciationFlashcardContentVariant.initial => SizedBox(
          height: 24,
          child: Text(
            instructions,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.labelS,
          ),
        ),
      EmPronunciationFlashcardContentVariant.correct => EmFeedbackLabel(
          text: feedbackCorrect,
          variant: FeedbackLabelVariant.success,
        ),
      EmPronunciationFlashcardContentVariant.incorrect => EmFeedbackLabel(
          text: feedbackIncorrect,
          variant: FeedbackLabelVariant.error,
        ),
    };

    final pronunciationButton = switch (variant) {
      EmPronunciationFlashcardContentVariant.incorrect => EmPrimaryButton(
          text: '/$ipa/',
          isFullWidth: false,
          onPressed: onPronounce,
          size: PrimaryButtonSize.m,
          variant: PrimaryButtonVariant.error,
          prefixIcon: HeroiconsOutline.speakerWave,
        ),
      EmPronunciationFlashcardContentVariant.correct => EmPrimaryButton(
          text: '/$ipa/',
          isFullWidth: false,
          onPressed: onPronounce,
          size: PrimaryButtonSize.m,
          variant: PrimaryButtonVariant.success,
          prefixIcon: HeroiconsOutline.speakerWave,
        ),
      _ => const SizedBox(height: 48),
    };

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Align(alignment: Alignment.topLeft, child: labelWidget),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EmVocabularyImage(fid: fid, dimension: 100),
                Column(
                  spacing: 8,
                  children: [
                    Text(
                      word,
                      textAlign: TextAlign.center,
                      style: context.theme.textTheme.heading1.copyWith(
                        fontSize: 38,
                      ),
                    ),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      alignment: WrapAlignment.center,
                      children: [
                        for (final partOfSpeech in partOfSpeechList)
                          EmLabel(
                            partOfSpeech,
                            size: LabelSize.s,
                            color: context.colors.feedback.info.primary,
                          ),
                      ],
                    ),
                  ],
                ),
                pronunciationButton,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
