import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class EmRecallFrontFlashcardContent extends EmFlashcardContent {
  final int fid;
  final String word;
  final String instructions;
  final List<String> partOfSpeechList;

  const EmRecallFrontFlashcardContent({
    required this.fid,
    required this.word,
    required this.instructions,
    required this.partOfSpeechList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _EmRecallFrontFlashcardContentHook(
      fid: fid,
      word: word,
      instructions: instructions,
      partOfSpeechList: partOfSpeechList,
    );
  }
}

class _EmRecallFrontFlashcardContentHook extends HookWidget {
  final int fid;
  final String word;
  final String instructions;
  final List<String> partOfSpeechList;

  const _EmRecallFrontFlashcardContentHook({
    required this.fid,
    required this.word,
    required this.partOfSpeechList,
    required this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    final isImageBlurred = useState(true);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => isImageBlurred.value = false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                instructions,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.labelS,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox.square(
                    dimension: 160,
                    child: ClipRRect(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          EmVocabularyImage(fid: fid, dimension: 100),
                          // TODO: fix late application of blur effect with AnimatedSwitcher
                          // if (isImageBlurred.value)
                          //   BackdropFilter(
                          //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          //     child: const SizedBox.square(
                          //       dimension: 160,
                          //       child: ColoredBox(color: Colors.transparent),
                          //     ),
                          //   ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    word,
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.heading1.copyWith(
                      fontSize: 38,
                    ),
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmRecallBackFlashcardContent extends EmFlashcardContent {
  final int fid;
  final String word;
  final Widget translation;
  final String pronunciationIpa;
  final Widget wordProgressTracker;
  final String showMoreExamplesText;
  final List<String> partOfSpeechList;
  final List<EmDefinition> definitions;
  final VoidCallback onPronunciationPressed;

  const EmRecallBackFlashcardContent({
    required this.fid,
    required this.word,
    required this.translation,
    required this.definitions,
    required this.pronunciationIpa,
    required this.partOfSpeechList,
    required this.wordProgressTracker,
    required this.showMoreExamplesText,
    required this.onPronunciationPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(top: 0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Align(alignment: Alignment.topLeft, child: translation),
                  const SizedBox(height: 16),
                  EmVocabularyImage(fid: fid, dimension: 80),
                  const SizedBox(height: 16),
                  Text(
                    word,
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.heading1,
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 20),
                  DefinitionAndExamples(
                    word: word,
                    definitions: definitions,
                    showMoreText: showMoreExamplesText,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: wordProgressTracker,
                ),
              ),
              Flexible(
                child: EmPrimaryButton(
                  isFullWidth: false,
                  useNotoSansFont: true,
                  size: PrimaryButtonSize.s,
                  text: '/$pronunciationIpa/',
                  onPressed: onPronunciationPressed,
                  variant: PrimaryButtonVariant.neutral,
                  prefixIcon: HeroiconsOutline.speakerWave,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EmDefinition {
  final String definition;
  final List<String> examples;

  const EmDefinition({required this.definition, required this.examples});
}

class DefinitionAndExamples extends StatelessWidget {
  final String word;
  final String showMoreText;
  final List<EmDefinition> definitions;

  const DefinitionAndExamples({
    required this.word,
    required this.definitions,
    required this.showMoreText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (index, definition) in definitions.indexed)
          Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EmLabel(
                '${index + 1}',
                size: LabelSize.s,
                color: context.colors.feedback.neutral.primary,
              ),
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      definition.definition,
                      style: context.theme.textTheme.labelS.semiBold,
                    ),
                    if (definition.examples.isNotEmpty)
                      _ExampleText(
                        word: word,
                        example: definition.examples.first,
                      ),
                    if (definition.examples.length > 1) ...[
                      _ExpandableExamples(
                        word: word,
                        showMoreText: showMoreText,
                        examples: definition.examples.skip(1).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _ExpandableExamples extends HookWidget {
  final String word;
  final String showMoreText;
  final List<String> examples;

  const _ExpandableExamples({
    required this.word,
    required this.examples,
    required this.showMoreText,
  });

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final ctrl = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );

    useEffect(
      () {
        if (isExpanded.value) {
          ctrl.forward();
        }
        return null;
      },
      [isExpanded.value],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: CurvedAnimation(parent: ctrl, curve: Curves.easeOut),
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final example in examples)
                _ExampleText(word: word, example: example),
            ],
          ),
        ),
        if (examples.isNotEmpty && !isExpanded.value)
          GestureDetector(
            onTap: () => isExpanded.value = true,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                showMoreText,
                style: context.theme.textTheme.caption.medium.copyWith(
                  decoration: TextDecoration.underline,
                  color: context.colors.interactive.neutral.disabled,
                  decorationColor: context.colors.interactive.neutral.disabled,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ExampleText extends StatelessWidget {
  final String word;
  final String example;

  const _ExampleText({required this.word, required this.example});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 4),
        SizedBox(
          height: context.textScalerScale(20),
          child: SizedBox.square(
            dimension: context.textScalerScale(4),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.feedback.neutral.primary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: EmWordHighlighter(
            example,
            word: word,
            textStyle: context.theme.textTheme.labelS.regular,
            wordStyle: context.theme.textTheme.labelS.semiBold.withColor(
              context.colors.interactive.accent.primary,
            ),
          ),
        ),
      ],
    );
  }
}
