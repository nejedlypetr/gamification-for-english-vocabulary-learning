import 'package:em_theme/em_theme.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class EmSelectListItem extends StatelessWidget {
  final String text;
  final Widget? leading;
  final bool isSelected;
  final VoidCallback onPressed;

  const EmSelectListItem({
    required this.text,
    required this.onPressed,
    required this.isSelected,
    this.leading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final leadingWidget = leading;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colors.background.inverted,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 3,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: isSelected
                ? context.colors.feedback.warning.primary
                : Colors.transparent,
          ),
        ),
        child: Row(
          spacing: 16,
          children: [
            if (leadingWidget != null) leadingWidget,
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelL.medium,
              ),
            ),
            if (isSelected)
              Icon(
                HeroiconsSolid.checkCircle,
                color: context.colors.feedback.warning.primary,
              ),
          ],
        ),
      ),
    );
  }
}
