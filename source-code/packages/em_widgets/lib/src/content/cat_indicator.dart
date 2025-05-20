import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';

enum EmCatIndicatorStatus { inactive, active, warning, maximum }

class EmCatIndicator extends StatelessWidget {
  final int count;
  final EmCatIndicatorStatus status;

  const EmCatIndicator({
    required this.count,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final icon = switch (status) {
      EmCatIndicatorStatus.inactive => CatEmoji.sleep,
      EmCatIndicatorStatus.active => CatEmoji.smirk,
      EmCatIndicatorStatus.warning => CatEmoji.worry,
      EmCatIndicatorStatus.maximum => CatEmoji.tears,
    };

    final counterBackgroundColor = switch (status) {
      EmCatIndicatorStatus.inactive => context.colors.feedback.info.primary,
      EmCatIndicatorStatus.active => context.colors.feedback.info.primary,
      EmCatIndicatorStatus.warning => context.colors.feedback.error.primary,
      EmCatIndicatorStatus.maximum => Colors.black,
    };

    return FittedBox(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: EmCatEmoji(icon, alignment: Alignment.bottomCenter),
          ),
          if (count > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: counterBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                count.toString(),
                textAlign: TextAlign.center,
                style: context.theme.textTheme.caption.semiBold
                    .withColor(Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
