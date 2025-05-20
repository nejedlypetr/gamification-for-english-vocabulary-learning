import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/em_widgets.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class EmBottomSheet extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget? prefixIcon;
  final bool usePaddingAroundContent;

  const EmBottomSheet({
    required this.title,
    required this.content,
    this.prefixIcon,
    this.usePaddingAroundContent = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final prefixIconWidget = prefixIcon;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 10,
            children: [
              if (prefixIconWidget != null) prefixIconWidget,
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelM,
                ),
              ),
              EmIconButton(
                HeroiconsSolid.xMark,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        const EmDivider(),
        if (usePaddingAroundContent)
          Padding(
            padding: const EdgeInsets.all(16).copyWith(
              bottom:
                  context.mq.viewInsets.bottom + context.mq.padding.bottom + 16,
            ),
            child: content,
          )
        else
          content,
      ],
    );
  }
}
