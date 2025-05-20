import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:english_mind_demo/core/extensions/extensions.dart';
import 'package:english_mind_demo/core/l10n/app_localizations.g.dart';
import 'package:english_mind_demo/ui/hooks/managers/managers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AfterPracticeStats extends HookWidget {
  final void Function() onFinish;

  const AfterPracticeStats({
    required this.onFinish,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final manager = useStudyManager();
    final confettiController = useMemoized(
      () => ConfettiController(duration: const Duration(milliseconds: 1400)),
    );

    useEffect(
      () {
        Future.delayed(
          const Duration(milliseconds: 400),
          confettiController.play,
        );

        return confettiController.dispose;
      },
      [confettiController],
    );

    final (title, subtitle) = _getRandomTitleAndSubtitle(context.l10n);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SafeArea(
          minimum: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ).copyWith(bottom: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              const EmCatSticker(CatSticker.diploma, size: CatStickerSize.xl),
              EmFlashcardSessionStatistics(
                title: title,
                subtitle: subtitle,
                timeSpent: _formatDuration(manager.timeElapsed),
                wordsReviewed: manager.totalUniqueWords.toString(),
                timeSpentText: context.l10n.studySessionStatisticsStudyTime,
                wordsReviewedText:
                    context.l10n.studySessionStatisticsWordsReviewed,
              ),
              EmPrimaryButton(
                onPressed: onFinish,
                size: PrimaryButtonSize.xl,
                text: context.l10n.studySessionFinishButton,
              ),
            ],
          ),
        ),
        Positioned(
          top: 240,
          left: -5,
          child: ConfettiWidget(
            gravity: 0.13,
            numberOfParticles: 20,
            blastDirection: -1.05, // -pi / 3 = 120 degrees
            emissionFrequency: 0.1,
            confettiController: confettiController,
          ),
        ),
        Positioned(
          top: 240,
          right: -5,
          child: ConfettiWidget(
            gravity: 0.12,
            numberOfParticles: 20,
            blastDirection: -2.09, // 2 * -pi / 3 = 240 degrees
            emissionFrequency: 0.1,
            confettiController: confettiController,
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString();
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  (String, String) _getRandomTitleAndSubtitle(AppLocalizations l10n) {
    final random = Random();
    final titles = [
      l10n.studySessionStatisticsTitle1,
      l10n.studySessionStatisticsTitle2,
      l10n.studySessionStatisticsTitle3,
      l10n.studySessionStatisticsTitle4,
      l10n.studySessionStatisticsTitle5,
      l10n.studySessionStatisticsTitle6,
      l10n.studySessionStatisticsTitle7,
      l10n.studySessionStatisticsTitle8,
      l10n.studySessionStatisticsTitle9,
      l10n.studySessionStatisticsTitle10,
      l10n.studySessionStatisticsTitle11,
      l10n.studySessionStatisticsTitle12,
    ];
    final subtitles = [
      l10n.studySessionStatisticsSubtitle1,
      l10n.studySessionStatisticsSubtitle2,
      l10n.studySessionStatisticsSubtitle3,
      l10n.studySessionStatisticsSubtitle4,
      l10n.studySessionStatisticsSubtitle5,
      l10n.studySessionStatisticsSubtitle6,
      l10n.studySessionStatisticsSubtitle7,
      l10n.studySessionStatisticsSubtitle8,
      l10n.studySessionStatisticsSubtitle9,
      l10n.studySessionStatisticsSubtitle10,
      l10n.studySessionStatisticsSubtitle11,
      l10n.studySessionStatisticsSubtitle12,
    ];
    return (
      titles[random.nextInt(titles.length)],
      subtitles[random.nextInt(subtitles.length)],
    );
  }
}
