import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'default', type: Text, path: '[atoms]')
Widget buildTypographyUseCase(BuildContext context) {
  final typographyPairs = [
    ('Heading 1', context.textTheme.heading1),
    ('Heading 2', context.textTheme.heading2),
    ('Title 1', context.textTheme.title1),
    ('Title 2', context.textTheme.title2),
    ('Label L', context.textTheme.labelL),
    ('Label M', context.textTheme.labelM),
    ('Label S', context.textTheme.labelS),
    ('Button L', context.textTheme.buttonL),
    ('Button M', context.textTheme.buttonM),
    ('Button S', context.textTheme.buttonS),
    ('Caption', context.textTheme.caption),
    ('Footnote', context.textTheme.footnote),
  ];

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: typographyPairs
          .map(
            (pair) => Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '${pair.$1} - Příliš žluťoučký kůň úpěl ďábelské ódy.',
                style: pair.$2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
    ),
  );
}

@widgetbook.UseCase(name: 'default', type: EmCatEmoji, path: '[atoms]')
Widget buildCatEmojiUseCase(BuildContext context) {
  return EmCatEmoji(
    context.knobs.list(label: 'Emoji', options: CatEmoji.values),
    size: context.knobs.list(label: 'Size', options: CatEmojiSize.values),
  );
}

@widgetbook.UseCase(name: 'default', type: EmCatSticker, path: '[atoms]')
Widget buildCatStickerUseCase(BuildContext context) {
  return EmCatSticker(
    context.knobs.list(label: 'Sticker', options: CatSticker.values),
    size: context.knobs.list(label: 'Size', options: CatStickerSize.values),
  );
}

@widgetbook.UseCase(name: 'default', type: EmFlagIcon, path: '[atoms]')
Widget buildFlagIconUseCase(BuildContext context) {
  return EmFlagIcon(
    context.knobs.list(label: 'Flag', options: FlagIcon.values),
    size: context.knobs.list(label: 'Size', options: FlagIconSize.values),
  );
}

@widgetbook.UseCase(name: 'default', type: EmLabel, path: '[atoms]')
Widget buildLabelUseCase(BuildContext context) {
  final icons = [Icons.check, Icons.question_mark];

  return EmLabel(
    context.knobs.string(label: 'Label'),
    size: context.knobs.list(label: 'Size', options: LabelSize.values),
    prefixIcon: context.knobs.listOrNull(label: 'Prefix Icon', options: icons),
    suffixIcon: context.knobs.listOrNull(label: 'Suffix Icon', options: icons),
    color: context.knobs.color(
      label: 'Color',
      initialValue: context.colors.interactive.accent.primary,
    ),
    backgroundColor: context.knobs.colorOrNull(label: 'Background Color'),
  );
}

@widgetbook.UseCase(name: 'default', type: EmWordStatusLabel, path: '[atoms]')
Widget buildWordStatusLabelUseCase(BuildContext context) {
  return EmWordStatusLabel(
    count: 100,
    isLoading: context.knobs.boolean(label: 'Is Loading'),
    label: context.knobs.string(label: 'Label'),
    variant: context.knobs.list(
      label: 'Variant',
      options: WordStatusLabelVariant.values,
    ),
  );
}

@widgetbook.UseCase(name: 'default', type: EmCircularIcon, path: '[atoms]')
Widget buildCircularIconUseCase(BuildContext context) {
  return EmCircularIcon(
    Icons.check,
    variant: context.knobs.list(
      label: 'Variant',
      options: EmCircularIconVariant.values,
    ),
  );
}

@widgetbook.UseCase(name: 'default', type: EmFeedbackLabel, path: '[atoms]')
Widget buildFeedbackLabelUseCase(BuildContext context) {
  return EmFeedbackLabel(
    text: context.knobs.string(label: 'Text', initialValue: 'Correct!'),
    variant: context.knobs.list(
      label: 'Variant',
      options: FeedbackLabelVariant.values,
    ),
  );
}

@widgetbook.UseCase(name: 'default', type: EmShinyBadge, path: '[atoms]')
Widget buildShinyBadgeUseCase(BuildContext context) {
  return const EmShinyBadge(child: SizedBox.square(dimension: 200));
}
