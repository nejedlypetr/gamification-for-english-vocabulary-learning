import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:em_vocabulary/em_vocabulary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class VocabularyRepositoryImpl implements VocabularyRepository {
  static const _assetPath =
      'packages/em_vocabulary/assets/json/dictionary.json';

  List<VocabularyEntry>? _cachedEntries;

  VocabularyRepositoryImpl();

  Future<List<VocabularyEntry>> _loadVocabularyData() async {
    if (_cachedEntries != null) {
      return _cachedEntries!;
    }

    try {
      final jsonString = await rootBundle.loadString(_assetPath);
      final jsonList = json.decode(jsonString) as List<dynamic>;
      _cachedEntries = VocabularyEntry.listFromJson(jsonList);
      return _cachedEntries!;
    } catch (e) {
      debugPrint('Error loading vocabulary data: $e');
      return [];
    }
  }

  @override
  Future<void> initialize() async {
    await _loadVocabularyData();
  }

  @override
  Future<VocabularyEntry?> getVocabularyEntry(int fid) async {
    final entries = await _loadVocabularyData();
    return entries.firstWhereOrNull((entry) => entry.fid == fid);
  }

  @override
  Future<List<VocabularyEntry>> getVocabularyEntries(List<int> ids) async {
    final entries = await _loadVocabularyData();
    return entries.where((entry) => ids.contains(entry.fid)).toList();
  }

  @override
  Future<List<VocabularyEntry>> getAllVocabularyEntries() async {
    return _loadVocabularyData();
  }
}
