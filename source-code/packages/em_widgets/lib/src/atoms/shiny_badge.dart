import 'package:flutter/material.dart';

enum EmShinyBadgeVariant { gold, faded }

class EmShinyBadge extends StatelessWidget {
  static const _borderWidth = 5.0;

  final Widget child;
  final EmShinyBadgeVariant variant;

  const EmShinyBadge({
    required this.child,
    this.variant = EmShinyBadgeVariant.gold,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final (bgColor, borderColor, stripeColor) = switch (variant) {
      EmShinyBadgeVariant.gold => (
          Colors.amber,
          Colors.amber.withAlpha(100),
          Colors.white.withAlpha(40),
        ),
      EmShinyBadgeVariant.faded => (
          Colors.grey.shade400,
          Colors.grey.shade400.withAlpha(100),
          Colors.grey.shade200.withAlpha(40),
        ),
    };

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            margin: const EdgeInsets.all(_borderWidth),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: borderColor,
                width: _borderWidth,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: ShaderMask(
                blendMode: BlendMode.srcOver,
                shaderCallback: (bounds) => LinearGradient(
                  end: const Alignment(2.0, 0.5),
                  begin: const Alignment(-2.0, -0.5),
                  transform: const GradientRotation(0.5),
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    stripeColor,
                    stripeColor,
                    Colors.transparent,
                    Colors.transparent,
                    stripeColor,
                    stripeColor,
                    Colors.transparent,
                    Colors.transparent,
                    stripeColor,
                    stripeColor,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  stops: const [
                    0.0, 0.34, // first stripe
                    0.34, 0.37, // second stripe
                    0.37, 0.385, // third stripe
                    0.385, 0.45, // fourth stripe
                    0.45, 0.58, // fifth stripe
                    0.58, 0.65, // sixth stripe
                    0.65, 1.0, // seventh stripe
                  ],
                ).createShader(bounds),
                child: ShaderMask(
                  blendMode: BlendMode.srcOver,
                  shaderCallback: (bounds) => LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      bgColor,
                      bgColor.withAlpha(180),
                      bgColor,
                      bgColor.withAlpha(160),
                      bgColor,
                      bgColor.withAlpha(170),
                      bgColor,
                    ],
                    stops: const [0.0, 0.1, 0.3, 0.45, 0.6, 0.8, 0.9],
                  ).createShader(bounds),
                  child: ColoredBox(
                    color: Colors.white.withAlpha(1),
                    child: const SizedBox(),
                  ),
                ),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
