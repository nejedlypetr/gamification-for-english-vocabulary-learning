import 'dart:math' as math;

import 'package:em_theme/em_theme.dart';
import 'package:em_widgets/src/navigation/navigation_tab_bar.dart';
import 'package:flutter/material.dart';

const double kHomeBottomBarHeight = 82.0;
const double _kCircleRadius = 28.0; // Modify to change the notch size
const double _kNotchHeight = _kCircleRadius / 2;

class NotchNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<NavigationItem> items;

  const NotchNavigationBar({
    required this.onTap,
    required this.items,
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / items.length;
        final notchPosition =
            (itemWidth * currentIndex) + (itemWidth / 2) - _kCircleRadius;

        final height = kHomeBottomBarHeight + context.mq.padding.bottom;

        return SizedBox(
          height: height + _kNotchHeight,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: height,
                width: constraints.maxWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colors.background.inverted,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 16,
                        offset: Offset(-4, 0),
                        color: Color.fromRGBO(199, 199, 204, 0.32),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                left: notchPosition,
                bottom: height - _kCircleRadius,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 200),
                child: const _Notch(),
              ),
              SizedBox(
                height: height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    items.length,
                    (index) => _NavigationBarItem(
                      item: items[index],
                      onTap: () => onTap(index),
                      isSelected: currentIndex == index,
                      position: _NavigationBarItemPosition.fromIndex(
                        index,
                        items.length,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum _NavigationBarItemPosition {
  first,
  middle,
  last;

  static _NavigationBarItemPosition fromIndex(int index, int totalLength) {
    if (index == 0) {
      return first;
    } else if (index == totalLength - 1) {
      return last;
    }
    return middle;
  }
}

class _NavigationBarItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final NavigationItem item;
  final _NavigationBarItemPosition position;

  const _NavigationBarItem({
    required this.item,
    required this.onTap,
    required this.position,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? context.colors.interactive.accent.primary
        : context.colors.text.neutral.primary;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            const SizedBox(height: 2),
            TweenAnimationBuilder<double>(
              curve: Curves.easeInCubic,
              duration: const Duration(milliseconds: 280),
              tween: Tween<double>(begin: 0, end: isSelected ? -6 : 0),
              builder: (_, value, child) => Transform.translate(
                offset: Offset(0, value),
                child: child,
              ),
              child: Stack(
                children: [
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: TweenAnimationBuilder<double>(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 280),
                      tween: Tween<double>(begin: 0, end: isSelected ? 1 : 0),
                      builder: (_, value, child) => Stack(
                        children: [
                          Transform.scale(
                            scale: value,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.colors.feedback.warning.alpha,
                              ),
                              child: const SizedBox.expand(),
                            ),
                          ),
                          Center(
                            child: Icon(
                              isSelected
                                  ? (item.activeIcon ?? item.icon)
                                  : item.icon,
                              size: 24,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (item.indicator != null)
                    Positioned(
                      top: 6,
                      right: 6,
                      width: 18,
                      height: 18,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: isSelected
                                ? const Color(0xFFE8F6E5)
                                : context.colors.background.inverted,
                          ),
                          color: context.colors.feedback.error.primary,
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${item.indicator}',
                              style: context.textTheme.footnote.withColor(
                                context.colors.text.neutral.inverted,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.caption.medium.withColor(color),
            ),
          ],
        ),
      ),
    );
  }
}

class _Notch extends StatelessWidget {
  const _Notch();

  @override
  Widget build(BuildContext context) {
    const width = _kCircleRadius * 2;
    const height = _kCircleRadius;

    return CustomPaint(
      size: const Size(width, height),
      painter: _NotchPainter(
        width: width,
        height: height,
        color: context.colors.background.inverted,
      ),
    );
  }
}

class _NotchPainter extends CustomPainter {
  final Color color;
  final double width;
  final double height;

  const _NotchPainter({
    required this.color,
    required this.width,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final host = Rect.fromLTWH(0, 0, size.width, size.height);
    final guest = Rect.fromLTWH(
      size.width / 2 - width / 2,
      0,
      width,
      height,
    );

    final notchRadius = guest.width / 2.0;
    const s1 = 15.0;
    const s2 = 1.0;

    final r = notchRadius;
    final a = -1.0 * r - s2;
    final b = host.top - guest.center.dy;

    final n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final p2yA = -math.sqrt(r * r - p2xA * p2xA);
    final p2yB = -math.sqrt(r * r - p2xB * p2xB);

    final p = List<Offset>.filled(6, Offset.zero);
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    for (var i = 0; i < p.length; i += 1) {
      p[i] = p[i] + guest.center;
    }

    final path = Path()
      ..moveTo(p[0].dx, p[0].dy)
      ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
      ..arcToPoint(
        p[3],
        radius: Radius.circular(notchRadius),
      )
      ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
