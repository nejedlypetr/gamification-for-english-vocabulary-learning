import 'package:em_theme/em_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmVocabularyImage extends StatelessWidget {
  static const path = 'assets/svg/';
  static const package = 'em_vocabulary';

  final int fid;
  final double dimension;

  const EmVocabularyImage({
    required this.fid,
    required this.dimension,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: SvgPicture.asset(
        '$path$fid.svg',
        package: package,
        fit: BoxFit.fitHeight,
        alignment: Alignment.bottomCenter,
        errorBuilder: (context, error, stackTrace) {
          return Text(
            'Error:\nImage not found.',
            textAlign: TextAlign.center,
            style: context.theme.textTheme.footnote.medium.withColor(
              context.colors.feedback.error.primary,
            ),
          );
        },
      ),
    );
  }
}
