import 'package:em_theme/em_theme.dart';
import 'package:flutter/material.dart';

enum EmDividerVariant { horizontal, vertical }

class EmDivider extends StatelessWidget {
  final EmDividerVariant variant;

  const EmDivider({super.key, this.variant = EmDividerVariant.horizontal});

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      EmDividerVariant.horizontal => Divider(
          height: 2,
          thickness: 2,
          color: context.colors.background.lite,
        ),
      EmDividerVariant.vertical => VerticalDivider(
          width: 2,
          thickness: 2,
          color: context.colors.background.lite,
        ),
    };
  }
}
