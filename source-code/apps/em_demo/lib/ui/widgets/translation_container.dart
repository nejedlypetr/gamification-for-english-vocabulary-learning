import 'package:em_widgets/em_widgets.dart';
import 'package:english_mind_demo/ui/hooks/translation/use_translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TranslationContainer extends HookWidget {
  final String word;

  const TranslationContainer({required this.word, super.key});

  @override
  Widget build(BuildContext context) {
    final (_, translation) = useTranslation(word);

    return EmTranslationContainer(
      flagIcon: FlagIcon.czechRepublic,
      translations: translation?.translations ?? [],
    );
  }
}
