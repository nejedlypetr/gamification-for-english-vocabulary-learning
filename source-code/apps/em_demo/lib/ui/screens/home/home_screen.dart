import 'package:auto_route/auto_route.dart';
import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:english_mind_demo/core/extensions/extensions.dart';
import 'package:english_mind_demo/core/routes/app_router.gr.dart';
import 'package:english_mind_demo/ui/screens/home/widgets/streak_badge.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StreakBadge(),
              Text(
                context.l10n.demoAppTitle,
                style: context.textTheme.title2,
              ),
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          context.l10n.demoAppInstructions,
                          style: context.textTheme.labelS,
                        ),
                        const SizedBox.square(dimension: 12),
                      ],
                    ),
                  ),
                ),
              ),
              EmPrimaryButton(
                text: context.l10n.studyBtn,
                size: PrimaryButtonSize.xl,
                onPressed: () => context.router.push(const StudyRoute()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
