import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

enum AccentPreference {
  american(1, 'us'),
  british(2, 'br');

  final int _id;
  final String _code;

  int get id => _id;
  String get code => _code;
  const AccentPreference(this._id, this._code);

  static AccentPreference? fromId(int id) {
    return values.firstWhereOrNull((accent) => accent._id == id);
  }
}

class VocabularyEntry {
  final int _fid;
  final String _word;
  final String? _note;
  final List<String> _partOfSpeech;
  final List<Definition> _definitions;
  final List<Pronunciation> _ukPronunciation;
  final List<Pronunciation> _usPronunciation;

  int get fid => _fid;
  String get word => _word;
  String? get note => _note;
  List<String> get partOfSpeech => List.unmodifiable(_partOfSpeech);
  List<Definition> get definitions => List.unmodifiable(_definitions);
  List<Pronunciation> get ukPronunciation =>
      List.unmodifiable(_ukPronunciation);
  List<Pronunciation> get usPronunciation =>
      List.unmodifiable(_usPronunciation);

  VocabularyEntry({
    required int fid,
    required String word,
    required List<String> partOfSpeech,
    required List<Definition> definitions,
    required List<Pronunciation> ukPronunciation,
    required List<Pronunciation> usPronunciation,
    String? note,
  })  : _fid = fid,
        _word = word,
        _note = note,
        _definitions = definitions,
        _partOfSpeech = partOfSpeech,
        _ukPronunciation = ukPronunciation,
        _usPronunciation = usPronunciation;

  List<Pronunciation> getPronunciation(AccentPreference accent) {
    return switch (accent) {
      AccentPreference.british => ukPronunciation,
      AccentPreference.american => usPronunciation,
    };
  }

  factory VocabularyEntry.fromJson(Map<String, dynamic> json) {
    final pronunciation = json['pronunciation'] as Map<String, dynamic>? ?? {};

    return VocabularyEntry(
      fid: json['fid'] as int,
      word: json['word'] as String,
      note: json['note'] as String?,
      partOfSpeech:
          (json['partOfSpeech'] as List<dynamic>?)?.cast<String>() ?? [],
      definitions:
          Definition.listFromJson(json['definitions'] as List<dynamic>?),
      ukPronunciation:
          Pronunciation.listFromJson(pronunciation['br'] as List<dynamic>?),
      usPronunciation:
          Pronunciation.listFromJson(pronunciation['us'] as List<dynamic>?),
    );
  }

  static List<VocabularyEntry> listFromJson(List<dynamic>? json) {
    if (json == null) {
      return [];
    }

    final entries = <VocabularyEntry>[];
    for (final item in json) {
      try {
        entries.add(VocabularyEntry.fromJson(item as Map<String, dynamic>));
      } catch (e) {
        debugPrint('Failed to parse vocabulary entry: $item');
        debugPrint('Error: $e');
      }
    }
    return entries;
  }

  @override
  String toString() {
    return 'VocabularyEntry(fid: $_fid, word: $_word, note: $_note, '
        'partOfSpeech: $_partOfSpeech, definitions: $_definitions, '
        'ukPronunciation: $_ukPronunciation, '
        'usPronunciation: $_usPronunciation)';
  }
}

class Definition {
  static const String _defaultDefinition = '404, definition not found';

  final String _definition;
  final List<String> _examples;

  String get definition => _definition;
  List<String> get examples => _examples;

  Definition({
    required String definition,
    required List<String> examples,
  })  : _examples = examples,
        _definition = definition;

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(
      definition: json['definition'] as String? ?? _defaultDefinition,
      examples: (json['examples'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  static List<Definition> listFromJson(List<dynamic>? json) {
    return json
            ?.map((e) => Definition.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  @override
  String toString() {
    return 'Definition(definition: $_definition, examples: $_examples)';
  }
}

class Pronunciation {
  static const String _defaultIpa = '404, IPA not found';

  final String _ipa;
  final String? _audio;

  String get ipa => _ipa;
  String? get audio => _audio;

  Pronunciation({
    required String ipa,
    String? audio,
  })  : _ipa = ipa,
        _audio = audio;

  factory Pronunciation.fromJson(Map<String, dynamic> json) {
    return Pronunciation(
      audio: json['audio'] as String?,
      ipa: json['ipa'] as String? ?? _defaultIpa,
    );
  }

  static List<Pronunciation> listFromJson(List<dynamic>? json) {
    return json
            ?.map((e) => Pronunciation.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  @override
  String toString() {
    return 'Pronunciation(ipa: $_ipa, audio: $_audio)';
  }
}
