import 'package:auto_route/auto_route.dart';
import 'package:english_mind_demo/core/routes/app_router.gr.dart';
import 'package:english_mind_demo/ui/hooks/managers/managers.dart';
import 'package:english_mind_demo/ui/screens/study/widgets/after_practice_stats.dart';
import 'package:english_mind_demo/ui/screens/study/widgets/after_practice_streak.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AfterPracticeReview extends HookWidget {
  const AfterPracticeReview({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = useStudyManager();
    final showStreakScreenState = useState(false);

    return showStreakScreenState.value
        ? AfterPracticeStreak(
            onFinish: () => context.router.replaceAll([const HomeRoute()]),
          )
        : AfterPracticeStats(
            onFinish: () {
              final showStreakScreen = manager.showStreakScreen;
              if (showStreakScreen) {
                showStreakScreenState.value = true;
              } else {
                context.router.replaceAll([const HomeRoute()]);
              }
            },
          );
  }
}
