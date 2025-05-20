class FlashcardSrsMetadata {
  final int _fid;
  final bool _learned; // true if interval passed the max interval
  final int _interval;
  final int _seenIndex; // total seen count
  final int _easeFactor;
  final DateTime? _reviewedAt;
  final DateTime _nextReviewAt;
  final DateTime _startedLearningAt;

  int get fid => _fid;
  bool get learned => _learned;
  int get interval => _interval;
  int get seenIndex => _seenIndex;
  int get easeFactor => _easeFactor;
  DateTime? get reviewedAt => _reviewedAt;
  DateTime get nextReviewAt => _nextReviewAt;
  DateTime get startedLearningAt => _startedLearningAt;

  FlashcardSrsMetadata({
    required int fid,
    int interval = 0,
    int seenIndex = 0,
    int easeFactor = 250,
    bool learned = false,
    DateTime? reviewedAt,
    DateTime? nextReviewAt,
    DateTime? startedLearningAt,
  })  : _fid = fid,
        _learned = learned,
        _interval = interval,
        _seenIndex = seenIndex,
        _reviewedAt = reviewedAt,
        _easeFactor = easeFactor,
        _startedLearningAt = startedLearningAt ?? DateTime.now(),
        _nextReviewAt =
            nextReviewAt ?? DateTime.now().subtract(const Duration(days: 1));
}
