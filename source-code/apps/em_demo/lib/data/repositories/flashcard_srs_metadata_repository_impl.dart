import 'dart:math';

import 'package:english_mind_demo/data/models/flashcard_srs_metadata.dart';
import 'package:english_mind_demo/domain/repositories/flashcard_srs_metadata_repository.dart';

class FlashcardMetadataRepositoryMockImpl extends FlashcardMetadataRepository {
  @override
  Future<List<FlashcardSrsMetadata>> getDueNowFlashcardMetadataList() async {
    const maxFid = 3_000;
    const fidInterval = 100;
    const mockData = {
      0: (0, 0), // First review
      1: (0, 1), // First review
      2: (0, 2), // First review
      3: (0, 6), // First review
      4: (0, 7), // First review
      5: (1440, 1), // 1 day
      6: (2880, 2), // 2 days
      7: (4320, 3), // 3 days
      8: (5760, 4), // 4 days
      9: (10080, 2), // 1 week
      10: (20160, 3), // 2 weeks
      11: (30240, 4), // 3 weeks
      12: (40320, 5), // 4 weeks
      13: (50400, 6), // 5 weeks
      14: (60480, 7), // 6 weeks
      15: (302400, 8), // 7 months
      16: (0, 0),
      17: (0, 0),
    };

    final dueNowFids = List.generate(
      Random().nextInt(7) + 1,
      (index) => (maxFid - fidInterval) + Random().nextInt(fidInterval),
    ).toSet().toList();

    final result = dueNowFids.map((fid) {
      final randomData = mockData[Random().nextInt(mockData.length)]!;
      final (interval, seenIndex) = randomData;

      return FlashcardSrsMetadata(
        fid: fid,
        interval: interval,
        seenIndex: seenIndex,
      );
    }).toList();

    // Add a new word for streak activation purposes
    while (true) {
      final newFid = (maxFid - fidInterval) + Random().nextInt(fidInterval);
      if (!dueNowFids.contains(newFid)) {
        result.add(
          FlashcardSrsMetadata(
            fid: newFid,
            startedLearningAt: DateTime.now(),
          ),
        );
        break;
      }
    }

    return result;
  }
}
