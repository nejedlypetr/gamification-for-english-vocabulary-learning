import 'package:em_widgets/em_widgets.dart';

sealed class EmFlashcardType {
  const EmFlashcardType();

  EmFlashcardContent getContent();
}

class EmRecallFlashcard extends EmFlashcardType {
  final bool isShowingFront;
  final EmFlashcardContent front;
  final EmFlashcardContent back;

  const EmRecallFlashcard({
    required this.back,
    required this.front,
    required this.isShowingFront,
  });

  @override
  EmFlashcardContent getContent() => isShowingFront ? front : back;
}

class EmMatchDefinitionsFlashcard extends EmFlashcardType {
  final EmFlashcardContent content;

  const EmMatchDefinitionsFlashcard({required this.content});

  @override
  EmFlashcardContent getContent() => content;
}

class EmMatchTranslationsFlashcard extends EmFlashcardType {
  final EmFlashcardContent content;

  const EmMatchTranslationsFlashcard({required this.content});

  @override
  EmFlashcardContent getContent() => content;
}

class EmPronunciationFlashcard extends EmFlashcardType {
  final EmFlashcardContent content;

  const EmPronunciationFlashcard({required this.content});

  @override
  EmFlashcardContent getContent() => content;
}

class EmSpellingFlashcard extends EmFlashcardType {
  final EmFlashcardContent content;

  const EmSpellingFlashcard({required this.content});

  @override
  EmFlashcardContent getContent() => content;
}
