import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

enum WordProgressTrackerStage { stage1, stage2, stage3, stage4, stage5 }

class EmWordProgressTracker extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final WordProgressTrackerStage stage;

  const EmWordProgressTracker({
    required this.label,
    required this.stage,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors.progressTracker;
    final (icon, color, backgroundColor) = switch (stage) {
      WordProgressTrackerStage.stage1 => (
          HeroiconsSolid.sparkles,
          colors.stage1,
          colors.stage1Alpha
        ),
      WordProgressTrackerStage.stage2 => (
          HeroiconsSolid.magnifyingGlassCircle,
          colors.stage2,
          colors.stage2Alpha
        ),
      WordProgressTrackerStage.stage3 => (
          HeroiconsSolid.lightBulb,
          colors.stage3,
          colors.stage3Alpha
        ),
      WordProgressTrackerStage.stage4 => (
          HeroiconsSolid.checkBadge,
          colors.stage4,
          colors.stage4Alpha
        ),
      WordProgressTrackerStage.stage5 => (
          HeroiconsSolid.academicCap,
          colors.stage5,
          colors.stage5Alpha
        ),
    };

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: context.textScalerScale(8),
        children: [
          EmCircularIcon(
            icon,
            iconColor: color,
            backgroundColor: backgroundColor,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelS.bold.withColor(color),
              ),
              Row(
                spacing: context.textScalerScale(4),
                children: List.generate(
                  WordProgressTrackerStage.values.length,
                  (index) => Container(
                    width: context.textScalerScale(16),
                    height: context.textScalerScale(6),
                    decoration: BoxDecoration(
                      color: index <= stage.index ? color : backgroundColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
