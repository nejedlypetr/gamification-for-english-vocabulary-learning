import 'dart:async';
import 'dart:math';

import 'package:em_vocabulary/em_vocabulary.dart';
import 'package:english_mind_demo/domain/entities/study/flashcard_data.dart';
import 'package:english_mind_demo/domain/managers/streak_manager.dart';
import 'package:english_mind_demo/domain/repositories/flashcard_srs_metadata_repository.dart';
import 'package:flutter/foundation.dart';

class StudyManager {
  int _currentIndex = 0;
  int _totalUniqueWords = 0;
  bool _showStreakScreen = false;
  final Stopwatch _stopwatch;
  final StreakManager _streakManager;
  final VocabularyRepository _vocabularyRepo;
  final FlashcardMetadataRepository _metadataRepo;
  final List<FlashcardData> _flashcardDataList;
  final _isFinishedNotifier = ValueNotifier<bool>(false);
  final _flashcardDataNotifier = ValueNotifier<FlashcardData?>(null);

  int get currentIndex => _currentIndex;
  int get totalUniqueWords => _totalUniqueWords;
  bool get showStreakScreen => _showStreakScreen;
  Duration get timeElapsed => _stopwatch.elapsed;
  int get totalCards => _flashcardDataList.length;
  bool get hasPreviousFlashcard => _currentIndex > 0;
  bool get hasNextFlashcard => _currentIndex < _flashcardDataList.length - 1;
  bool get isLastFlashcard => _currentIndex == _flashcardDataList.length - 1;
  ValueNotifier<bool> get isFinishedNotifier => _isFinishedNotifier;
  ValueNotifier<FlashcardData?> get flashcardDataNotifier =>
      _flashcardDataNotifier;

  StudyManager({
    required StreakManager streakManager,
    required VocabularyRepository vocabularyRepository,
    required FlashcardMetadataRepository flashcardMetadataRepository,
  })  : _flashcardDataList = [],
        _stopwatch = Stopwatch(),
        _streakManager = streakManager,
        _vocabularyRepo = vocabularyRepository,
        _metadataRepo = flashcardMetadataRepository;

  Future<void> init() async {
    reset();

    final random = Random();
    final matchingDefinitionsBuffer = <VocabularyEntry>[];
    final matchingTranslationsBuffer = <VocabularyEntry>[];
    final spellingFlashcardBuffer = <SpellingFlashcardData>[];
    final pronunciationFlashcardBuffer = <PronunciationFlashcardData>[];
    final dueNowMetadata = await _metadataRepo.getDueNowFlashcardMetadataList();
    _totalUniqueWords = dueNowMetadata.length;

    for (final metadata in dueNowMetadata) {
      final entry = await _vocabularyRepo.getVocabularyEntry(metadata.fid);
      if (entry == null) {
        continue;
      }

      // Recall flashcard
      _flashcardDataList.add(
        RecallFlashcardData(entry: entry, metadata: metadata),
      );

      // Match definitions flashcard
      matchingDefinitionsBuffer.add(entry);
      if (matchingDefinitionsBuffer.length >= 4) {
        _flashcardDataList.add(
          MatchDefinitionsFlashcardData(List.from(matchingDefinitionsBuffer)),
        );
        matchingDefinitionsBuffer.clear();
      }

      // Match translations flashcard
      matchingTranslationsBuffer.add(entry);
      if ((matchingTranslationsBuffer.length >= 4 &&
              metadata == dueNowMetadata.last) ||
          matchingTranslationsBuffer.length >= 5) {
        _flashcardDataList.add(
          MatchTranslationsFlashcardData(List.from(matchingTranslationsBuffer)),
        );
        matchingTranslationsBuffer.clear();
      }

      // Pronunciation flashcard
      if (pronunciationFlashcardBuffer.isNotEmpty) {
        _flashcardDataList.add(pronunciationFlashcardBuffer.first);
        pronunciationFlashcardBuffer.clear();
      }
      if (metadata.seenIndex < 3) {
        if (random.nextInt(3) == 0) {
          pronunciationFlashcardBuffer.add(PronunciationFlashcardData(entry));
        }
      }

      // Spelling flashcard
      if (spellingFlashcardBuffer.isNotEmpty) {
        _flashcardDataList.add(spellingFlashcardBuffer.first);
        spellingFlashcardBuffer.clear();
      }
      if (metadata.seenIndex > 2) {
        if (random.nextInt(3) == 0) {
          spellingFlashcardBuffer.add(SpellingFlashcardData(entry));
        }
      }
    }

    if (_flashcardDataList.isNotEmpty) {
      _stopwatch.start();
      _flashcardDataNotifier.value = _flashcardDataList[_currentIndex];
    }
  }

  void reset() {
    _stopwatch.reset();
    _currentIndex = 0;
    _totalUniqueWords = 0;
    _flashcardDataList.clear();
    _flashcardDataNotifier.value = null;
    _isFinishedNotifier.value = false;
    _showStreakScreen = false;
  }

  void next() {
    if (isLastFlashcard) {
      _stopwatch.stop();
      _isFinishedNotifier.value = true;
    }

    if (hasNextFlashcard) {
      updateStreak();

      _currentIndex++;
      _flashcardDataNotifier.value = _flashcardDataList[_currentIndex];
    }
  }

  void previous() {
    if (hasPreviousFlashcard) {
      _currentIndex--;
      _flashcardDataNotifier.value = _flashcardDataList[_currentIndex];
    }
  }

  Future<void> updateStreak() async {
    final currentFlashcard = _flashcardDataList[_currentIndex];
    if (currentFlashcard is RecallFlashcardData) {
      final isIncreased =
          await _streakManager.updateStreak(currentFlashcard.metadata);

      if (isIncreased) {
        _showStreakScreen = true;
      }
    }
  }
}
